"""Swing recorder: press s, swing once, get one peak-aligned CSV.

The board streams IMU1,seq,us,Ax_raw,Ay_raw,Az_raw,Gx_raw,Gy_raw,Gz_raw at
104 Hz (+/-16 g, +/-2000 dps). The stream is read and buffered all the time.
Pressing s arms the detector for exactly one swing: the next rise of the gyro
magnitude through the threshold. The swing is cut at a fixed offset around its
gyro-magnitude peak, using buffered samples from before the key press, so all
training samples have the peak at the same position. The return motion after
the swing is not recorded because the detector disarms after one swing.
--auto instead re-arms by itself after every swing once the racket is still.

The racket firmware must find the peak the same way; the parameters are saved
in the session JSON under <outdir>/_streams.

Keys: s record one swing (again: cancel), l change label,
      u delete the last saved swing, q quit.
      With --auto, s starts/pauses continuous detection.

Default clip on the 104 Hz sample grid:
  model window 0.5 s = 52 samples, peak at index 31 (31 before, 20 after);
  jitter 0.04 s = 4 extra samples on each side plus 2 tail samples
  -> 62 samples per CSV. In Edge Impulse use window size 500 ms and window
  increase 40 ms: each CSV yields 3 windows with the peak at 35/31/27; the
  firmware classifies the middle alignment (peak at 31).

CSV timestamps are the nominal sample grid (index * 1000/104 ms), not measured
time, so training and firmware agree sample for sample even if the sensor's
oscillator is slightly off 104 Hz. Board timestamps and sequence numbers only
detect dropped samples; a swing that contains a gap is not saved.

The raw IMU1 stream is kept as *.imu1.log under <outdir>/_streams together with
the peak of every saved swing, so the saved swings can be re-cut later with
another window:
  python collect_training_data.py --recut recordings/_streams --window 0.6
The same streams also give NONE clips of what the firmware sees between
strokes (return motions after each saved stroke, unsaved NONE motions):
  python collect_training_data.py --extract-none recordings/_streams

Usage: python collect_training_data.py --port COM9 --label FS
Requires: python -m pip install pyserial
"""
import argparse
import csv
import json
import math
import re
import statistics
import sys
import time
import unicodedata
from collections import Counter, deque
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path

try:
    import serial
    import serial.tools.list_ports
except ImportError:
    serial = None
try:
    import msvcrt
except ImportError:
    msvcrt = None

NOMINAL_HZ = 104.0          # LSM6DS3 ODR in both collector and racket firmware
INTERVAL_MS = 1000.0 / NOMINAL_HZ
UINT32_MASK = 0xFFFFFFFF
ACC_G_PER_LSB = 0.000488    # +/-16 g
GYRO_DPS_PER_LSB = 0.070    # +/-2000 dps
GAP_FACTOR = 1.5            # an interval above 1.5x the median means lost samples
DISPLAY_INTERVAL = 0.25
CSV_HEADER = ("timestamp", "Ax", "Ay", "Az", "Gx", "Gy", "Gz")
MODEL_LABELS = ("BC", "BP", "BS", "FC", "FP", "FS", "NONE")
IMU1 = re.compile(r"IMU1,(\d+),(\d+),(-?\d+),(-?\d+),(-?\d+),(-?\d+),(-?\d+),(-?\d+)")
RATE = re.compile(r"#RATE,[\d.]+ fps,err=(\d+)")
STREAM_SUFFIX = ".imu1.log"
LABEL_TAG = "# label="
PEAK_TAG = "# swing_peak_seq="
EXCLUDE_TAG = "# exclude_peak_seq="
MARKER_SEARCH = 1024        # frames searched back for a marker's peak


@dataclass(frozen=True)
class Frame:
    seq: int
    board_us: int
    raw: tuple  # Ax, Ay, Az, Gx, Gy, Gz in signed LSB


def parse_imu1(text):
    match = IMU1.fullmatch(text.strip())
    if match is None:
        return None
    seq, board_us, *raw = map(int, match.groups())
    if seq > UINT32_MASK or board_us > UINT32_MASK:
        return None
    if not all(-32768 <= v <= 32767 for v in raw):
        return None
    return Frame(seq, board_us, tuple(raw))


def gyro_dps(raw):
    return math.hypot(*raw[3:]) * GYRO_DPS_PER_LSB


@dataclass(frozen=True)
class Config:
    """Detector settings, counted in samples of the nominal 104 Hz grid."""
    window: int         # model window
    pre: int            # samples before the peak inside the model window
    jitter: int         # extra samples saved on each side for shifted windows
    tail: int           # extra samples so Edge Impulse fits the last window
    threshold: float    # dps that starts a swing
    refractory: int     # auto mode: minimum samples from one peak to the next
    quiet: float        # auto mode: below this dps counts as still
    quiet_n: int        # auto mode: still samples needed before re-arming
    ei_window_ms: int
    ei_step_ms: int

    @property
    def confirm(self):
        """Samples after the peak inside the model window (firmware latency)."""
        return self.window - self.pre - 1

    @property
    def before(self):
        return self.pre + self.jitter

    @property
    def after(self):
        return self.confirm + self.jitter + self.tail

    @property
    def clip_len(self):
        return self.before + 1 + self.after

    @property
    def ei_windows(self):
        return 3 if self.jitter else 1


def make_config(args):
    def samples(seconds):
        return int(round(seconds * NOMINAL_HZ))

    window, pre, jitter = samples(args.window), samples(args.pre), samples(args.jitter)
    # Edge Impulse floors window_ms * Hz / 1000 to whole samples: round up.
    ei_window_ms = math.ceil(window * INTERVAL_MS - 1e-6)
    ei_step_ms = (math.ceil(jitter * INTERVAL_MS / 10 - 1e-6) * 10
                  if jitter else ei_window_ms)
    reach_ms = ei_window_ms + (2 * ei_step_ms if jitter else 0)
    tail = 2
    while (window + 2 * jitter + tail - 1) * INTERVAL_MS < reach_ms:
        tail += 1
    return Config(window, pre, jitter, tail, args.threshold, samples(args.refractory),
                  args.quiet, samples(args.quiet_time), ei_window_ms, ei_step_ms)


def settings_dict(cfg):
    return {
        "sample_rate_hz": NOMINAL_HZ,
        "firmware": {
            "window_samples": cfg.window,
            "peak_index_in_window": cfg.pre,
            "samples_after_peak": cfg.confirm,
            "threshold_dps": cfg.threshold,
        },
        "collector_only": {
            "jitter_samples": cfg.jitter,
            "tail_samples": cfg.tail,
            "clip_samples": cfg.clip_len,
            "auto_refractory_samples": cfg.refractory,
            "auto_quiet_dps": cfg.quiet,
            "auto_quiet_samples": cfg.quiet_n,
        },
        "edge_impulse": {
            "window_size_ms": cfg.ei_window_ms,
            "window_increase_ms": cfg.ei_step_ms,
            "windows_per_csv": cfg.ei_windows,
        },
    }


def ei_hint(cfg):
    return (f"Edge Impulse：Window size {cfg.ei_window_ms} ms、Window increase "
            f"{cfg.ei_step_ms} ms，每個 CSV 應產生 {cfg.ei_windows} 個視窗。")


class Continuity:
    """Flags frames that do not directly follow the previous frame."""

    def __init__(self):
        self.prev = None
        self.deltas = deque(maxlen=256)
        self.gaps = 0

    def reset(self):
        self.prev = None

    def interval_us(self):
        if len(self.deltas) < 32:
            return 1e6 / NOMINAL_HZ
        return statistics.median(self.deltas)

    def linked(self, frame):
        prev, self.prev = self.prev, frame
        if prev is None:
            return False
        delta = (frame.board_us - prev.board_us) & UINT32_MASK
        if ((frame.seq - prev.seq) & UINT32_MASK != 1 or
                delta > GAP_FACTOR * self.interval_us()):
            self.gaps += 1
            return False
        self.deltas.append(delta)
        return True


@dataclass(frozen=True)
class Swing:
    rows: list          # raw frames of the whole clip
    peak_seq: int
    peak_dps: float


class SwingDetector:
    """Gyro-magnitude peak detector; the racket firmware must mirror it.

    While armed, a swing starts when |gyro| rises through the threshold. Its
    peak is the largest |gyro| until no larger value arrives for `confirm`
    samples; the model window [peak - pre, peak + confirm] is then complete.
    The saved clip adds `jitter` samples on both sides and `tail` at the end.
    Manual mode arms once per key press. Auto mode (while enabled) re-arms
    after `refractory` samples since the peak and `quiet_n` samples below
    `quiet` dps.
    """

    def __init__(self, cfg, auto=False):
        self.cfg = cfg
        self.auto = auto
        self.enabled = False    # auto mode: continuous detection on/off
        self.buffer = deque(maxlen=cfg.clip_len)
        self.reset()

    def reset(self):
        self.buffer.clear()
        self.index = -1
        self.run = 0            # consecutive linked samples ending at the newest
        self.last_peak = None
        self.cancel()

    def arm(self):
        self.armed, self.rising = True, False

    def cancel(self):
        self.armed = self.rising = self.confirmed = False
        self.peak = None        # (index, dps, seq) while a swing is open
        self.quiet_run = 0

    @property
    def busy(self):
        return self.armed or self.peak is not None

    def push(self, frame, linked):
        """Return a Swing, a rejection reason, or None."""
        cfg = self.cfg
        self.index += 1
        self.run = self.run + 1 if linked else 1
        self.buffer.append(frame.raw)
        dps = gyro_dps(frame.raw)
        if self.peak is None:
            if self.auto:
                if not linked:
                    self.armed = False
                if self.enabled and not self.armed:
                    self.quiet_run = self.quiet_run + 1 if dps < cfg.quiet else 0
                    if (self.run > cfg.before and self.quiet_run >= cfg.quiet_n and
                            (self.last_peak is None or
                             self.index - self.last_peak >= cfg.refractory)):
                        self.arm()
            if self.armed:
                if dps < cfg.threshold:
                    self.rising = True
                elif self.rising:
                    self.peak, self.confirmed = (self.index, dps, frame.seq), False
            return None
        index, peak_dps, peak_seq = self.peak
        if not self.confirmed:
            if dps > peak_dps:
                self.peak = (self.index, dps, frame.seq)
                return None
            self.confirmed = self.index - index >= cfg.confirm
        if not self.confirmed or self.index - index < cfg.after:
            return None
        self.last_peak = index
        self.cancel()
        if self.run < cfg.clip_len:
            return "這拍中間有掉樣本（或開始錄製太快），未存檔。"
        return Swing(list(self.buffer), peak_seq, peak_dps)


def write_clip(path, rows):
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("x", encoding="utf-8", newline="") as stream:
        writer = csv.writer(stream)
        writer.writerow(CSV_HEADER)
        for i, raw in enumerate(rows):
            writer.writerow([f"{i * INTERVAL_MS:.3f}",
                             *(f"{v * ACC_G_PER_LSB:.6f}" for v in raw[:3]),
                             *(f"{v * GYRO_DPS_PER_LSB:.3f}" for v in raw[3:])])


class StreamLog:
    """Raw IMU1 lines while one label is selected, plus swing peak markers."""

    def __init__(self, outdir, label):
        now = datetime.now()
        self.path = (outdir / "_streams" / f"{now:%Y%m%d}" /
                     f"{now:%Y%m%d_%H%M%S_%f}{STREAM_SUFFIX}")
        self.path.parent.mkdir(parents=True, exist_ok=True)
        self.file = self.path.open("x", encoding="utf-8", newline="\n")
        self.file.write(f"{LABEL_TAG}{label}\n")

    def write(self, text):
        self.file.write(text + "\n")

    def close(self):
        self.file.close()


def exclude_from_stream(path, current, seq):
    """Record a deleted swing so --recut skips it as well."""
    line = f"{EXCLUDE_TAG}{seq}\n"
    if current is not None and current.path == path:
        current.file.write(line)
    else:
        with path.open("a", encoding="utf-8", newline="\n") as stream:
            stream.write(line)


class LineDecoder:
    def __init__(self):
        self.pending = bytearray()
        self.discard = False

    def reset(self, discard_partial=False):
        self.pending.clear()
        self.discard = discard_partial

    def feed(self, chunk):
        self.pending.extend(chunk)
        lines = []
        while b"\n" in self.pending:
            end = self.pending.index(b"\n")
            line = bytes(self.pending[:end])
            del self.pending[:end + 1]
            if not self.discard and len(line) <= 4096:
                lines.append(line)
            self.discard = False
        if len(self.pending) > 4096:
            self.pending.clear()
            self.discard = True
        return lines


def display_width(text):
    return sum(2 if unicodedata.east_asian_width(c) in ("W", "F") else 1 for c in text)


class Console:
    """One refreshing status line, with log lines printed above it."""

    def __init__(self):
        self.width = 0

    def status(self, text):
        width = display_width(text)
        print("\r" + text + " " * max(0, self.width - width), end="", flush=True)
        self.width = width

    def log(self, text):
        print("\r" + " " * self.width + "\r" + text, flush=True)
        self.width = 0


def valid_label(label):
    return (re.fullmatch(r"[\w-]+", label) is not None and
            re.fullmatch(r"(?i)(CON|PRN|AUX|NUL|COM[1-9]|LPT[1-9])", label) is None)


def warn_unknown_label(label):
    if label not in MODEL_LABELS:
        print(f"注意：{label} 不是模型的 7 個類別（{'/'.join(MODEL_LABELS)}）之一。")


def prompt_label(current=None):
    hint = f"，Enter 保留 {current}" if current else ""
    while True:
        label = input(f"標籤（{'/'.join(MODEL_LABELS)}{hint}）：").strip() or current
        if label and valid_label(label):
            warn_unknown_label(label)
            return label
        print("請用文字、數字、底線或連字號，不要使用路徑或特殊字元。")


def resolve_port(port):
    if port:
        return port
    ports = list(serial.tools.list_ports.comports())
    if not ports:
        raise RuntimeError("找不到 COM 埠，請連接裝置或使用 --port。")
    if len(ports) == 1:
        return ports[0].device
    for i, candidate in enumerate(ports):
        print(f"[{i}] {candidate.device}  {candidate.description}")
    while True:
        choice = input("COM 埠編號：").strip()
        if choice.isdigit() and 0 <= int(choice) < len(ports):
            return ports[int(choice)].device


def read_key():
    if msvcrt.kbhit():
        key = msvcrt.getch()
        if key in (b"\x00", b"\xe0"):
            msvcrt.getch()
            return None
        return key.decode("ascii", errors="ignore").lower()
    return None


@dataclass(frozen=True)
class Saved:
    path: Path
    label: str
    stream: Path
    peak_seq: int


def run_live(args, cfg):
    label = args.label or prompt_label()
    if args.auto:
        print("自動模式：每揮完一拍、球拍靜止後會自動等待下一拍。")
        keys = "s 開始/暫停　l 換標籤　u 刪除上一拍　q 離開"
    else:
        print("按 s 錄一拍：按下後揮一次，只存這一拍（回拉不會記錄），以角速度峰值對齊切出。")
        keys = "s 錄一拍（再按取消）　l 換標籤　u 刪除上一拍　q 離開"
    print(f"模型視窗 {cfg.window} 點（峰值前 {cfg.pre}、後 {cfg.confirm}），"
          f"每個 CSV {cfg.clip_len} 點；觸發 {cfg.threshold:g} dps。")
    print(ei_hint(cfg))
    print(f"輸出：{args.outdir.resolve()}")
    print(f"按鍵：{keys}")
    print("狀態列 gyro = 現在/1 秒內最大角速度（dps）。峰值沒到觸發值的揮拍不會存，"
          "可用 --threshold 調整。")
    try:
        port = resolve_port(args.port)
        ser = serial.Serial(port=None, baudrate=args.baud, timeout=0.01)
        ser.dtr = False
        ser.rts = False
        ser.port = port
        ser.open()
    except (serial.SerialException, OSError, RuntimeError) as error:
        print(f"開啟序列埠失敗：{error}")
        return 1

    console = Console()
    decoder = LineDecoder()
    continuity = Continuity()
    detector = SwingDetector(cfg, auto=args.auto)
    recent = deque(maxlen=int(NOMINAL_HZ))  # |gyro| of the last second
    stream = StreamLog(args.outdir, label)
    streams = [stream.path]
    saved = []
    counts = Counter()
    rejected = fw_errors = frames = 0
    rate_warned = nodata_warned = False
    started = datetime.now()
    opened = last_display = time.perf_counter()
    armed_at = None

    def status_text():
        if detector.peak is not None:
            return "偵測到揮拍"
        if args.auto:
            if not detector.enabled:
                return "暫停（s 開始）"
            return "可以揮拍" if detector.armed else "請先靜止"
        return "等待揮拍（s 取消）" if detector.armed else "按 s 錄一拍"

    code = 0
    try:
        while True:
            now = time.perf_counter()
            key = read_key()
            if key == "q":
                break
            if key == "s":
                if args.auto:
                    detector.enabled = not detector.enabled
                    detector.cancel()
                    console.log(f"自動錄製 [{label}]：先靜止，出現「可以揮拍」再揮。"
                                if detector.enabled else "已暫停。")
                elif detector.busy:
                    detector.cancel()
                    armed_at = None
                    console.log("已取消。")
                else:
                    detector.arm()
                    armed_at = now
                    console.log(f"[{label}] 請揮一拍…")
            elif key == "l":
                detector.enabled = False
                detector.cancel()
                armed_at = None
                stream.close()
                console.log("")
                label = prompt_label(label)
                ser.reset_input_buffer()
                decoder.reset(discard_partial=True)
                continuity.reset()
                detector.reset()
                stream = StreamLog(args.outdir, label)
                streams.append(stream.path)
                console.log(f"標籤：{label}，按 s 開始。")
            elif key == "u":
                if not saved:
                    console.log("沒有可以刪除的揮拍。")
                else:
                    last = saved.pop()
                    last.path.unlink(missing_ok=True)
                    counts[last.label] -= 1
                    exclude_from_stream(last.stream, stream, last.peak_seq)
                    console.log(f"已刪除 {last.path.name}（{last.label} 剩 "
                                f"{counts[last.label]} 拍）")

            if (armed_at is not None and detector.armed and detector.peak is None and
                    now - armed_at > args.timeout):
                detector.cancel()
                armed_at = None
                console.log(f"{args.timeout:g} 秒內沒偵測到揮拍，已取消（峰值要超過 "
                            f"{cfg.threshold:g} dps）。")

            chunk = ser.read(min(ser.in_waiting, 4096) or 1)
            for line in decoder.feed(chunk):
                text = line.decode("utf-8", errors="replace").strip()
                frame = parse_imu1(text)
                if frame is None:
                    rate = RATE.fullmatch(text)
                    if rate:
                        fw_errors += int(rate.group(1))
                    elif text and not text.startswith("IMU1,"):
                        console.log(f"板子：{text[:100]}")
                    continue
                frames += 1
                linked = continuity.linked(frame)
                recent.append(gyro_dps(frame.raw))
                stream.write(text)
                result = detector.push(frame, linked)
                if result is None:
                    continue
                armed_at = None
                if isinstance(result, Swing):
                    stamp = datetime.now()
                    path = (args.outdir / f"{stamp:%Y%m%d}" / label /
                            f"{label}.{stamp:%Y%m%d_%H%M%S_%f}_{result.peak_seq}.csv")
                    write_clip(path, result.rows)
                    stream.write(f"{PEAK_TAG}{result.peak_seq}")
                    saved.append(Saved(path, label, stream.path, result.peak_seq))
                    counts[label] += 1
                    console.log(f"存檔 {label} 第 {counts[label]} 拍，"
                                f"峰值 {result.peak_dps:.0f} dps")
                else:
                    rejected += 1
                    console.log(result)

            if now - last_display < DISPLAY_INTERVAL:
                continue
            last_display = now
            hz = 1e6 / continuity.interval_us()
            if not nodata_warned and frames == 0 and now - opened > 3.0:
                nodata_warned = True
                console.log(f"3 秒內沒收到 IMU1 資料：請確認 COM 埠、baud（目前 {args.baud}）"
                            "與錄製韌體。")
            if (not rate_warned and len(continuity.deltas) >= 200 and
                    abs(hz - NOMINAL_HZ) > 0.03 * NOMINAL_HZ):
                rate_warned = True
                console.log(f"注意：板端量到 {hz:.1f} Hz（設定 {NOMINAL_HZ:g} Hz）。CSV 以取樣點"
                            "為準，同一塊板子訓練與推論仍一致。")
            current = recent[-1] if recent else 0.0
            top = max(recent) if recent else 0.0
            console.status(f"[{label}] {status_text()} | 本次 {counts[label]} 拍 | "
                           f"gyro {current:4.0f}/{top:4.0f} | "
                           f"{hz:5.1f} Hz 掉樣 {continuity.gaps}")
    except KeyboardInterrupt:
        pass
    except (serial.SerialException, OSError) as error:
        console.log(f"連線／檔案錯誤：{error}")
        code = 1
    finally:
        stream.close()
        ser.close()

    print("\n本次存檔：" + ("、".join(f"{k} {v} 拍" for k, v in sorted(counts.items()) if v)
                           or "無"))
    print(f"掉樣本未存 {rejected} 拍；串流掉樣 {continuity.gaps} 次；"
          f"韌體 I2C 錯誤 {fw_errors} 次；板端取樣率 "
          f"{1e6 / continuity.interval_us():.1f} Hz。")
    print(ei_hint(cfg))
    session = {
        "started": started.isoformat(timespec="seconds"),
        "mode": "auto" if args.auto else "manual",
        "streams": [p.name for p in streams],
        "saved": {k: v for k, v in counts.items() if v},
        "rejected_swings": rejected,
        "stream_gaps": continuity.gaps,
        "board_rate_hz": round(1e6 / continuity.interval_us(), 2),
        **settings_dict(cfg),
    }
    path = streams[0].parent / f"session_{started:%Y%m%d_%H%M%S}.json"
    path.write_text(json.dumps(session, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"參數記錄：{path}")
    return code


def find_back(frames, seq, predicate=lambda i: True):
    """Index of the newest recent frame with this seq, or None."""
    for i in range(len(frames) - 1, max(-1, len(frames) - 1 - MARKER_SEARCH), -1):
        if frames[i].seq == seq and predicate(i):
            return i
    return None


def load_stream(path):
    """Label, frames and the frame indices of the saved (not deleted) swing peaks."""
    label, frames, peaks = None, [], []
    with path.open(encoding="utf-8", errors="replace") as stream:
        for text in stream:
            text = text.strip()
            if text.startswith(LABEL_TAG):
                label = text[len(LABEL_TAG):]
            elif text.startswith(PEAK_TAG):
                value = text[len(PEAK_TAG):]
                index = find_back(frames, int(value)) if value.isdigit() else None
                if index is not None:
                    peaks.append(index)
            elif text.startswith(EXCLUDE_TAG):
                value = text[len(EXCLUDE_TAG):]
                if value.isdigit():
                    matches = [p for p in peaks if frames[p].seq == int(value)]
                    if matches:
                        peaks.remove(matches[-1])
            else:
                frame = parse_imu1(text)
                if frame is not None:
                    frames.append(frame)
    return label, frames, peaks


def stream_paths(items):
    paths = []
    for item in map(Path, items):
        paths += sorted(item.rglob("*" + STREAM_SUFFIX)) if item.is_dir() else [item]
    return paths


def cut_clip(frames, linked, cfg, peak):
    """Raw frames of the clip around `peak`, or None if it is cut off or has a gap."""
    first, last = peak - cfg.before, peak + cfg.after
    if first < 0 or last >= len(frames) or not all(linked[first + 1:last + 1]):
        return None
    return [frame.raw for frame in frames[first:last + 1]]


def run_recut(args, cfg):
    paths = stream_paths(args.recut)
    if not paths:
        print(f"找不到 {STREAM_SUFFIX} 串流檔。")
        return 1
    out = args.outdir / f"recut_{datetime.now():%Y%m%d_%H%M%S}"
    counts, rejected = Counter(), 0
    for path in paths:
        label, frames, peaks = load_stream(path)
        if not label or not valid_label(label):
            print(f"略過 {path.name}：沒有有效的標籤。")
            continue
        continuity = Continuity()
        linked = [continuity.linked(frame) for frame in frames]
        stem = path.name.split(".")[0]
        for peak in peaks:
            rows = cut_clip(frames, linked, cfg, peak)
            if rows is None:
                rejected += 1
                continue
            write_clip(out / label / f"{label}.{stem}_{frames[peak].seq}.csv", rows)
            counts[label] += 1
    print("重新切割：" + ("、".join(f"{k} {v} 拍" for k, v in sorted(counts.items()))
                         or "無"))
    print(f"資料不足或掉樣本未存 {rejected} 拍。輸出：{out.resolve()}")
    print(ei_hint(cfg))
    return 0


RETURN_WINDOW = 104     # samples (1 s) after a saved stroke that count as its return motion
MATCH_TOLERANCE = 3     # samples between a firmware peak and a saved peak


def firmware_peaks(frames, linked, cfg, strokes):
    """Peaks the racket firmware would classify: mirror of detector_push in
    ei_main.cpp. Saved stroke peaks (`strokes`) are assumed reported, so they
    start the firmware's refractory period; nothing else does.
    """
    peaks = []
    rising = active = False
    peak = rearm = 0
    peak_dps = 0.0
    for n, frame in enumerate(frames):
        if not linked[n]:           # the firmware restarts its stream after a gap
            rising = active = False
            rearm = n
        dps = gyro_dps(frame.raw)
        if active:
            if dps > peak_dps:
                peak, peak_dps = n, dps
                continue
            if n - peak < cfg.confirm:
                continue
            active = rising = False
            peaks.append(peak)
            if any(abs(peak - s) <= MATCH_TOLERANCE for s in strokes):
                rearm = peak + cfg.refractory
            continue
        if dps < cfg.threshold:
            rising = True
        elif rising and n >= rearm:
            active, peak, peak_dps = True, n, dps
    return peaks


def run_extract_none(args, cfg):
    """Cut NONE clips the firmware would see but the recordings never saved:
    every return motion within 1 s after a saved stroke, plus (up to
    --other-limit) unsaved motions from NONE recordings.
    """
    paths = stream_paths(args.extract_none)
    if not paths:
        print(f"找不到 {STREAM_SUFFIX} 串流檔。")
        return 1
    returns, others = [], []
    for path in paths:
        label, frames, saved = load_stream(path)
        if not label or not saved:
            continue
        continuity = Continuity()
        linked = [continuity.linked(frame) for frame in frames]
        strokes = saved if label != "NONE" else []
        stem = path.name.split(".")[0]
        for peak in firmware_peaks(frames, linked, cfg, strokes):
            if any(abs(peak - s) <= MATCH_TOLERANCE for s in saved):
                continue
            item = (stem, frames, linked, peak)
            if label == "NONE":
                others.append(item)
            elif any(0 < peak - s <= RETURN_WINDOW for s in saved):
                returns.append(item)
    if len(others) > args.other_limit:  # evenly spaced, so reruns pick the same clips
        step = len(others) / args.other_limit
        others = [others[int(i * step)] for i in range(args.other_limit)]
    out = args.outdir / f"none_extra_{datetime.now():%Y%m%d_%H%M%S}" / "NONE"
    counts, rejected = Counter(), 0
    for kind, items in (("return", returns), ("other", others)):
        for stem, frames, linked, peak in items:
            rows = cut_clip(frames, linked, cfg, peak)
            if rows is None:
                rejected += 1
                continue
            write_clip(out / f"NONE.{stem}_{frames[peak].seq}_{kind}.csv", rows)
            counts[kind] += 1
    print(f"NONE：回拉 {counts['return']} 個、其他動作 {counts['other']} 個；"
          f"資料不足或掉樣本未存 {rejected} 個。")
    print(f"輸出：{out.resolve()}")
    print("上傳到 Edge Impulse（Infer from filename、自動分割）後重新訓練。")
    return 0


def parse_args(argv=None):
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--port", help="例如 COM9；省略時互動選擇")
    parser.add_argument("--baud", type=int, default=115200)
    parser.add_argument("--outdir", type=Path,
                        default=Path(__file__).resolve().parent / "recordings",
                        help="紀錄存放位置，預設專案內 recordings")
    parser.add_argument("--label", help="BC/BP/BS/FC/FP/FS/NONE；檔名開頭就是 Edge Impulse 標籤")
    parser.add_argument("--window", type=float, default=0.5, help="模型視窗秒數，預設 0.5")
    parser.add_argument("--pre", type=float, default=0.3, help="視窗內峰值之前的秒數，預設 0.3")
    parser.add_argument("--jitter", type=float, default=0.04,
                        help="前後多存的秒數，讓 Edge Impulse 產生位移視窗；0 = 不擴增")
    parser.add_argument("--threshold", type=float, default=250.0,
                        help="觸發揮拍的合成角速度 dps，預設 250")
    parser.add_argument("--timeout", type=float, default=5.0,
                        help="按 s 後多少秒內沒揮拍就取消，預設 5")
    parser.add_argument("--auto", action="store_true",
                        help="自動模式：每拍結束、球拍靜止後自動等待下一拍（適合錄 NONE）")
    parser.add_argument("--refractory", type=float, default=0.45,
                        help="自動模式：兩拍峰值的最短間隔秒數，預設 0.45")
    parser.add_argument("--quiet", type=float, default=80.0,
                        help="自動模式：低於此 dps 算靜止，預設 80")
    parser.add_argument("--quiet-time", type=float, default=0.15,
                        help="自動模式：下一拍前需靜止的秒數，預設 0.15")
    parser.add_argument("--recut", nargs="+", metavar="PATH",
                        help="用新的視窗參數重新切割 _streams 裡已存的揮拍，不需連接板子")
    parser.add_argument("--extract-none", nargs="+", metavar="PATH",
                        help="從 _streams 切出擊球後的回拉與其他未存的動作，標成 NONE")
    parser.add_argument("--other-limit", type=int, default=100,
                        help="--extract-none 時「其他動作」最多取幾個，預設 100（回拉全取）")
    args = parser.parse_args(argv)
    numbers = (args.window, args.pre, args.jitter, args.threshold, args.timeout,
               args.refractory, args.quiet, args.quiet_time)
    if not all(math.isfinite(v) for v in numbers):
        parser.error("參數必須是有限數值")
    if not 0.2 <= args.window <= 2.0:
        parser.error("--window 必須介於 0.2 與 2 秒")
    if not 1 <= round(args.pre * NOMINAL_HZ) <= round(args.window * NOMINAL_HZ) - 2:
        parser.error("--pre 必須大於 0 並比 --window 至少短 2 個取樣點")
    if not 0 <= args.jitter <= 0.2:
        parser.error("--jitter 必須介於 0 與 0.2 秒")
    if not 0 <= args.quiet < args.threshold <= 3000:
        parser.error("必須 0 <= --quiet < --threshold <= 3000 dps")
    if not 0.5 <= args.timeout <= 60:
        parser.error("--timeout 必須介於 0.5 與 60 秒")
    if not 0 <= args.quiet_time <= 2:
        parser.error("--quiet-time 必須介於 0 與 2 秒")
    if not 0.1 <= args.refractory <= 3:
        parser.error("--refractory 必須介於 0.1 與 3 秒")
    if args.baud <= 0:
        parser.error("--baud 必須為正整數")
    if args.other_limit < 0:
        parser.error("--other-limit 不能是負數")
    if args.label is not None:
        if not valid_label(args.label):
            parser.error("--label 不能含路徑或特殊字元")
        warn_unknown_label(args.label)
    return args


def main():
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8")
        sys.stderr.reconfigure(encoding="utf-8")
    args = parse_args()
    cfg = make_config(args)
    if args.recut:
        return run_recut(args, cfg)
    if args.extract_none:
        return run_extract_none(args, cfg)
    if serial is None:
        print("請先執行：python -m pip install pyserial")
        return 1
    if msvcrt is None:
        print("目前互動按鍵版本需要 Windows 終端機。")
        return 1
    return run_live(args, cfg)


if __name__ == "__main__":
    raise SystemExit(main())

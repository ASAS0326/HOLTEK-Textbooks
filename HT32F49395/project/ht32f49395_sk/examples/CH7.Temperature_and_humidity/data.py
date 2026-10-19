#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
prepare_edge_impulse_22in1out_trend.py

用途
====
讀取已整理成「固定 5 秒一筆」的 HS300x CSV，
建立 Edge Impulse Regression Dataset。

模型使用同一個 Regression 同時負責：
    target_type = 0 -> 預測未來 30 秒溫度變化量
    target_type = 1 -> 預測未來 30 秒濕度變化量

輸入共 22 個：

歷史 7 筆 T/RH，共 14 個
    t_m30, rh_m30
    t_m25, rh_m25
    t_m20, rh_m20
    t_m15, rh_m15
    t_m10, rh_m10
    t_m5,  rh_m5
    t_now, rh_now

趨勢，共 6 個
    dt_5
    dt_15
    dt_30
    drh_5
    drh_15
    drh_30

濕度趨勢加速度，共 1 個
    rh_accel_10s

控制欄位，共 1 個
    target_type

總計：
    14 + 6 + 1 + 1 = 22 inputs

Label
=====
target_type = 0：
    label = (T_future - T_now) * TEMP_LABEL_SCALE

target_type = 1：
    label = RH_future - RH_now

預設 TEMP_LABEL_SCALE = 20

所以 MCU 推論時：

    temperature_delta = model_output / 20.0f
    future_temperature = current_temperature + temperature_delta

濕度不用除：

    humidity_delta = model_output
    future_humidity = current_humidity + humidity_delta


RH 狀態平衡
===========
依「未來 30 秒 RH 變化量」分類：

    rising  : delta_RH > +threshold
    falling : delta_RH < -threshold
    stable  : 其他

預設 threshold = 0.5 %RH。

只有 Training Dataset 會平衡，
Testing Dataset 保持原本真實分布，避免測試結果失真。


執行方式
========
python prepare_edge_impulse_22in1out_trend.py hs300x_5sec.csv

可選參數：
python prepare_edge_impulse_22in1out_trend.py hs300x_5sec.csv \
    --output-dir edge_impulse_22in1out_trend \
    --train-ratio 0.8 \
    --rh-threshold 0.5 \
    --temp-label-scale 20


輸出
====
edge_impulse_22in1out_trend/
    ei_22in1out_trend_train.csv
    ei_22in1out_trend_test.csv
    ei_22in1out_trend_train_unbalanced.csv
    ei_22in1out_trend_all.csv
    audit_all.csv
"""

import argparse
import csv
import random
from datetime import datetime, timedelta
from pathlib import Path


SAMPLE_SEC = 5.0
HISTORY_SEC = 30.0
FORECAST_SEC = 30.0


def parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument(
        "input_csv",
        help="固定 5 秒一筆的 hs300x_5sec.csv"
    )

    parser.add_argument(
        "--output-dir",
        default="edge_impulse_22in1out_trend"
    )

    parser.add_argument(
        "--train-ratio",
        type=float,
        default=0.8
    )

    parser.add_argument(
        "--rh-threshold",
        type=float,
        default=0.5,
        help="RH 上升/下降/穩定分類門檻，單位 %%RH"
    )

    parser.add_argument(
        "--temp-label-scale",
        type=float,
        default=20.0,
        help="溫度 delta label 放大倍率"
    )

    parser.add_argument(
        "--seed",
        type=int,
        default=1234
    )

    parser.add_argument(
        "--max-gap-sec",
        type=float,
        default=15.0,
        help="超過此秒數視為不同量測區段，不跨區段插值"
    )

    parser.add_argument(
        "--minority-target",
        type=int,
        default=5000,
        help="Training 中 rising / falling 各自補到的目標數量"
    )

    parser.add_argument(
        "--stable-max",
        type=int,
        default=20000,
        help="Training 中 stable 最多保留幾筆，避免 stable 過度壓制其他狀態"
    )

    return parser.parse_args()


def parse_time(text):
    return datetime.fromisoformat(text.strip())


def load_rows(path):
    rows = []
    invalid_count = 0

    with open(path, "r", encoding="utf-8-sig", newline="") as file:
        reader = csv.DictReader(file)

        required = {
            "timestamp",
            "temperature_c",
            "humidity_rh",
        }

        missing = required - set(reader.fieldnames or [])

        if missing:
            raise ValueError(
                f"CSV 缺少欄位: {sorted(missing)}\n"
                f"目前欄位: {reader.fieldnames}"
            )

        for row in reader:
            try:
                timestamp = parse_time(row["timestamp"])
                temperature = float(row["temperature_c"])
                humidity = float(row["humidity_rh"])

            except Exception:
                invalid_count += 1
                continue

            rows.append({
                "time": timestamp,
                "temperature": temperature,
                "humidity": humidity,
            })

    rows.sort(key=lambda item: item["time"])

    return rows, invalid_count


def resample_to_fixed_interval(rows, sample_sec, max_gap_sec):
    """
    將不完全固定週期的原始資料重新取樣成固定 sample_sec 秒。

    - 同一連續區段內使用線性插值
    - 若相鄰原始資料間隔 > max_gap_sec，視為不同區段
    - 不跨大斷點插值
    """
    if len(rows) < 2:
        return list(rows)

    segments = []
    current = [rows[0]]

    for row in rows[1:]:
        gap = (row["time"] - current[-1]["time"]).total_seconds()

        if gap <= 0:
            continue

        if gap > max_gap_sec:
            if len(current) >= 2:
                segments.append(current)
            current = [row]
        else:
            current.append(row)

    if len(current) >= 2:
        segments.append(current)

    resampled = []

    for segment in segments:
        start_time = segment[0]["time"]
        end_time = segment[-1]["time"]

        src_sec = [
            (item["time"] - start_time).total_seconds()
            for item in segment
        ]

        total_sec = (
            end_time -
            start_time
        ).total_seconds()

        target_count = int(total_sec // sample_sec) + 1

        src_idx = 0

        for k in range(target_count):
            target_sec = k * sample_sec

            while (
                src_idx + 1 < len(segment)
                and src_sec[src_idx + 1] < target_sec
            ):
                src_idx += 1

            if src_idx + 1 >= len(segment):
                if abs(src_sec[src_idx] - target_sec) > 1e-9:
                    break

                temperature = segment[src_idx]["temperature"]
                humidity = segment[src_idx]["humidity"]

            elif abs(src_sec[src_idx] - target_sec) <= 1e-9:
                temperature = segment[src_idx]["temperature"]
                humidity = segment[src_idx]["humidity"]

            else:
                t0 = src_sec[src_idx]
                t1 = src_sec[src_idx + 1]

                if t1 <= t0:
                    continue

                ratio = (
                    target_sec - t0
                ) / (
                    t1 - t0
                )

                temperature = (
                    segment[src_idx]["temperature"]
                    +
                    (
                        segment[src_idx + 1]["temperature"]
                        - segment[src_idx]["temperature"]
                    )
                    * ratio
                )

                humidity = (
                    segment[src_idx]["humidity"]
                    +
                    (
                        segment[src_idx + 1]["humidity"]
                        - segment[src_idx]["humidity"]
                    )
                    * ratio
                )

            resampled.append({
                "time": start_time + timedelta(seconds=target_sec),
                "temperature": temperature,
                "humidity": humidity,
            })

    return resampled


def write_resampled_csv(path, rows):
    with open(path, "w", encoding="utf-8-sig", newline="") as file:
        writer = csv.writer(file)

        writer.writerow([
            "timestamp",
            "temperature_c",
            "humidity_rh",
        ])

        for row in rows:
            writer.writerow([
                row["time"].strftime("%Y-%m-%d %H:%M:%S"),
                f"{row['temperature']:.6f}",
                f"{row['humidity']:.6f}",
            ])


def is_contiguous(rows, start_idx, end_idx):
    for i in range(start_idx + 1, end_idx + 1):
        dt = (
            rows[i]["time"] -
            rows[i - 1]["time"]
        ).total_seconds()

        if abs(dt - SAMPLE_SEC) > 0.5:
            return False

    return True

def classify_rh_state(delta_rh, threshold):
    if delta_rh > threshold:
        return "rising"

    if delta_rh < -threshold:
        return "falling"

    return "stable"


def build_base_samples(rows, rh_threshold):
    history_steps = int(round(HISTORY_SEC / SAMPLE_SEC))
    forecast_steps = int(round(FORECAST_SEC / SAMPLE_SEC))

    samples = []

    for i in range(history_steps, len(rows) - forecast_steps):
        history_start = i - history_steps
        future_idx = i + forecast_steps

        if not is_contiguous(rows, history_start, i):
            continue

        if not is_contiguous(rows, i, future_idx):
            continue

        t_m30 = rows[i - 6]["temperature"]
        rh_m30 = rows[i - 6]["humidity"]

        t_m25 = rows[i - 5]["temperature"]
        rh_m25 = rows[i - 5]["humidity"]

        t_m20 = rows[i - 4]["temperature"]
        rh_m20 = rows[i - 4]["humidity"]

        t_m15 = rows[i - 3]["temperature"]
        rh_m15 = rows[i - 3]["humidity"]

        t_m10 = rows[i - 2]["temperature"]
        rh_m10 = rows[i - 2]["humidity"]

        t_m5 = rows[i - 1]["temperature"]
        rh_m5 = rows[i - 1]["humidity"]

        t_now = rows[i]["temperature"]
        rh_now = rows[i]["humidity"]

        t_future = rows[future_idx]["temperature"]
        rh_future = rows[future_idx]["humidity"]

        dt_5 = t_now - t_m5
        dt_15 = t_now - t_m15
        dt_30 = t_now - t_m30

        drh_5 = rh_now - rh_m5
        drh_15 = rh_now - rh_m15
        drh_30 = rh_now - rh_m30

        # 濕度趨勢加速度：
        # 最近 10 秒變化 = RH(now) - RH(-10)
        # 前一個 10 秒變化 = RH(-10) - RH(-20)
        #
        # acceleration =
        #     recent_10s_change - previous_10s_change
        #
        # > 0：上升速度正在增加
        # < 0：上升速度正在減弱，或下降正在加速
        recent_10s_change = rh_now - rh_m10
        previous_10s_change = rh_m10 - rh_m20

        rh_accel_10s = (
            recent_10s_change -
            previous_10s_change
        )

        future_temp_delta = t_future - t_now
        future_rh_delta = rh_future - rh_now

        samples.append({
            "timestamp": rows[i]["time"],

            "t_m30": t_m30,
            "rh_m30": rh_m30,

            "t_m25": t_m25,
            "rh_m25": rh_m25,

            "t_m20": t_m20,
            "rh_m20": rh_m20,

            "t_m15": t_m15,
            "rh_m15": rh_m15,

            "t_m10": t_m10,
            "rh_m10": rh_m10,

            "t_m5": t_m5,
            "rh_m5": rh_m5,

            "t_now": t_now,
            "rh_now": rh_now,

            "dt_5": dt_5,
            "dt_15": dt_15,
            "dt_30": dt_30,

            "drh_5": drh_5,
            "drh_15": drh_15,
            "drh_30": drh_30,

            "rh_accel_10s": rh_accel_10s,

            "future_temperature": t_future,
            "future_humidity": rh_future,

            "future_temp_delta": future_temp_delta,
            "future_rh_delta": future_rh_delta,

            "rh_state": classify_rh_state(
                future_rh_delta,
                rh_threshold
            ),
        })

    return samples


def split_train_test(base_samples, train_ratio):
    pair_count = len(base_samples)

    train_count = int(pair_count * train_ratio)

    # 30 秒 gap，避免 train/test 邊界互相共用未來資料
    gap_count = int(round(FORECAST_SEC / SAMPLE_SEC))

    test_start = min(
        train_count + gap_count,
        pair_count
    )

    train = base_samples[:train_count]
    test = base_samples[test_start:]

    return train, test


def balance_training(
    base_train,
    seed,
    minority_target,
    stable_max
):
    """
    只對 Training 做「溫和型平衡」：

    - rising / falling：不足 minority_target 時使用重複抽樣補足
    - stable：最多保留 stable_max 筆

    這樣不會像舊版一樣把 stable 從三萬多筆直接砍到約一千筆，
    因此 Training / Testing 比例仍可維持接近 80 / 20，
    同時又提升 rising / falling 在 Training 中的存在感。
    """
    groups = {
        "rising": [],
        "falling": [],
        "stable": [],
    }

    for sample in base_train:
        groups[sample["rh_state"]].append(sample)

    counts = {
        key: len(value)
        for key, value in groups.items()
    }

    if any(counts[state] == 0 for state in groups):
        raise RuntimeError(
            "Training 資料沒有同時包含 rising / falling / stable，"
            "請增加不同狀態的量測資料。"
        )

    if minority_target <= 0:
        raise ValueError("--minority-target 必須 > 0")

    if stable_max <= 0:
        raise ValueError("--stable-max 必須 > 0")

    rng = random.Random(seed)
    balanced = []

    # rising / falling：保留全部真實樣本，不足目標才 oversample。
    for state in ("rising", "falling"):
        items = list(groups[state])
        selected = list(items)

        target = max(len(items), minority_target)

        while len(selected) < target:
            selected.append(rng.choice(items))

        balanced.extend(selected)

    # stable：保留較多真實資料，只在太多時做適度下採樣。
    stable_items = list(groups["stable"])

    if len(stable_items) > stable_max:
        stable_selected = rng.sample(
            stable_items,
            stable_max
        )
    else:
        stable_selected = stable_items

    balanced.extend(stable_selected)
    rng.shuffle(balanced)

    final_counts = {
        "rising": max(counts["rising"], minority_target),
        "falling": max(counts["falling"], minority_target),
        "stable": len(stable_selected),
    }

    return balanced, counts, final_counts


def input_fields():
    return [
        "t_m30",
        "rh_m30",
        "t_m25",
        "rh_m25",
        "t_m20",
        "rh_m20",
        "t_m15",
        "rh_m15",
        "t_m10",
        "rh_m10",
        "t_m5",
        "rh_m5",
        "t_now",
        "rh_now",

        "dt_5",
        "dt_15",
        "dt_30",

        "drh_5",
        "drh_15",
        "drh_30",

        "rh_accel_10s",

        "target_type",
    ]


def expand_for_edge_impulse(base_samples, temp_label_scale):
    rows = []

    for sample in base_samples:
        common = {
            key: sample[key]
            for key in input_fields()
            if key != "target_type"
        }

        # target_type = 0 -> Temperature
        temp_row = dict(common)
        temp_row["target_type"] = 0
        temp_row["label"] = (
            sample["future_temp_delta"] *
            temp_label_scale
        )

        rows.append(temp_row)

        # target_type = 1 -> Humidity
        hum_row = dict(common)
        hum_row["target_type"] = 1
        hum_row["label"] = sample["future_rh_delta"]

        rows.append(hum_row)

    return rows


def write_ei_csv(path, rows):
    fields = input_fields() + ["label"]

    with open(path, "w", encoding="utf-8-sig", newline="") as file:
        writer = csv.DictWriter(
            file,
            fieldnames=fields
        )

        writer.writeheader()

        for row in rows:
            out = {}

            for key in fields:
                if key == "target_type":
                    out[key] = int(row[key])
                else:
                    out[key] = f"{float(row[key]):.6f}"

            writer.writerow(out)


def write_audit_csv(path, base_samples, temp_label_scale):
    fields = [
        "timestamp",
        "rh_state",

        "t_m30",
        "rh_m30",
        "t_m25",
        "rh_m25",
        "t_m20",
        "rh_m20",
        "t_m15",
        "rh_m15",
        "t_m10",
        "rh_m10",
        "t_m5",
        "rh_m5",
        "t_now",
        "rh_now",

        "dt_5",
        "dt_15",
        "dt_30",

        "drh_5",
        "drh_15",
        "drh_30",

        "rh_accel_10s",

        "future_temperature",
        "future_humidity",

        "future_temp_delta",
        "future_rh_delta",

        "temperature_label_scaled",
    ]

    with open(path, "w", encoding="utf-8-sig", newline="") as file:
        writer = csv.DictWriter(
            file,
            fieldnames=fields
        )

        writer.writeheader()

        for sample in base_samples:
            out = {}

            for key in fields:
                if key == "timestamp":
                    out[key] = sample["timestamp"].strftime(
                        "%Y-%m-%d %H:%M:%S"
                    )

                elif key == "rh_state":
                    out[key] = sample[key]

                elif key == "temperature_label_scaled":
                    out[key] = (
                        f"{sample['future_temp_delta'] * temp_label_scale:.6f}"
                    )

                else:
                    out[key] = f"{float(sample[key]):.6f}"

            writer.writerow(out)


def state_counts(samples):
    counts = {
        "rising": 0,
        "falling": 0,
        "stable": 0,
    }

    for sample in samples:
        counts[sample["rh_state"]] += 1

    return counts


def print_counts(title, counts):
    print(title)
    print(f"  rising  : {counts['rising']}")
    print(f"  falling : {counts['falling']}")
    print(f"  stable  : {counts['stable']}")


def main():
    args = parse_args()

    if not (0.5 <= args.train_ratio < 1.0):
        raise ValueError(
            "--train-ratio 必須 >= 0.5 且 < 1.0"
        )

    if args.rh_threshold <= 0.0:
        raise ValueError(
            "--rh-threshold 必須 > 0"
        )

    if args.temp_label_scale <= 0.0:
        raise ValueError(
            "--temp-label-scale 必須 > 0"
        )

    output_dir = Path(args.output_dir)
    output_dir.mkdir(
        parents=True,
        exist_ok=True
    )

    raw_rows, invalid_count = load_rows(
        args.input_csv
    )

    if len(raw_rows) < 30:
        raise RuntimeError(
            "原始資料太少"
        )

    rows = resample_to_fixed_interval(
        raw_rows,
        SAMPLE_SEC,
        args.max_gap_sec
    )

    write_resampled_csv(
        output_dir /
        "resampled_5sec.csv",
        rows
    )

    print(f"原始有效資料筆數      : {len(raw_rows)}")
    print(f"重新取樣後 5 秒資料   : {len(rows)}")

    if len(rows) < 30:
        raise RuntimeError(
            "重新取樣後的 5 秒資料太少"
        )

    base_samples = build_base_samples(
        rows,
        args.rh_threshold
    )

    print(f"30秒歷史/未來有效樣本 : {len(base_samples)}")

    if len(base_samples) < 60:
        raise RuntimeError(
            "有效的 30 秒歷史/未來樣本太少"
        )

    train_base, test_base = split_train_test(
        base_samples,
        args.train_ratio
    )

    balanced_train_base, original_train_counts, balanced_target_counts = (
        balance_training(
            train_base,
            args.seed,
            args.minority_target,
            args.stable_max
        )
    )

    train_rows = expand_for_edge_impulse(
        balanced_train_base,
        args.temp_label_scale
    )

    train_unbalanced_rows = expand_for_edge_impulse(
        train_base,
        args.temp_label_scale
    )

    test_rows = expand_for_edge_impulse(
        test_base,
        args.temp_label_scale
    )

    all_rows = expand_for_edge_impulse(
        base_samples,
        args.temp_label_scale
    )

    write_ei_csv(
        output_dir /
        "ei_22in1out_trend_train.csv",
        train_rows
    )

    write_ei_csv(
        output_dir /
        "ei_22in1out_trend_test.csv",
        test_rows
    )

    write_ei_csv(
        output_dir /
        "ei_22in1out_trend_train_unbalanced.csv",
        train_unbalanced_rows
    )

    write_ei_csv(
        output_dir /
        "ei_22in1out_trend_all.csv",
        all_rows
    )

    write_audit_csv(
        output_dir /
        "audit_all.csv",
        base_samples,
        args.temp_label_scale
    )

    all_counts = state_counts(
        base_samples
    )

    test_counts = state_counts(
        test_base
    )

    balanced_counts = state_counts(
        balanced_train_base
    )

    print("")
    print("========================================================")
    print(" Edge Impulse 22-input Trend Dataset Ready")
    print("========================================================")
    print(f"5 秒輸入資料            : {len(rows)}")
    print(f"無效輸入資料            : {invalid_count}")
    print(f"有效時間點              : {len(base_samples)}")
    print("")
    print("22 inputs:")
    print("  14 = 7 組歷史 T/RH")
    print("   6 = dT/dRH 5s, 15s, 30s")
    print("   1 = RH acceleration")
    print("   1 = target_type")
    print("")
    print(f"RH state threshold      : +/- {args.rh_threshold:.2f} %RH")
    print(f"Temperature label scale : x{args.temp_label_scale:.1f}")
    print("")
    print_counts(
        "全部資料 RH 狀態：",
        all_counts
    )
    print("")
    print_counts(
        "Training 平衡前：",
        original_train_counts
    )
    print("")
    print(
        f"Training minority target: {args.minority_target}"
    )
    print(
        f"Training stable max      : {args.stable_max}"
    )
    print_counts(
        "Training 平衡後：",
        balanced_counts
    )
    print("")
    print_counts(
        "Testing 真實分布：",
        test_counts
    )
    print("")
    print(f"EI Training rows        : {len(train_rows)}")
    print(f"EI Testing rows         : {len(test_rows)}")

    total_ei_rows = len(train_rows) + len(test_rows)
    if total_ei_rows > 0:
        train_pct = len(train_rows) * 100.0 / total_ei_rows
        test_pct = len(test_rows) * 100.0 / total_ei_rows
        print(f"EI split                 : {train_pct:.1f}% / {test_pct:.1f}%")
    print("")
    print("重要：")
    print("  target_type = 0:")
    print("    model_output = scaled temperature delta")
    print(
        f"    real dT = model_output / {args.temp_label_scale:.1f}"
    )
    print("")
    print("  target_type = 1:")
    print("    model_output = real humidity delta")
    print("")
    print("MCU:")
    print(
        f"  T_future = T_now + model_output / {args.temp_label_scale:.1f}"
    )
    print("  RH_future = RH_now + model_output")
    print("")
    print("Output directory:")
    print(output_dir)
    print("========================================================")


if __name__ == "__main__":
    main()

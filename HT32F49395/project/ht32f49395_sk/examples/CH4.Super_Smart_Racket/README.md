# CH4 超級智慧球拍（Super Smart Racket）— HT32F49395

用 LSM6DS3 六軸 IMU 記錄桌球揮拍動作，在 Edge Impulse 訓練 7 類揮拍分類模型，再部署回 HT32F49395 即時推論，並透過板上 BLE 模組把結果送到網頁或手機 App 顯示。

## 學習目標

- 以 SPI 讀取 LSM6DS3 加速度計與陀螺儀（104 Hz、±16 g、±2000 dps）
- 用 Python 腳本以「角速度峰值對齊」方式切出一致的訓練樣本
- 在 Edge Impulse 建立時間序列分類模型並匯出 CMSIS Pack
- 在 MCU 上重現與訓練端相同的揮拍偵測邏輯，確保推論輸入與訓練資料對齊
- 透過 UART 轉 BLE 模組傳送二進位結果封包

## 分類標籤

| 標籤 | 動作 | 標籤 | 動作 |
|---|---|---|---|
| `BC` | 反手切 | `FC` | 正手切 |
| `BP` | 反手拉 | `FP` | 正手拉 |
| `BS` | 反手拍 | `FS` | 正手拍 |
| `NONE` | 無動作／回拉等非擊球動作 | | |

## 硬體與接腳

| 功能 | 周邊 | 接腳 | 說明 |
|---|---|---|---|
| LSM6DS3 SCK | SPI3（remap） | PC10 | |
| LSM6DS3 MISO | SPI3 | PC11 | |
| LSM6DS3 MOSI | SPI3 | PC12 | |
| LSM6DS3 CS | GPIO | PE5 | |
| 除錯／資料輸出 | USART1 | PA9（TX） | 115200 8N1 |
| BLE 模組 TX／RX | UART4 | PA0／PA1 | 9600 8N1，接板上 BM67C593 模組 |
| BLE 模組重置 | GPIO | PD3 | 設定裝置名稱後重置模組用 |

感測器設定：`CTRL1_XL=0x44`（104 Hz、±16 g，0.000488 g/LSB）、`CTRL2_G=0x4C`（104 Hz、±2000 dps，0.070 dps/LSB）、`CTRL3_C=0x44`（BDU、位址自動遞增）。

## 資料夾結構

```text
CH4.Super_Smart_Racket/
├── Data_collection/              # 資料收集韌體
│   ├── src/  inc/                # main.c、LSM6DS3 驅動
│   ├── mdk_v5/                   # Keil 專案（Arm Compiler 6）
│   ├── mdk_v537/                 # Keil 專案（MDK 5.37 相容版）
│   └── HT32-IDE/                 # HT32-IDE 專案
├── Run_Classification/           # 推論韌體
│   ├── src/  inc/                # main.c、ei_main.cpp、ble_uart4.c、LSM6DS3 驅動
│   ├── mdk_v5/                   # Keil 專案（含 Edge Impulse 元件）
│   ├── mdk_v537/
│   └── HT32-IDE/
├── pinpon2-cmsis-package-v1-impulse-#1/
│   ├── EdgeImpulse.pinpon2.7.0.0.pack    # 已訓練好的模型
│   └── EdgeImpulse.EI-SDK.1.95.14.pack   # Edge Impulse SDK
├── collect_training_data.py      # PC 端揮拍錄製腳本
├── index.html                    # Web Bluetooth 結果接收頁
└── APK/                          # Android 接收 App（app-release.apk）與 QR Code（apk.png）
```

> `Data_collection/readme.txt` 是範本沿用下來的 SPI 說明，內容與本章無關，請以本文件為準。

## 開發環境

- Keil MDK 5，Arm Compiler 6（`mdk_v5` 專案以 V6.24 建置），裝置包 `Holtek.HT32F493x5_DFP` 1.0.6
- 推論專案另需 CMSIS 6、CMSIS-DSP 1.16.2、CMSIS-NN 4.0.0
- Python 3 與 `pyserial`（`python -m pip install pyserial`）；錄製腳本的互動按鍵只支援 Windows 終端機
- Edge Impulse 帳號
- 支援 Web Bluetooth 的瀏覽器（Chrome／Edge），或 Android 手機安裝 `APK/app-release.apk`

> `Run_Classification/mdk_v537` 專案沒有加入 Edge Impulse 元件與 `ei_main.cpp`，推論請使用 `mdk_v5` 或 HT32-IDE 專案。

## 步驟一：收集揮拍資料

### 1. 燒錄資料收集韌體

開啟 `Data_collection/mdk_v5/fullduplex_polling.uvprojx`，編譯並燒錄。開機後 USART1 會輸出（數值僅為示意）：

```text
LSM6DS3 Init OK: WHO_AM_I=0x6A
Accelerometer: 104 Hz, +/-16 g, CTRL1_XL=0x44
Gyroscope: 104 Hz, +/-2000 dps, CTRL2_G=0x4C
IMU1: seq,read_us,Ax_raw,Ay_raw,Az_raw,Gx_raw,Gy_raw,Gz_raw
...
#FW,PINPON_C_FAST104_V2,<日期>,<時間>
#STREAM,104Hz,115200baud,IMU1,recording-only
IMU1,0,1234,12,-5,2048,3,-1,0
#RATE,104.0 fps,err=0
```

- `IMU1,...`：每筆樣本一行，數值為感測器原始 LSB（有號整數），不在 MCU 上做浮點格式化
- `#RATE,...`：每秒一行，回報實際送出筆數與錯誤次數
- 韌體只在 `STATUS_REG` 的 XLDA 與 GDA 同時為 1 時才讀取，取樣率即為感測器 ODR 104 Hz

### 2. 用 `collect_training_data.py` 錄製

```bash
python collect_training_data.py --port COM9 --label FS
```

| 按鍵 | 功能 |
|---|---|
| `s` | 錄一拍：按下後揮一次，偵測到峰值即自動切割存檔（再按一次取消） |
| `l` | 換標籤 |
| `u` | 刪除上一拍 |
| `q` | 離開 |

腳本的切割方式：

1. 持續緩衝串流資料；按下 `s` 後，等合成角速度向上穿越觸發值（預設 250 dps）
2. 找到合成角速度峰值，且之後連續 20 筆都沒有更大值時確認峰值
3. 以峰值為中心切出 62 筆：模型視窗 52 筆（0.5 s，峰值在第 31 筆）＋前後各 4 筆位移空間＋2 筆尾端
4. CSV 欄位為 `timestamp, Ax, Ay, Az, Gx, Gy, Gz`（g 與 dps），時間戳使用 104 Hz 名目格點，不用實際量測時間
5. 只要片段中有掉樣本就不存檔

輸出位置（預設 `recordings/`）：

- `recordings/<日期>/<標籤>/<標籤>.<時間>_<序號>.csv`：訓練用 CSV，檔名開頭即為 Edge Impulse 標籤
- `recordings/_streams/`：完整原始串流 `*.imu1.log` 與每次的參數紀錄 `session_*.json`

常用參數：

| 參數 | 預設 | 說明 |
|---|---|---|
| `--threshold` | 250 | 觸發揮拍的合成角速度（dps） |
| `--window` / `--pre` | 0.5 / 0.3 | 模型視窗秒數／峰值前秒數 |
| `--jitter` | 0.04 | 前後多存的秒數，讓 Edge Impulse 產生位移視窗 |
| `--auto` | 關閉 | 自動模式：每拍結束、球拍靜止後自動等待下一拍，適合錄 `NONE` |
| `--recut PATH` | | 用新的視窗參數重新切割 `_streams` 裡已存的揮拍，不需接板子 |
| `--extract-none PATH` | | 從串流中切出擊球後的回拉與其他未存動作，標為 `NONE` |

建議流程：6 種擊球動作各錄足夠數量後，執行一次 `--extract-none recordings/_streams` 補充 `NONE` 樣本，讓模型學會忽略回拉動作。

## 步驟二：在 Edge Impulse 訓練模型

1. **Data acquisition → Upload data**：上傳所有 CSV，標籤選擇從檔名推斷（Infer from filename），並自動切分 Training／Test
2. **Create impulse**：
   - Window size **500 ms**、Window increase **40 ms**（每個 CSV 產生 3 個視窗，峰值位置分別在 35／31／27）
   - Frequency 104 Hz
   - Processing block 使用 **Raw data**，Learning block 選 Classification
3. 訓練完成後到 **Deployment** 選擇 **CMSIS Pack** 匯出

> 視窗參數也會印在錄製腳本結束時的訊息與 `session_*.json` 中；若更改了 `--window` 或 `--pre`，Edge Impulse 與韌體的參數都要跟著改。

本章附的模型 `pinpon2` 7.0.0（Edge Impulse 專案 1121506，deploy v7）：輸入 52 筆 × 6 軸，7 個標籤，網路為 312-20-10-7 的全連接層。

## 步驟三：部署推論韌體

### 1. 安裝模型 Pack

Keil 中開啟 **Pack Installer → File → Import**，匯入 `pinpon2-cmsis-package-v1-impulse-#1/` 內的兩個 `.pack`（若是自己訓練的模型，改匯入 Edge Impulse 下載的 Pack）。

### 2. 編譯燒錄

開啟 `Run_Classification/mdk_v5/led_toggle.uvprojx`，在 **Manage Run-Time Environment** 確認已勾選 `EdgeImpulse::SDK` 與模型元件，編譯後燒錄。

`ei_main.cpp` 以 `static_assert` 檢查模型版本（deploy v7）、6 軸輸入、52 筆視窗與 7 個標籤；換成自己的模型時要一併修改這些檢查。

### 3. 推論流程

1. SysTick 每 1 ms 呼叫 `ei_main_sample_tick()`，資料就緒時以 SPI 讀一筆放進 64 筆 FIFO（約 0.6 s），讓推論與 BLE 傳送期間不漏樣本
2. `swing_push()` 執行與錄製腳本相同的峰值偵測（250 dps 觸發、峰值在第 31 筆、峰值後 20 筆確認）
3. 視窗完整後轉成 g／dps 呼叫 `run_classifier()`
4. 結果不是 `NONE` 時，經 UART4 送出 32 bytes 的 V2 結果封包，並進入 47 筆（約 0.45 s）不反應期
5. 除錯 UART 印出每個類別的分數與耗時

除錯 UART 輸出範例（數值僅為示意）：

```text
Waiting for a swing (> 250 dps)...
Swing peak = 812 dps
Predictions:
  BC = 0.000
  ...
  FS = 0.961
Result: FS  confidence=0.961
Timing: DSP=0 ms, NN=3 ms, total=4 ms
```

若 100 ms 內收不到新樣本，韌體會印出 LSM6DS3 暫存器狀態並重新設定感測器，不需斷電即可恢復。

### 4. 查看結果

- **網頁**：用 Chrome／Edge 開啟 `index.html`（或 <https://asas0326.github.io/holtek_Super_Smart_Racket/>），按連線後選擇名稱以 `Super_Smart_Racket` 開頭的裝置
- **手機**：安裝 `APK/app-release.apk`（`APK/apk.png` 為 QR Code）

韌體開機時會用 `AT+NAME?` 查詢 BLE 模組名稱，若不是 `Super_Smart_Racket` 才寫入新名稱並重置模組。

## V2 結果封包格式

32 bytes，多位元組欄位皆為 little-endian：

| 位移 | 型態 | 內容 |
|---|---|---|
| 0 | u8 ×2 | 同步字 `0xAA 0x55` |
| 2 | u8 | 版本 `0x01` |
| 3 | u8 | 類型 `0x02`（AI 結果） |
| 4 | u32 | 封包序號 |
| 8 | u32 | 峰值樣本的讀取時間（µs） |
| 12 | u8 | 最高分標籤索引（BC BP BS FC FP FS NONE） |
| 13 | u8 | 信心值 × 255 |
| 14 | u16 ×7 | 7 個類別分數 × 10000 |
| 28 | u16 | `run_classifier()` 耗時（ms） |
| 30 | u16 | byte 0–29 的總和（checksum） |

BM67C593 模組要等內部緩衝填滿才會轉送資料，因此每個封包後面會補 160 bytes 的 0，讓封包能立即送出；接收端尋找 `0xAA 0x55` 時會略過這些 0。

## 常見問題

| 狀況 | 處理方式 |
|---|---|
| 腳本顯示「3 秒內沒收到 IMU1 資料」 | 確認 COM 埠、鮑率 115200，以及燒錄的是資料收集韌體 |
| 揮拍沒有存檔 | 狀態列 `gyro` 顯示目前／1 秒內最大角速度；峰值未達 250 dps 不會觸發，可調低 `--threshold` |
| 出現「這拍中間有掉樣本」 | 序列埠傳輸中斷或剛開始錄製太快，重新揮一次即可 |
| 板端取樣率與 104 Hz 差超過 3% | 感測器振盪器誤差；CSV 以取樣點為準，同一塊板子訓練與推論仍一致 |
| 編譯出現 `expected pinpon2 deploy version 7` | 專案用到的模型 Pack 版本與程式不符，檢查 RTE 元件或修改 `static_assert` |
| 網頁找不到裝置 | 接收頁只列出名稱以 `Super_Smart_Racket` 開頭的裝置，確認除錯 UART 顯示名稱設定成功 |

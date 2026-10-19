# CH8 超級智慧球拍（Super Smart Racket）— HT32F67595

與 CH4 相同的桌球揮拍辨識題目，改用內建 BLE 5.1 的雙核心 MCU HT32F67595：主處理器（MP，Cortex-M33）負責讀取 LSM6DS3 與 Edge Impulse 推論，通訊處理器（CP，Cortex-M0+）負責 BLE 協定堆疊，兩核心透過共用記憶體交換推論結果，不再需要外接 BLE 模組。

## 學習目標

- 以 I2C 讀取 LSM6DS3，並沿用 CH4 的錄製腳本收集訓練資料
- 了解 HT32F67595 的 MP／CP 雙核心分工與啟動流程
- 以共用記憶體＋序號鎖（seqlock）在兩核心間安全傳遞資料
- 建立自訂 GATT 服務，以 Notify 傳送推論結果

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
| LSM6DS3 SCL | I2C0 | PB9 | 7-bit 位址 `0x6A` |
| LSM6DS3 SDA | I2C0 | PB7 | |
| I2C RX／TX | DMA | DMA6／DMA7 | |
| 除錯輸出 | UART0 | PA29（TX） | 資料收集 115200；推論 460800 |

感測器設定與 CH4 相同：104 Hz、±16 g（0.000488 g/LSB）、±2000 dps（0.070 dps/LSB）。

## 資料夾結構

```text
CH8.Super_Smart_Racket/
├── Data_collection/ht32f675x5_r2/
│   ├── main.c
│   ├── config/app_cfg.h          # 接腳與 UART 設定
│   ├── project/                  # Keil 專案 i2c.uvprojx、i2c.c、LSM6DS3 驅動
│   └── hex/i2c.hex               # 預先編譯好的韌體
├── Run_Classification/ht32f675x5_r2/
│   ├── config/                   # app_cfg.h、ble_config.h
│   ├── project/
│   │   ├── ble_peripheral.uvmpw  # Keil 多專案工作區（cp＋mp）
│   │   ├── cp/                   # CP：BLE 堆疊、GATT 服務、結果封包
│   │   └── mp/                   # MP：LSM6DS3、揮拍偵測、Edge Impulse 推論
│   ├── project_HT32-IDE/         # HT32-IDE 專案（cp、mp）
│   └── hex/ble_peripheral.hex    # 預先編譯好的韌體
├── pinpon_model/
│   ├── EdgeImpulse.pinpon.11.0.0.pack    # 已訓練好的模型
│   ├── EdgeImpulse.EI-SDK.1.95.14.pack
│   └── edgeimpulse.clayer.yml
├── collect_training_data.py      # PC 端揮拍錄製腳本（與 CH4 相同）
├── index.html                    # Web Bluetooth 結果接收頁（與 CH4 相同）
└── APK/                          # Android 接收 App 與 QR Code
```

## 開發環境

- Keil MDK 5（實測 MDK 5.43a）：資料收集與 CP 專案使用 Arm Compiler 6，MP 推論專案使用 Keil 中設定的 Arm GNU Toolchain（GCC，實測 14.2），裝置包 `Holtek.HT32F675x5_DFP` 1.0.6
- 推論專案另需 CMSIS、CMSIS-DSP、CMSIS-NN
- Python 3 與 `pyserial`；錄製腳本的互動按鍵只支援 Windows 終端機
- Edge Impulse 帳號
- Chrome／Edge（Web Bluetooth），或 Android 手機

不想編譯時，可直接燒錄 `hex/` 資料夾中預先編譯好的 `.hex`。

## 步驟一：收集揮拍資料

1. 開啟 `Data_collection/ht32f675x5_r2/project/i2c.uvprojx` 編譯燒錄，或直接燒錄 `hex/i2c.hex`
2. 序列輸出（115200 bps）與 CH4 逐行相同：開機訊息、`#FW`／`#STREAM`、每秒一行 `#RATE`，以及每筆樣本一行 `IMU1,seq,read_us,Ax_raw,Ay_raw,Az_raw,Gx_raw,Gy_raw,Gz_raw`
3. 用章節根目錄的錄製腳本收集資料：

   ```bash
   python collect_training_data.py --port COM9 --label FS
   ```

錄製腳本的按鍵、峰值對齊切割方式、參數與輸出檔案說明，請見 [CH4 README](../../../HT32F49395/project/ht32f49395_sk/examples/CH4.Super_Smart_Racket/README.md#步驟一收集揮拍資料)。兩章使用相同的感測器設定與格式，資料可以互通。

## 步驟二：在 Edge Impulse 訓練模型

設定與 CH4 相同：

- 上傳 CSV、從檔名推斷標籤
- Window size **500 ms**、Window increase **40 ms**、Frequency 104 Hz
- Processing block：**Raw data**；Learning block：Classification
- **Deployment** 選擇 **CMSIS Pack**，並使用 **int8 量化** 模型

本章附的模型 `pinpon` 11.0.0（Edge Impulse 專案 1111023，deploy v11）：輸入 52 筆 × 6 軸、7 個標籤、int8 量化並內含資料正規化。

## 步驟三：部署推論韌體

### 1. 雙核心架構

| 核心 | 專案 | 工作 |
|---|---|---|
| MP（Cortex-M33） | `project/mp` | 初始化 I2C 與 LSM6DS3、讀取感測器 FIFO、揮拍偵測、`run_classifier()`、把結果寫入共用記憶體、啟動 CP |
| CP（Cortex-M0+） | `project/cp` | BLE 堆疊（RTOS）、廣播、GATT 服務、讀取共用記憶體並組成封包 Notify |

開機時 MP 先完成自身初始化，再把 CP 的程式碼重映射到 CP 執行位址並釋放 CP 的重置，CP 才開始執行。

### 2. 編譯順序

1. Keil **Pack Installer → File → Import** 匯入 `pinpon_model/` 內的兩個 `.pack`
2. 開啟 `Run_Classification/ht32f675x5_r2/project/ble_peripheral.uvmpw`
3. **先編譯 `cp`**：建置後的批次檔會用 `HT32F67595/tools/bin2array/bin2array.exe` 把 CP 的二進位檔轉成 `cp/app_code_cp.c`（陣列 `g_u8CpAppCode`）
4. **再編譯 `mp`**：MP 專案會把 `app_code_cp.c` 一起連結進去，輸出的 `.hex` 會複製到 `hex/ble_peripheral.hex`
5. 燒錄 `hex/ble_peripheral.hex`

修改 CP 程式後一定要重新編譯 MP，否則燒錄的仍是舊的 CP 程式。

> `pinpon_model/edgeimpulse.clayer.yml` 裡寫的是 `pinpon@10.0.0`，但 MP 程式以 `static_assert` 要求專案 1111023、deploy v11，請在 RTE 中選擇 **pinpon 11.0.0**。

### 3. MP 推論流程

1. LSM6DS3 以硬體 FIFO 連續取樣（104 Hz），MP 依序讀出並轉成 g／dps 存入 52 筆環狀緩衝
2. 揮拍偵測與錄製腳本相同：合成角速度穿越 **250 dps** 觸發、峰值位於視窗第 **31** 筆、峰值後 20 筆確認
3. 呼叫 `run_classifier()`，最高分不是 `NONE` 且信心值 ≥ **0.70** 時才寫入共用記憶體，並進入 **47 筆**（約 0.45 s）不反應期；判為 `NONE` 不會進入不反應期，緊接著的真正擊球仍能被偵測
4. UART0（460800 bps）印出每次揮拍的結果，分數以 bp（萬分之一）表示，括號內為 `sent`、`NONE` 或 `low confidence`：

   ```text
   SWING #<n> peak=<dps> dps -> <標籤> <分數> bp (sent) | BC=<..> BP=<..> ... | infer=<ms> ms
   ```

開機時 MP 也會檢查模型的軸名稱必須是 `Ax + Ay + Az + Gx + Gy + Gz`、標籤順序必須是 `BC BP BS FC FP FS NONE`，不符合會印出 `ERROR: incompatible model input metadata`。

### 4. 共用記憶體

| 位址 | 內容 |
|---|---|
| `0x20015C00` | 共用區起點（magic `0x53485244`） |
| `+0x10` | 前兩名結果：`label0[8]`、`value0`、`label1[8]`、`value1`（24 bytes） |
| `+0x28` | 序號（seqlock），MP 寫入前後各遞增一次 |
| `+0x2C`–`+0x3C` | 診斷計數：狀態、樣本數、視窗數、錯誤碼、FIFO 狀態 |
| `+0x40` | 7 個類別分數、峰值時間（µs）、推論耗時（ms） |

MP 寫入期間序號為奇數。CP 讀取前後比對序號，遇到奇數、讀取期間序號改變，或序號與上次相同時就略過，下次再讀，確保不會送出寫到一半或重複的結果。

### 5. BLE 傳輸

| 項目 | 設定 |
|---|---|
| 廣播名稱 | `Super_Smart_Racket` |
| 服務 UUID | `0xFFF0` |
| 特徵 UUID | `0xFFF1`（Notify） |
| 封包 | 32 bytes V2 結果封包，格式與 [CH4](../../../HT32F49395/project/ht32f49395_sk/examples/CH4.Super_Smart_Racket/README.md#v2-結果封包格式) 相同 |

MTU ≥ 35 時一次送出完整封包；使用預設 MTU 的裝置則分段傳送，所有分段送出成功前不會丟棄該次揮拍。

### 6. 查看結果

- **網頁**：用 Chrome／Edge 開啟 `index.html`（或 <https://asas0326.github.io/holtek_Super_Smart_Racket/>），連線名稱為 `Super_Smart_Racket` 的裝置，開啟通知後即可看到每次揮拍結果
- **手機**：安裝 `APK/app-release.apk`（`APK/apk.png` 為 QR Code）

## 常見問題

| 狀況 | 處理方式 |
|---|---|
| 搜尋不到 BLE 裝置 | 確認燒錄的是 `ble_peripheral.hex`，且 CP 有正常啟動（MP 的 `system_enable_cp()` 有執行） |
| 修改 CP 程式後行為沒變 | CP 程式是以陣列方式連結進 MP，需先編 cp 再編 mp |
| 編譯出現 `Select the pinpon 11.0.0 model pack in the MP project.` | RTE 選到的模型版本不對，改選 pinpon 11.0.0 或修改 `static_assert` |
| 編譯出現 `Use the int8 model with its embedded normalization.` | 匯出模型時改選 int8 量化版本 |
| UART 看到 `SWING skipped: only ... samples since the stream started` | 感測器串流剛重新開始，緩衝不足一個視窗，稍等再揮拍 |
| 錄製腳本收不到資料 | 確認 COM 埠與 115200 bps，且燒錄的是資料收集韌體 |

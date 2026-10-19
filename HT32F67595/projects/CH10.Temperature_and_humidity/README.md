# CH10 溫溼度趨勢預測 — HT32F67595

與 CH7 相同的溫溼度預測題目，改用 HT32F67595。以 HS3003 每 5 秒量測一次，用 Edge Impulse 迴歸模型預測 **30 秒後** 的溫度與溼度，並在 30 秒後以實際量測值驗證誤差。PC 端腳本、資料集格式與模型都和 CH7 共用。

## 學習目標

- 以 HT32F67595 的 I2C＋DMA 非阻塞方式讀取 HS3003
- 沿用 CH7 的 PC 端流程記錄資料並產生迴歸資料集
- 在不同 MCU 平台部署同一個 Edge Impulse 模型

## 硬體與接腳

| 功能 | 周邊 | 接腳 | 說明 |
|---|---|---|---|
| HS3003 SCL | I2C0 | PB9 | 7-bit 位址 `0x44` |
| HS3003 SDA | I2C0 | PB7 | |
| I2C RX／TX | DMA | DMA6／DMA7 | |
| 序列輸出 | UART0 | PA29（TX） | 115200 8N1 |

HS3003 每次轉換約 40 ms；量測週期以「開始量測的時間」為基準，轉換時間不會累積造成週期漂移。

## 資料夾結構

```text
CH10.Temperature_and_humidity/
├── Data_Collection/ht32f675x5_r2/
│   ├── main.c                    # 每 5 秒量測並輸出 DATA
│   ├── src/  inc/                # hs300x.c、i2c.c
│   ├── config/  project/  project_HT32-IDE/
│   └── hex/gpio.hex              # 預先編譯好的韌體
├── Run_Classification/ht32f675x5_r2/
│   ├── main.c
│   ├── src/  inc/                # ei_main.cpp、hs300x.c、i2c.c
│   ├── config/  project/  project_HT32-IDE/
│   └── hex/gpio.hex
├── t&h2-cmsis-package-v2-impulse-#1/
│   ├── EdgeImpulse.T_H2.2.0.0.pack       # 已訓練好的模型（與 CH7 相同）
│   ├── EdgeImpulse.EI-SDK.1.95.13.pack
│   └── edgeimpulse.clayer.yml
├── data_logger.py                # PC 端：接收序列資料存成 CSV（與 CH7 相同）
└── data.py                       # PC 端：產生 Edge Impulse 迴歸資料集（與 CH7 相同）
```

## 開發環境

- Keil MDK 5，Arm Compiler 6，裝置包 `Holtek.HT32F675x5_DFP` 1.0.5
- 推論專案另需 CMSIS 6.3.0、CMSIS-DSP 1.16.2、CMSIS-NN 4.0.0
- Python 3 與 `pyserial`
- Edge Impulse 帳號

不想編譯時，可直接燒錄 `hex/gpio.hex`。

## 步驟一：記錄溫溼度資料

1. 開啟 `Data_Collection/ht32f675x5_r2/project/gpio.uvprojx` 編譯燒錄，或燒錄 `hex/gpio.hex`
2. 序列輸出與 CH7 相同：

   ```text
   HS300x Data Logger Start
   DATA,1,25.42,60.15
   DATA,2,25.43,60.20
   ```

   I2C 錯誤時輸出 `ERROR,I2C,<n>`，初始化失敗時輸出 `ERROR,I2C_INIT` 並停止。

3. 修改 `data_logger.py` 的 `COM_PORT` 後執行，資料會存到 `log_data/data.csv`：

   ```bash
   python data_logger.py
   ```

記錄時請刻意製造溼度上升、下降與持平三種情境，並持續數小時以上。

## 步驟二：產生資料集並訓練模型

```bash
python data.py log_data/data.csv
```

資料集的 22 個輸入特徵、標籤定義、平衡方式與輸出檔案，以及 Edge Impulse 的訓練設定（Raw data＋Regression），請見 [CH7 README](../../../HT32F49395/project/ht32f49395_sk/examples/CH7.Temperature_and_humidity/README.md#步驟二產生-edge-impulse-資料集)。

兩塊板子輸出相同的 `DATA` 格式，CH7 與 CH10 收集的 CSV 可以合併後一起產生資料集。

本章附的模型 `T&H2` 2.0.0（Edge Impulse 專案 1112124）：22 個輸入、1 個迴歸輸出。

## 步驟三：部署預測韌體

1. Keil **Pack Installer → File → Import** 匯入 `t&h2-cmsis-package-v2-impulse-#1/` 內的兩個 `.pack`
2. 開啟 `Run_Classification/ht32f675x5_r2/project/gpio.uvprojx`，確認 RTE 已勾選 Edge Impulse SDK 與 `T_H2` 模型元件
3. 編譯燒錄（或燒錄 `hex/gpio.hex`），以 115200 bps 開啟序列埠

推論韌體使用 PLL 64 MHz 系統時脈，並開啟 Cortex-M33 的 DWT 週期計數器供 Edge Impulse 計時。

### 預測流程

與 CH7 相同：

1. 每 5 秒量測一次，存入 7 筆（30 秒）的環狀歷史緩衝
2. 歷史滿 7 筆後，算出 22 個特徵
3. 同一個模型推論兩次：`target_type=0` 得溫度輸出（÷20 還原）、`target_type=1` 得溼度變化量
4. 預測值 ＝ 目前值 ＋ 變化量，存入 6 筆的預測佇列
5. 30 秒後取出當時的預測，與實際量測值比較並印出誤差

開機訊息：

```text
========================================
 HS300x + Edge Impulse Validation
 Sample interval : 5 sec
 History window  : 30 sec / 7 samples
 Forecast horizon: +30 sec
 Model input     : 22 history/trend features
 Model output    : scaled dT / real dRH
========================================
```

之後每 5 秒輸出一段 `NOW`、`HISTORY`、`TREND`、`VALIDATE`、`PRED DELTA`、`PRED +30 sec`，格式與 CH7 相同。

## 常見問題

| 狀況 | 處理方式 |
|---|---|
| 開機顯示 `ERR,I2C_DMA_Init` 或 `ERROR,I2C_INIT` | I2C／DMA 初始化失敗，檢查 HS3003 接線（PB9／PB7）與電源 |
| 顯示 `ERR,HS300X_StartMeasurement,<n>` | 感測器沒有回應，確認 I2C 位址 `0x44` 與上拉電阻 |
| `data_logger.py` 沒有存到資料 | 確認 `COM_PORT`、鮑率 115200，且輸出行以 `DATA,` 開頭 |
| 換成自己的模型後溫度預測偏差很大 | 確認 `data.py` 的 `--temp-label-scale` 與韌體的 `TEMP_LABEL_SCALE`（20）一致 |

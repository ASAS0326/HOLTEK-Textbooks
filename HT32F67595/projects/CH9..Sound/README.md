# CH9 聲音辨識：嬰兒哭聲偵測 — HT32F67595

與 CH5 相同的嬰兒哭聲辨識題目，改用 HT32F67595 與 SPH0645LM4H I2S 數位麥克風。推論端改用 Edge Impulse 的 **連續推論**（每 250 ms 更新一次結果），並加上多數決濾波，只在哭聲穩定出現時才輸出「開始哭／停止哭」事件。

## 學習目標

- 設定 HT32F67595 的 I2S 主機接收與 DMA 乒乓緩衝
- 用整數相位累加器把 31.25 kHz 音訊轉成 8 kHz，並去除直流偏移
- 使用 Edge Impulse Data Forwarder 收集音訊資料
- 使用 `run_classifier_continuous()` 以切片方式連續推論
- 設計後處理濾波，降低單次誤判造成的誤報

## 分類標籤

| 標籤 | 說明 |
|---|---|
| `cry` | 嬰兒哭聲 |
| `laugh` | 嬰兒笑聲 |
| `noise` | 背景雜音 |

## 硬體與接腳

| 功能 | 接腳 | 說明 |
|---|---|---|
| I2S WCLK（LRCLK） | PB0 | |
| I2S BCLK | PA9 | |
| I2S 資料 | PA21 | 麥克風資料輸入 |
| I2S MCLK | PA24 | |
| 麥克風電源 | PB11 | |
| 除錯輸出 UART0 TX | PA29 | 資料收集 921600；推論 115200 |

## 音訊處理流程

| 階段 | 設定 |
|---|---|
| I2S | I2S 標準格式、32-bit 聲道寬度，取樣率 16 MHz ÷ 8 ÷ 64 ＝ **31,250 Hz** |
| DMA | 兩塊 4 KB 緩衝輪流接收（乒乓） |
| 取聲道 | 只取 DMA 字組 1、3、5…（立體聲框中的其中一個聲道） |
| 格式轉換 | 24-bit 有號樣本右移 8 位 |
| 降頻 | 相位累加器：31,250 → 8,000 Hz（比例 32／125），每個輸出點取該區間樣本平均 |
| 去直流 | 一階 IIR 追蹤直流（右移 8 位），從樣本中扣除 |
| 輸出 | 8 kHz 單聲道 PCM16 |

## 資料夾結構

```text
CH9..Sound/
├── Data_Collection/ht32f675x5_r2/
│   ├── main.c
│   ├── src/  inc/                # I2S.c、SPH0645LM4H.c
│   ├── config/app_cfg.h          # 接腳、UART 設定
│   ├── project/                  # Keil 專案 gpio.uvprojx
│   ├── project_HT32-IDE/
│   └── hex/gpio.hex              # 預先編譯好的韌體
├── Run_Classification/ht32f675x5_r2/
│   ├── main.c
│   ├── src/  inc/                # ei_main.cpp、I2S.c、SPH0645LM4H.c
│   ├── config/  project/  project_HT32-IDE/
│   └── hex/gpio.hex
└── baby_cry-cmsis-package-v5-impulse-#1/
    ├── EdgeImpulse.baby_cry.5.0.0.pack   # 已訓練好的模型（與 CH5 相同）
    ├── EdgeImpulse.EI-SDK.1.95.13.pack
    └── edgeimpulse.clayer.yml
```

## 開發環境

- Keil MDK 5，Arm Compiler 6，裝置包 `Holtek.HT32F675x5_DFP` 1.0.5
- 推論專案另需 CMSIS 6.3.0、CMSIS-DSP 1.16.2、CMSIS-NN 4.0.0
- Node.js 與 Edge Impulse CLI（`npm install -g edge-impulse-cli`）
- Edge Impulse 帳號

不想編譯時，可直接燒錄 `hex/gpio.hex`。

## 步驟一：收集聲音資料

1. 開啟 `Data_Collection/ht32f675x5_r2/project/gpio.uvprojx` 編譯燒錄，或燒錄 `hex/gpio.hex`
2. 韌體以 **921600 bps** 從 UART0 輸出 8 kHz PCM，每行一個有號整數
3. 執行 Data Forwarder：

   ```bash
   edge-impulse-data-forwarder --baud-rate 921600
   ```

4. 登入並選擇專案，軸名稱輸入一個名稱（例如 `audio`），確認偵測到的頻率接近 **8000 Hz**
5. 在 Edge Impulse **Data acquisition** 頁面輸入標籤（`cry`／`laugh`／`noise`）開始錄製

> CH5（HT32F49395）與本章輸出相同格式的 8 kHz PCM，可以把兩塊板子收集的資料放進同一個 Edge Impulse 專案。

## 步驟二：在 Edge Impulse 訓練模型

1. **Create impulse**：Window size **1000 ms**、Frequency **8000 Hz**
2. Processing block：**Audio (MFCC)**
3. Learning block：Classification
4. **Deployment** 選擇 **CMSIS Pack** 匯出

本章附的模型 `baby_cry` 5.0.0（Edge Impulse 專案 1088064）：輸入 8000 筆（1 秒）、MFCC、3 個標籤，每個模型視窗切成 **4 個切片**（每片 2000 筆＝250 ms）。

## 步驟三：部署推論韌體

1. Keil **Pack Installer → File → Import** 匯入 `baby_cry-cmsis-package-v5-impulse-#1/` 內的兩個 `.pack`
2. 開啟 `Run_Classification/ht32f675x5_r2/project/gpio.uvprojx`，確認 RTE 已勾選 Edge Impulse SDK 與 `baby_cry` 模型元件
3. 編譯燒錄（或燒錄 `hex/gpio.hex`），以 **115200 bps** 開啟序列埠

推論韌體使用 PLL 64 MHz 系統時脈，並開啟 Cortex-M33 的 DWT 週期計數器供 Edge Impulse 計時。

### 推論流程

1. DMA 中斷把轉好的 8 kHz 樣本寫入環狀緩衝
2. 主迴圈每湊滿一個切片（2000 筆）就呼叫一次 `run_classifier_continuous()`
3. 前 4 個切片為暖機，顯示 `Warm-up slice n/4`
4. 之後每個切片都輸出一行完整的 1 秒視窗結果
5. 哭聲濾波器更新狀態，必要時附加 `>>> CRY START <<<`、`CRY` 或 `>>> CRY END <<<`

### 哭聲濾波規則

單一切片判為「哭」須同時滿足：

| 條件 | 門檻 |
|---|---|
| `cry` 分數 | ≥ 0.85 |
| `laugh` 分數 | ≤ 0.40 |
| `cry − laugh` | ≥ 0.25 |
| `cry − noise` | ≥ 0.25 |

事件判定：

- **開始哭**：最近 8 個切片中至少 6 個判為「哭」，且 8 個切片的 `cry` 平均 ≥ 0.75
- **停止哭**：連續 5 個切片不再符合條件

門檻定義在 `src/ei_main.cpp` 開頭（`CRY_THRESHOLD`、`CRY_MARGIN`、`LAUGH_VETO_THRESHOLD`、`CRY_REQUIRED_COUNT` 等），可依實際環境調整。

輸出範例（數值僅為示意）：

```text
==================================
   BABY CRY INFERENCE MODE START
==================================
Warm-up slice 1/4
...
Predictions: cry=0.9531, laugh=0.0102, noise=0.0367 | DSP=<n> ms, NN=<n> ms | >>> CRY START <<<
Predictions: cry=0.9412, laugh=0.0150, noise=0.0438 | DSP=<n> ms, NN=<n> ms | CRY
Predictions: cry=0.1203, laugh=0.0211, noise=0.8586 | DSP=<n> ms, NN=<n> ms | CRY
...
Predictions: cry=0.0809, laugh=0.0120, noise=0.9071 | DSP=<n> ms, NN=<n> ms | >>> CRY END <<<
```

## 常見問題

| 狀況 | 處理方式 |
|---|---|
| Data Forwarder 偵測到的頻率不是 8000 Hz | 確認鮑率 921600、燒錄的是資料收集韌體 |
| 出現 `WARNING: audio backlog, dropped=...` | 推論跟不上收音速度，樣本被丟棄；確認系統時脈為 PLL 64 MHz，並減少序列輸出量 |
| 出現 `WARNING: DMA error count=...` | I2S／DMA 傳輸錯誤，檢查麥克風接線與電源（PB11） |
| 一直沒有 `CRY START` | 濾波條件較嚴格，可先觀察每行的 `cry` 分數，再調整 `ei_main.cpp` 中的門檻 |
| 開機停在 `[E5] classifier init` 之前 | 檢查 RTE 是否正確加入模型元件，並重新編譯 |

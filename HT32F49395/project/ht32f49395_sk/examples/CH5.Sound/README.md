# CH5 聲音辨識：嬰兒哭聲偵測 — HT32F49395

以 ICS-43434 I2S 數位麥克風收音，將聲音串流到 Edge Impulse 建立嬰兒哭聲分類模型，再部署回 HT32F49395，每秒判斷一次環境聲音是「哭聲」、「笑聲」或「雜音」。

本章附有從 Edge Impulse 匯出的聲音資料集（`baby_cry-export/`，113 個 1 秒樣本），可以匯入自己的 Edge Impulse 專案直接訓練。

## 學習目標

- 設定 I2S 主機接收模式，搭配 DMA 循環緩衝與半滿／全滿中斷收音
- 把 48 kHz 的 24-bit 音訊降頻成 8 kHz 16-bit 單聲道 PCM
- 使用 Edge Impulse Data Forwarder 直接從序列埠收集音訊資料
- 部署 MFCC 音訊分類模型並在 MCU 上推論

## 分類標籤

| 標籤 | 說明 |
|---|---|
| `cry` | 嬰兒哭聲 |
| `laugh` | 嬰兒笑聲 |
| `noise` | 背景雜音 |

## 硬體與接腳

| 功能 | 周邊 | 接腳 | 說明 |
|---|---|---|---|
| I2S WS（LRCLK） | SPI2／I2S2 | PB12 | |
| I2S CK（BCLK） | SPI2／I2S2 | PB13 | |
| I2S SD（資料輸入） | SPI2／I2S2 | PB15 | |
| 序列輸出 | USART1 | PA9（TX） | 資料收集 921600、推論 115200 |

板上有兩顆 ICS-43434：U5 的 LR 接 GND（左聲道）、U6 的 LR 接 3.3 V（右聲道）。本章的資料收集與推論都使用 **右聲道（U6）**，兩者務必一致。

## 音訊處理流程

| 階段 | 設定 |
|---|---|
| I2S | Philips 標準、主機接收、48 kHz、24-bit 資料放在 32-bit 聲道框 |
| DMA | DMA1 Channel 4 循環模式，4096 個 halfword，半滿／全滿中斷 |
| 格式轉換 | 24-bit 樣本右移 8 位成 16-bit |
| 降頻 | 每 6 筆取平均（48 kHz ÷ 6 = 8 kHz），累加器跨 DMA 半緩衝保留，不丟樣本 |
| 輸出 | 8 kHz 單聲道 PCM16，每次最多 128 筆 |

## 資料夾結構

```text
CH5.Sound/
├── Data_collection/              # 資料收集韌體（串流 PCM 給 Data Forwarder）
│   ├── src/  inc/                # main.c、ICS43434 驅動
│   ├── mdk_v5/  mdk_v537/  HT32-IDE/
├── Run_Classification/           # 推論韌體
│   ├── src/  inc/                # main.c、ei_main.cpp、ICS43434 驅動
│   ├── mdk_v5/  mdk_v537/  HT32-IDE/
├── baby_cry-cmsis-package-v5-impulse-#1/
│   ├── EdgeImpulse.baby_cry.5.0.0.pack   # 已訓練好的模型
│   ├── EdgeImpulse.EI-SDK.1.95.13.pack   # Edge Impulse SDK
│   └── edgeimpulse.clayer.yml
└── baby_cry-export/              # 附帶資料集（Edge Impulse 匯出）
    ├── info.labels               # 全部樣本的標籤與 Training／Testing 分類
    ├── training/                 # 96 個樣本（JSON）＋info.labels
    ├── testing/                  # 17 個樣本（JSON）＋info.labels
    └── README.txt                # Edge Impulse 的匯入說明
```

> 兩個 `readme.txt` 是範本沿用下來的 SysTick 說明，內容與本章無關。

## 開發環境

- Keil MDK 5（實測 MDK 5.43a）：資料收集專案使用 Arm Compiler 6，推論專案使用 Keil 中設定的 Arm GNU Toolchain（GCC，實測 14.2），裝置包 `Holtek.HT32F493x5_DFP` 1.0.6
- 推論專案另需 CMSIS 6、CMSIS-DSP 1.16.2、CMSIS-NN 4.0.0
- Node.js 與 Edge Impulse CLI（`npm install -g edge-impulse-cli`）
- Edge Impulse 帳號

> `mdk_v5` 與 `mdk_v537` 兩種 Keil 專案的原始檔與元件相同，都可以編譯。

## 兩種做法

| 做法 | 適合情況 | 流程 |
|---|---|---|
| A. 使用附帶資料集 | 想先跑通整個流程，或手邊沒有嬰兒聲音可以錄 | 看過 [附帶資料集](#附帶資料集) 並匯入 Edge Impulse 後，直接到 [步驟二](#步驟二在-edge-impulse-訓練模型) |
| B. 自己收集資料 | 想用自己環境的聲音訓練 | 依序完成步驟一到步驟三 |

兩種做法也可以混用：先匯入附帶資料集，再用 Data Forwarder 把自己錄的聲音加進同一個專案。

## 步驟一：收集聲音資料

### 1. 燒錄資料收集韌體

開啟 `Data_collection/mdk_v5/led_toggle.uvprojx`，編譯並燒錄。

韌體以 **921600 bps** 從 USART1 輸出 PCM，**每行一個有號整數**（Data Forwarder 格式）：

```text
-12
35
128
...
```

這個 UART 只能有數字，韌體中不呼叫 `printf()`；若自行修改程式加入除錯訊息，Data Forwarder 會無法解析。

### 2. 用 Data Forwarder 上傳

```bash
edge-impulse-data-forwarder --baud-rate 921600
```

1. 第一次執行時登入 Edge Impulse 帳號並選擇專案
2. 軸名稱輸入一個名稱（例如 `audio`），CLI 會自動偵測取樣頻率，應接近 **8000 Hz**
3. 在 Edge Impulse **Data acquisition** 頁面選擇裝置、輸入標籤（`cry`／`laugh`／`noise`）與錄音長度後開始錄製

建議每個標籤收集數分鐘以上的資料，並包含不同距離與背景音量。

## 附帶資料集

`baby_cry-export/` 是 Edge Impulse 專案 `baby_cry` 的資料匯出。每個 JSON 檔是一個已切好的 **1 秒、8 kHz 單聲道** 樣本（8000 筆有號整數，`interval_ms` 0.125），檔名開頭就是標籤。

### 概況

| 標籤 | 訓練 | 測試 | 來源 |
|---|---|---|---|
| `cry` | 40 | 6 | 2 段 WAV 錄音切出 30 個＋Data Forwarder 收集 16 個 |
| `laugh` | 25 | 5 | 3 段 WAV 錄音 |
| `noise` | 31 | 6 | 2 段 WAV 錄音 |
| 合計 | 96（96 秒） | 17（17 秒） | |

- WAV 錄音的檔名是 `sph0645_record_binary*`，代表是以 SPH0645 麥克風（CH9 使用的麥克風）錄製；Data Forwarder 收集的 16 個 `cry` 樣本檔名為 `cry.json.*`
- 兩種來源的感測器名稱不同（WAV 為 `audio`、Data Forwarder 為 `voice`），都是單軸音訊

### 匯入 Edge Impulse

**方法一：Edge Impulse CLI**

```bash
cd baby_cry-export
edge-impulse-uploader --clean --info-file info.labels
```

`--clean` 會清除 CLI 記住的登入與專案設定，讓你重新選擇要匯入的專案；標籤與 Training／Testing 分類依 `info.labels` 設定。

**方法二：Edge Impulse Studio**

到 **Data acquisition → Upload data**：

1. 選取 `training/` 內所有 `.json`，Upload into category 選 **Training**，標籤選 **Infer from filename**
2. 再選取 `testing/` 內所有 `.json`，category 選 **Testing**，同樣從檔名推斷標籤

### 使用前要知道的事

- **測試集不是獨立的錄音**：17 個測試樣本和訓練樣本切自同一批 WAV 錄音，Model testing 的準確率會偏樂觀。要評估真實效果，請另外錄一段沒拿來訓練的聲音當測試資料
- **三個標籤的音量差很多**（訓練集的振幅）：

  | 標籤 | 最大振幅 | 平均標準差 |
  |---|---|---|
  | `cry` | 約 4,300 | 約 200 |
  | `laugh` | 約 25,000 | 約 3,300 |
  | `noise` | 約 1,200 | 約 60 |

  `laugh` 的音量比 `cry` 大一個數量級以上，模型可能把「大聲」當成判斷笑聲的線索。實際使用時若大聲的哭聲或雜音被誤判成 `laugh`，請補錄不同音量的資料
- **資料量偏少**：每個標籤只有 25～40 秒的訓練資料，建議再加上用本章板子收集的資料。本章使用的 ICS-43434 和錄製 WAV 的 SPH0645 是不同的麥克風，加入自己板子的資料能讓模型更貼近實際推論時的輸入

## 步驟二：在 Edge Impulse 訓練模型

使用附帶資料集時，匯入後從第 1 步開始即可。

1. **Create impulse**：Time series data，Window size **1000 ms**、Frequency **8000 Hz**
2. Processing block：**Audio (MFCC)**
3. Learning block：Classification
4. 訓練完成後到 **Deployment** 選擇 **CMSIS Pack** 匯出

本章附的模型 `baby_cry` 5.0.0（Edge Impulse 專案 1088064）：輸入 8000 筆（1 秒）、MFCC 特徵、3 個標籤，判定門檻 0.6。

## 步驟三：部署推論韌體

1. Keil **Pack Installer → File → Import** 匯入 `baby_cry-cmsis-package-v5-impulse-#1/` 內的兩個 `.pack`
2. 開啟 `Run_Classification/mdk_v5/led_toggle.uvprojx`，確認 RTE 已勾選 Edge Impulse SDK 與 `baby_cry` 模型元件
3. 編譯、燒錄，以 115200 bps 開啟序列埠

`ei_main.cpp` 在編譯期檢查模型必須是 **單軸、8000 Hz**；換成其他取樣率的模型會直接編譯失敗。

### 推論流程

1. DMA 持續收音，CPU 在資料未就緒時以 `__WFI()` 休眠
2. 收滿 8000 筆（1 秒）PCM 存入特徵陣列
3. PCM 直接轉成 `float`，**不要除以 32768**——Edge Impulse 音訊模型的輸入是原始振幅
4. 呼叫 `run_classifier()`，印出每個標籤的分數
5. 最高分 ≥ 0.6 時輸出該標籤，否則輸出 `UNCERTAIN`
6. DMA 不中斷，立刻開始收下一個視窗

輸出範例（數值僅為示意）：

```text
----------------------------------------
Sampling 1 second microphone window...
Sampling complete: 8000 samples
Predictions:
  cry = 0.912
  laugh = 0.031
  noise = 0.057
Result = cry (0.912)
Decision = cry
DSP=<n> ms, NN=<n> ms
```

## 常見問題

| 狀況 | 處理方式 |
|---|---|
| Data Forwarder 偵測不到資料或頻率不對 | 確認鮑率 921600、燒錄的是資料收集韌體，並關閉其他佔用 COM 埠的程式 |
| 收到的數值全為 0 或固定值 | 確認使用的聲道與麥克風 LR 接法一致（本章為右聲道 U6） |
| 推論結果與訓練時差很多 | 檢查資料收集與推論是否使用同一聲道、同一降頻方式，且輸入沒有被正規化 |
| 編譯出現 `This code expects an 8000 Hz Edge Impulse audio model.` | 模型的取樣率不是 8 kHz，請在 Edge Impulse 重新設定 Impulse |
| 用附帶資料集訓練，Model testing 很準但實際推論常判錯 | 附帶的測試集和訓練集來自同一批錄音，準確率偏樂觀；補錄本章板子的資料一起訓練，並另錄獨立的測試資料 |

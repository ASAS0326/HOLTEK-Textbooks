# CH6 影像辨識 — HT32F49395

用 HM01B0 低功耗灰階攝影機拍攝手勢影像，經序列埠傳到 PC 存檔，在 Edge Impulse 訓練「剪刀、石頭、布」影像分類模型，再部署回 HT32F49395 即時推論，並由 PC 端程式同時顯示畫面與辨識結果。

## 分類標籤

| 標籤 | 說明 |
|---|---|
| `paper` | 布 |
| `scissors` | 剪刀 |
| `stone` | 石頭 |
| `unknown` | 其他畫面（沒有手勢、背景等） |

## 學習目標

- 用 I2C 設定 HM01B0 攝影機暫存器
- 以計時器輸出攝影機主時脈、以輸入捕捉觸發 DMA 讀取 8-bit 平行資料
- 以 VSYNC／HREF 外部中斷同步影像幀
- 從 160 × 120 影像中央裁切 96 × 96 作為模型輸入
- 部署 Edge Impulse 影像分類模型並在 MCU 上推論

## 硬體與接腳

| 功能 | 周邊 | 接腳 | 說明 |
|---|---|---|---|
| MCLK | TMR3_CH2 輸出 | PA7 | 12 MHz 攝影機主時脈 |
| PCLK | TMR3_CH3 輸入捕捉 | PB0 | 每個像素時脈觸發一次 DMA |
| D0–D7 | GPIO | PC0–PC7 | 8-bit 平行資料 |
| VSYNC | EXINT2 | PA2 | 幀同步 |
| HREF | EXINT4 | PA4 | 行同步 |
| SCL／SDA | I2C1 | PB8／PB9 | 100 kHz，攝影機位址 `0x48`（8-bit 表示） |
| 電壓轉換器 OE | GPIO | PD2 | TXS0108E 致能 |
| 序列輸出 | USART1 | PA9（TX） | **2,250,000 bps** |

DMA：DMA1 Channel 2（由 TMR3_CH3 請求），把 PC0–PC7 的像素搬到記憶體。

## 影像規格

| 項目 | 數值 |
|---|---|
| 攝影機模式 | QQVGA、8-bit 灰階 |
| 每幀原始資料 | 164 × 122（含上下左右各 1 列／2 欄邊框） |
| 有效影像 | 160 × 120 |
| 模型輸入 | 中央裁切 **96 × 96**（9216 bytes） |

## 資料夾結構

```text
CH6.image/
├── Data_collection/              # 資料收集韌體
│   ├── src/                      # main.c、hm01b0.c/.h
│   ├── mdk_v5/  mdk_v537/  HT32-IDE/
├── Run_Classification/           # 推論韌體
│   ├── src/                      # main.c、ei_main.cpp、hm01b0.c/.h
│   ├── mdk_v5/  mdk_v537/  HT32-IDE/
├── holtek_image_classification-cmsis-package-v15-impulse-#1/
│   ├── EdgeImpulse.HOLTEK_Image_Classification.15.0.0.pack   # 已訓練好的模型
│   ├── EdgeImpulse.EI-SDK.1.95.10.pack                       # Edge Impulse SDK
│   └── edgeimpulse.clayer.yml
├── data_collection.py            # PC 端影像預覽與存檔
└── run_classification.py         # PC 端影像＋推論結果顯示
```

## 開發環境

- Keil MDK 5，Arm Compiler 6，裝置包 `Holtek.HT32F493x5_DFP` 1.0.6
- 推論專案另需 CMSIS 6、CMSIS-DSP 1.16.2、CMSIS-NN 4.0.0
- Python 3 套件：`pip install pyserial numpy opencv-python`
- USB 轉 UART 必須支援 **2.25 Mbps**
- Edge Impulse 帳號

## 序列傳輸格式

| 區段 | 內容 |
|---|---|
| `IMG_S` | 影像開頭（ASCII） |
| 9216 bytes | 96 × 96 灰階像素，逐列由上而下 |
| `IMG_E\r\n` | 影像結尾 |
| `INF_S` … `INF_E\r\n` | 推論結果文字（僅推論韌體） |

## 步驟一：收集影像

1. 開啟 `Data_collection/mdk_v5/data_collection.uvprojx`，編譯並燒錄
2. 修改 `data_collection.py` 開頭的 `SERIAL_PORT`（預設 `COM3`）為實際的 COM 埠
3. 執行：

   ```bash
   python data_collection.py
   ```

4. 視窗會顯示放大 4 倍的即時影像，標題列顯示 FPS
5. 按 `s` 存檔（`unknown_<時間戳>.jpg`），按 `q` 離開

存下的檔名開頭都是 `unknown`，請依類別（`paper`／`scissors`／`stone`／`unknown`）放到不同資料夾或重新命名，方便上傳時設定標籤；沒有手勢的背景畫面可以直接當作 `unknown` 類別。存檔的影像為放大 4 倍後的 384 × 384，上傳後 Edge Impulse 會依 Impulse 設定縮回 96 × 96。

開機時序列埠會先印出 `HM01B0 Model ID: 0x....` 與 `HM01B0 initialized.`；若顯示 `HM01B0 initialization failed!`，請檢查攝影機排線與 I2C 接線。

## 步驟二：在 Edge Impulse 訓練模型

1. **Data acquisition → Upload data**：依類別上傳影像並設定標籤
2. **Create impulse**：Image data，寬高 **96 × 96**
3. Processing block：**Image**，色彩深度選 **Grayscale**
4. Learning block：**Transfer Learning (Images)** 或 Classification
5. **Deployment** 選擇 **CMSIS Pack** 匯出

本章附的模型 `HOLTEK_Image_Classification` 15.0.0（Edge Impulse 專案 1083500，deploy v15）：輸入 96 × 96 灰階（9216 個值）、int8 量化、4 個標籤，判定門檻 0.6。

## 步驟三：部署推論韌體

1. Keil **Pack Installer → File → Import** 匯入 `holtek_image_classification-cmsis-package-v15-impulse-#1/` 內的兩個 `.pack`（若是自己訓練的模型，改匯入 Edge Impulse 下載的 Pack）
2. 開啟 `Run_Classification/mdk_v5/run_classification.uvprojx`，在 **Manage Run-Time Environment** 確認已勾選 Edge Impulse SDK 與模型元件
3. 編譯、燒錄
4. 修改 `run_classification.py` 的 `SERIAL_PORT` 後執行：

   ```bash
   python run_classification.py
   ```

視窗左側為即時影像，右側面板顯示 FPS、DSP／分類耗時、每個標籤的信心值，最高分以綠色標示。按 `q` 離開。

### 推論流程

1. VSYNC 中斷觸發 DMA 收一幀，完成後設定 `frame_ready`
2. 主迴圈暫停 VSYNC 中斷，將影像中央裁切成 96 × 96
3. 以 `IMG_S`／`IMG_E` 包住影像送到 PC
4. 重新開啟 VSYNC 中斷，呼叫 `run_classifier()`
5. 以 `INF_S`／`INF_E` 包住推論結果文字送出：

```text
INF_SPredictions (DSP: <n> ms., Classification: <n> ms., Anomaly: <n> ms.):
  <標籤1>: 0.93750
  <標籤2>: 0.06250
INF_E
```

`raw_feature_get_data()` 會把每個灰階值轉成 Edge Impulse 影像格式需要的 `0xRRGGBB` 數值（R＝G＝B＝灰階），模型的影像大小必須是 96 × 96，否則會印出 `The size of your buffer is not correct` 並停止。

## 常見問題

| 狀況 | 處理方式 |
|---|---|
| Python 開不了序列埠 | 確認 `SERIAL_PORT` 設定，且沒有其他程式佔用 |
| 畫面錯位或雜訊 | USB 轉 UART 不支援 2.25 Mbps 或線材品質不佳；更換轉接器 |
| 一直沒有畫面 | 確認攝影機初始化成功（Model ID 有印出），以及 PD2 的電壓轉換器有致能 |
| 推論結果始終同一類 | 確認訓練時使用 Grayscale、96 × 96，且訓練影像與實際拍攝環境（光線、距離）相近 |

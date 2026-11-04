# CH7 溫溼度趨勢預測 — HT32F49395

以 HS3003 溫溼度感測器每 5 秒量測一次，在 PC 端把歷史資料整理成迴歸（Regression）訓練集，用 Edge Impulse 訓練模型預測 **30 秒後** 的溫度與溼度，再部署回 HT32F49395，邊預測邊用實際量測值驗證誤差。

本章附有一份實際記錄約 **59 小時** 的資料集（`data/`）。沒有時間長時間記錄時，可以直接用它訓練模型。

## 學習目標

- 用 I2C＋DMA＋中斷以非阻塞方式讀取 HS3003
- 以 Python 長時間記錄感測資料並重新取樣成固定週期
- 設計時間序列特徵（歷史值、變化量、加速度）建立迴歸資料集
- 用「一個模型、兩種目標」的方式同時預測溫度與溼度
- 在 MCU 上驗證預測值與 30 秒後實際值的誤差

## 硬體與接腳

| 功能 | 周邊 | 接腳 | 說明 |
|---|---|---|---|
| HS3003 SCL | I2C1 | PB8 | |
| HS3003 SDA | I2C1 | PB9 | |
| I2C TX／RX | DMA1 | Channel 6／7 | |
| 序列輸出 | USART1 | PA9（TX） | 115200 8N1 |

## 資料夾結構

```text
CH7.Temperature_and_humidity/
├── Data_collection/              # 資料收集韌體（每 5 秒輸出一筆）
│   ├── src/  inc/                # main.c、hs300x 驅動
│   ├── mdk_v5/  mdk_v537/  HT32-IDE/
├── Run_Classification/           # 預測韌體
│   ├── src/  inc/                # main.c、ei_main.cpp、hs300x 驅動
│   ├── mdk_v5/  mdk_v537/  HT32-IDE/
├── t&h2-cmsis-package-v2-impulse-#1/
│   ├── EdgeImpulse.T_H2.2.0.0.pack       # 已訓練好的模型
│   ├── EdgeImpulse.EI-SDK.1.95.13.pack   # Edge Impulse SDK
│   └── edgeimpulse.clayer.yml
├── data/                         # 附帶資料集（data.py 的輸出）
│   ├── ei_22in1out_trend_train.csv
│   ├── ei_22in1out_trend_test.csv
│   ├── ei_22in1out_trend_train_unbalanced.csv
│   ├── ei_22in1out_trend_all.csv
│   ├── audit_all.csv
│   └── resampled_5sec.csv
├── data_logger.py                # PC 端：接收序列資料存成 CSV
└── data.py                       # PC 端：產生 Edge Impulse 迴歸資料集
```

> 兩個 `readme.txt` 是範本沿用下來的 SysTick 說明，內容與本章無關。`data.py` 檔頭說明裡的檔名 `prepare_edge_impulse_22in1out_trend.py` 指的就是 `data.py`。
>
> `data_logger.py`、`data.py` 與 `data/` 和 CH10（HT32F67595）共用，兩塊板子的序列輸出格式相同。

## 開發環境

- Keil MDK 5（實測 MDK 5.43a）：資料收集專案使用 Arm Compiler 6，推論專案使用 Keil 中設定的 Arm GNU Toolchain（GCC，實測 14.2），裝置包 `Holtek.HT32F493x5_DFP` 1.0.6
- 推論專案另需 CMSIS 6.3.0、CMSIS-DSP 1.16.2、CMSIS-NN 4.0.0
- Python 3 與 `pyserial`
- Edge Impulse 帳號

> `mdk_v5` 與 `mdk_v537` 兩種 Keil 專案的原始檔與元件相同，都可以編譯。

## 兩種做法

| 做法 | 適合情況 | 流程 |
|---|---|---|
| A. 使用附帶資料集 | 想先跑通整個流程，或沒時間記錄數小時以上的資料 | 看過 [附帶資料集](#附帶資料集) 後，直接到 [步驟三](#步驟三在-edge-impulse-訓練模型) 上傳 `data/` 內的檔案 |
| B. 自己收集資料 | 想用自己環境的資料訓練 | 依序完成步驟一到步驟四 |

## 步驟一：記錄溫溼度資料

### 1. 燒錄資料收集韌體

開啟 `Data_collection/mdk_v5/led_toggle.uvprojx`，編譯並燒錄。韌體每 5 秒啟動一次量測，量測期間 CPU 以 `__WFI()` 休眠，序列埠輸出：

```text
HS300x Data Logger Start
DATA,1,25.42,60.15
DATA,2,25.43,60.20
```

格式為 `DATA,序號,溫度(°C),溼度(%RH)`。錯誤時輸出 `ERROR,HS3003_STATUS,<n>` 或 `ERROR,I2C,<n>`。

### 2. 用 `data_logger.py` 存檔

先修改檔案開頭的 `COM_PORT`（預設 `COM3`），再執行：

```bash
python data_logger.py
```

- 每收到一筆 `DATA` 就附上 PC 時間寫入 `log_data/data.csv`，欄位為 `timestamp, sample, temperature_c, humidity_rh`
- 每筆都會 `fsync`，中途斷電也不會遺失已收到的資料
- 序列埠斷線時每 5 秒自動重連，按 Ctrl+C 結束

記錄時間越長越好（建議數小時以上），並刻意製造溼度 **上升**、**下降**、**持平** 三種情況（例如開關窗戶、靠近熱水、開冷氣）。`data.py` 要求訓練資料三種狀態都要有，否則會停止。

## 步驟二：產生 Edge Impulse 資料集

```bash
python data.py log_data/data.csv
```

可選參數：

| 參數 | 預設 | 說明 |
|---|---|---|
| `--output-dir` | `edge_impulse_22in1out_trend` | 輸出資料夾 |
| `--train-ratio` | 0.8 | 訓練集比例 |
| `--rh-threshold` | 0.5 | 判定溼度上升／下降的門檻（%RH） |
| `--temp-label-scale` | 20 | 溫度變化量標籤放大倍率 |
| `--max-gap-sec` | 15 | 兩筆間隔超過此秒數視為不同區段，不跨區段插值 |
| `--minority-target` | 5000 | 訓練集中上升／下降各自補到的數量 |
| `--stable-max` | 20000 | 訓練集中持平最多保留的數量 |
| `--seed` | 1234 | 平衡時隨機抽樣的亂數種子 |

### 處理流程

1. **重新取樣**：在每個連續區段內用線性插值補成固定 5 秒一筆
2. **建立樣本**：每個時間點取前 30 秒（7 筆）歷史與 30 秒後的實際值；視窗跨到中斷處的時間點不採用
3. **分類溼度狀態**：30 秒後溼度變化 > +0.5 %RH 為 `rising`、< −0.5 %RH 為 `falling`，其餘為 `stable`
4. **切分**：前 80% 為訓練集、後 20% 為測試集，中間空出 30 秒避免共用未來資料
5. **平衡**：只對訓練集做；上升／下降不足時重複抽樣，持平過多時隨機刪減。測試集保持原始分布
6. **展開**：每個時間點產生兩列，`target_type=0` 預測溫度、`target_type=1` 預測溼度

### 22 個輸入特徵

| 類別 | 欄位 | 數量 |
|---|---|---|
| 歷史值 | `t_m30, rh_m30, t_m25, rh_m25, … , t_now, rh_now` | 14 |
| 變化量 | `dt_5, dt_15, dt_30, drh_5, drh_15, drh_30` | 6 |
| 溼度加速度 | `rh_accel_10s` ＝（最近 10 秒變化）−（前一個 10 秒變化） | 1 |
| 目標選擇 | `target_type`（0＝溫度、1＝溼度） | 1 |

### 標籤

| `target_type` | `label` |
|---|---|
| 0 | （30 秒後溫度 − 目前溫度）× 20 |
| 1 | 30 秒後溼度 − 目前溼度 |

溫度變化量通常很小，放大 20 倍讓兩種目標的數值範圍接近。

### 輸出檔案

| 檔案 | 欄位 | 用途 |
|---|---|---|
| `ei_22in1out_trend_train.csv` | 22 個特徵＋`label` | 上傳為訓練資料（已平衡） |
| `ei_22in1out_trend_test.csv` | 22 個特徵＋`label` | 上傳為測試資料（原始分布） |
| `ei_22in1out_trend_train_unbalanced.csv` | 22 個特徵＋`label` | 未平衡的訓練資料，比較用 |
| `ei_22in1out_trend_all.csv` | 22 個特徵＋`label` | 全部資料 |
| `audit_all.csv` | `timestamp`、`rh_state`、21 個特徵、30 秒後的溫溼度與變化量、`temperature_label_scaled` | 每個時間點一列，方便人工檢查 |
| `resampled_5sec.csv` | `timestamp, temperature_c, humidity_rh` | 重新取樣後的 5 秒資料 |

## 附帶資料集

`data/` 是用本章韌體與 `data_logger.py` 實際記錄，再以 `data.py` 預設參數產生的結果，檔案與步驟二的輸出格式完全相同。

### 記錄概況

| 項目 | 數值 |
|---|---|
| 記錄期間 | 2026-09-13 ～ 2026-09-20 |
| 重新取樣後資料點 | 42,580 筆（5 秒一筆，合計約 59 小時） |
| 溫度範圍 | 26.55 ～ 31.06 °C |
| 溼度範圍 | 27.09 ～ 89.49 %RH |
| 有效時間點 | 42,525 個 |

連續記錄區段：

| 區段 | 時間 | 長度 |
|---|---|---|
| 1 | 09-13 14:02 ～ 09-13 16:21 | 2.3 小時 |
| 2 | 09-15 13:08 ～ 09-16 02:30 | 13.4 小時 |
| 3 | 09-18 18:06 ～ 09-19 18:09 | 24.1 小時 |
| 4 | 09-19 18:11 ～ 09-20 13:35 | 19.4 小時 |

區段 3 與 4 之間還有兩段不到 1 分鐘的零碎資料（記錄短暫中斷），長度湊不滿「30 秒歷史＋30 秒未來」，因此沒有產生樣本。

### 溼度狀態分布

| 資料 | `rising` | `falling` | `stable` | 時間點 | CSV 列數 |
|---|---|---|---|---|---|
| 全部 | 1,440 | 1,556 | 39,529 | 42,525 | 85,050 |
| 訓練集（平衡前） | 1,283 | 1,278 | 31,459 | 34,020 | 68,040 |
| 訓練集（平衡後） | 5,000 | 5,000 | 20,000 | 30,000 | 60,000 |
| 測試集 | 157 | 278 | 8,064 | 8,499 | 16,998 |

- `stable` 約佔全部的 93%，溼度在 30 秒內變化超過 ±0.5 %RH 的情況只有約 7%，所以訓練集需要平衡
- 每個時間點展開成兩列（溫度、溼度各一），CSV 列數是時間點的兩倍
- 訓練集為 09-13 ～ 09-20 01:46，測試集為最後約 12 小時（09-20 01:46 ～ 13:35）；訓練與測試合計 42,519 個時間點，少的 6 個就是兩者之間空出的 30 秒

### 標籤範圍

| 目標 | 30 秒實際變化量 | `label` |
|---|---|---|
| 溫度（`target_type=0`） | −0.465 ～ +0.516 °C | −9.30 ～ +10.32 |
| 溼度（`target_type=1`） | −16.15 ～ +21.02 %RH | 與變化量相同 |

### 參考基準

如果完全不預測，直接把「目前值」當作 30 秒後的值（等於模型永遠輸出 0），在測試集上的誤差為：

| 目標 | MAE（`label` 尺度） | 換算實際單位 |
|---|---|---|
| 溫度 | 0.184 | 0.0092 °C |
| 溼度 | 0.213 | 0.213 %RH |
| 兩者合計 | 0.198 | — |

測試集大部分時間溼度持平，這個基準已經不差；訓練出的模型在測試集上的誤差要明顯低於它，才代表真的學到變化趨勢。

### 調整參數重新產生

`resampled_5sec.csv` 有 `data.py` 需要的三個欄位，可以直接當輸入，用不同參數重新產生資料集，例如調高溼度門檻：

```bash
python data.py data/resampled_5sec.csv --output-dir data_rh1 --rh-threshold 1.0
```

> 以預設參數重新產生時，因為 `resampled_5sec.csv` 的數值只保留到小數第 6 位，結果與附檔有極小的差異（數值差在 0.00002 以內），另有 2 個溼度變化剛好等於 ±0.5 %RH 的時間點會被分到 `stable`，不影響使用。

若要合併自己收集的資料，把 `log_data/data.csv` 的 `timestamp, temperature_c, humidity_rh` 三欄接在 `resampled_5sec.csv` 後面再執行 `data.py` 即可。`data.py` 會依時間排序，並自動把不同時段當成不同區段處理。

## 步驟三：在 Edge Impulse 訓練模型

1. **Data acquisition → Upload data**：用 CSV Wizard 上傳 `ei_22in1out_trend_train.csv`（Training）與 `ei_22in1out_trend_test.csv`（Testing），22 個欄位為特徵、`label` 欄為數值標籤。使用附帶資料集時，上傳 `data/` 內的同名檔案
2. **Create impulse**：Processing block 選 **Raw data**，Learning block 選 **Regression**
3. 訓練後到 **Model testing** 檢查測試集誤差，並與上方的 [參考基準](#參考基準) 比較
4. **Deployment** 選擇 **CMSIS Pack** 匯出

本章附的模型 `T&H2` 2.0.0（Edge Impulse 專案 1112124）：22 個輸入、1 個迴歸輸出。

## 步驟四：部署預測韌體

1. Keil **Pack Installer → File → Import** 匯入 `t&h2-cmsis-package-v2-impulse-#1/` 內的兩個 `.pack`
2. 開啟 `Run_Classification/mdk_v5/led_toggle.uvprojx`，確認 RTE 已勾選 Edge Impulse SDK 與 `T_H2` 模型元件
3. 編譯、燒錄，以 115200 bps 開啟序列埠

`ei_main.cpp` 在編譯期檢查模型輸入必須剛好 22 個特徵。

### 預測流程

1. 每 5 秒量測一次，存入 7 筆的環狀歷史緩衝
2. 前 7 筆（30 秒）只累積歷史，顯示 `waiting...`
3. 歷史滿了以後，用與 `data.py` 相同的公式算出 22 個特徵
4. 同一個模型推論兩次：`target_type=0` 得到溫度輸出（÷20 還原）、`target_type=1` 得到溼度變化量
5. 預測值 ＝ 目前值 ＋ 變化量，存入 6 筆的預測佇列
6. 6 筆（30 秒）後取出當時的預測，與實際量測值比較並印出誤差

輸出範例（數值僅為示意）：

```text
========================================
[Sample #12]
NOW           T=25.42 C | RH=60.15 %RH
HISTORY       [-30:25.30,59.80] [-25:25.32,59.85] ... [0:25.42,60.15]
TREND         dT5=0.02 dT15=0.06 dT30=0.12 | dRH5=0.05 dRH15=0.20 dRH30=0.35 | RH_ACC=0.05
[VALIDATE #6 -> #12]
Temperature : PRED=25.40 C, ACTUAL=25.42 C, ERR=0.02 C
Humidity    : PRED=60.05 %RH, ACTUAL=60.15 %RH, ERR=0.10 %RH
PRED DELTA    dT=0.03 C | dRH=0.12 %RH
PRED +30 sec  T=25.45 C | RH=60.27 %RH
========================================
```

## 常見問題

| 狀況 | 處理方式 |
|---|---|
| `data.py` 顯示「CSV 缺少欄位」 | 輸入檔必須有 `timestamp, temperature_c, humidity_rh` 欄位，請使用 `data_logger.py` 產生的 CSV 或 `data/resampled_5sec.csv` |
| `data.py` 顯示「Training 資料沒有同時包含 rising / falling / stable」 | 資料中溼度變化太少，請延長記錄並製造溼度上升與下降的情境，或調低 `--rh-threshold` |
| `data.py` 顯示「有效的 30 秒歷史/未來樣本太少」 | 記錄時間太短或中斷太多，至少需要數十分鐘的連續資料 |
| 預測韌體一直顯示 `waiting...` | 需要累積 7 筆（約 30 秒）才開始預測；若超過仍未開始，檢查是否有 `ERR,HS3003` 訊息 |
| 換成自己的模型後溫度預測偏差很大 | 確認 `--temp-label-scale` 與韌體的 `TEMP_LABEL_SCALE`（20）一致 |
| 用附帶資料集訓練，實際部署誤差偏大 | 附帶資料的溫度只涵蓋 26.55 ～ 31.06 °C，超出範圍的環境請加入自己收集的資料一起訓練 |

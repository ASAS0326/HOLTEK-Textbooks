# HOLTEK Edge AI 教材範例

以 Holtek HT32 微控制器搭配 Edge Impulse 實作邊緣 AI 的教材範例。每個章節都包含三個階段：用板子收集感測資料、在 Edge Impulse 訓練模型、把模型部署回板子推論。

## 章節總覽

| 章節 | 主題 | MCU | 感測器 | 模型類型 |
|---|---|---|---|---|
| [CH4](HT32F49395/project/ht32f49395_sk/examples/CH4.Super_Smart_Racket/README.md) | 超級智慧球拍 | HT32F49395 | LSM6DS3 六軸 IMU | 揮拍動作分類（7 類），BLE 傳送結果 |
| [CH5](HT32F49395/project/ht32f49395_sk/examples/CH5.Sound/README.md) | 嬰兒哭聲偵測 | HT32F49395 | ICS-43434 I2S 麥克風 | 音訊分類（MFCC） |
| [CH6](HT32F49395/project/ht32f49395_sk/examples/CH6.image/README.md) | 影像辨識：剪刀石頭布 | HT32F49395 | HM01B0 灰階攝影機 | 影像分類（96 × 96） |
| [CH7](HT32F49395/project/ht32f49395_sk/examples/CH7.Temperature_and_humidity/README.md) | 溫溼度趨勢預測 | HT32F49395 | HS3003 溫溼度 | 迴歸（預測 30 秒後） |
| [CH8](HT32F67595/projects/CH8.Super_Smart_Racket/README.md) | 超級智慧球拍 | HT32F67595 | LSM6DS3 六軸 IMU | 揮拍動作分類（7 類），內建 BLE |
| [CH9](HT32F67595/projects/CH9..Sound/README.md) | 嬰兒哭聲偵測 | HT32F67595 | SPH0645LM4H I2S 麥克風 | 音訊分類（連續推論） |
| [CH10](HT32F67595/projects/CH10.Temperature_and_humidity/README.md) | 溫溼度趨勢預測 | HT32F67595 | HS3003 溫溼度 | 迴歸（預測 30 秒後） |

CH4–CH7 使用 HT32F49395 開發板；CH8–CH10 以內建 BLE 5.1 的雙核心 HT32F67595 實作相同題目，PC 端腳本與資料格式可以共用。

## 目錄結構

```text
HOLTEK-Textbooks/
├── HT32F49395/
│   ├── libraries/                # CMSIS、周邊驅動
│   ├── middlewares/              # FreeRTOS、I2C 應用程式庫、USB
│   ├── project/
│   │   ├── ht32f493x5_board/     # 板級支援（LED、按鍵、除錯 UART）
│   │   └── ht32f49395_sk/examples/   # CH4–CH7
│   └── utilities/
└── HT32F67595/
    ├── libraries/  sources/  third_party/  tools/   # SDK、BLE 堆疊、bin2array 等工具
    └── projects/                 # CH8–CH10
```

## 共通開發環境

- Keil MDK 5（資料收集專案用 Arm Compiler 6，推論專案用 Arm GNU Toolchain／GCC）或 HT32-IDE
- Holtek 裝置包：`HT32F493x5_DFP`、`HT32F675x5_DFP`
- CMSIS、CMSIS-DSP、CMSIS-NN
- Python 3（`pyserial`；CH6 另需 `numpy`、`opencv-python`）
- Edge Impulse 帳號；聲音章節需 Edge Impulse CLI（Data Forwarder）

## 各章內容

每章都包含以下部分：

| 章節 | 資料收集 | 推論 | 模型 Pack | PC 端 Python |
|---|---|---|---|---|
| CH4 | `Data_collection/` | `Run_Classification/` | `pinpon2-cmsis-package-v1-impulse-#1/` | `collect_training_data.py` |
| CH5 | `Data_collection/` | `Run_Classification/` | `baby_cry-cmsis-package-v5-impulse-#1/` | —（使用 Edge Impulse Data Forwarder） |
| CH6 | `Data_collection/` | `Run_Classification/` | `holtek_image_classification-cmsis-package-v15-impulse-#1/` | `data_collection.py`、`run_classification.py` |
| CH7 | `Data_collection/` | `Run_Classification/` | `t&h2-cmsis-package-v2-impulse-#1/` | `data_logger.py`、`data.py` |
| CH8 | `Data_collection/` | `Run_Classification/` | `pinpon_model/` | `collect_training_data.py` |
| CH9 | `Data_collection/` | `Run_Classification/` | `baby_cry-cmsis-package-v5-impulse-#1/` | —（使用 Edge Impulse Data Forwarder） |
| CH10 | `Data_collection/` | `Run_Classification/` | `t&h2-cmsis-package-v2-impulse-#1/` | `data_logger.py`、`data.py` |

相同題目在兩塊板子上使用同一份 Python 腳本（CH4／CH8、CH7／CH10 的 `.py` 內容完全相同）。各章附的 Edge Impulse CMSIS Pack 可以直接部署體驗，再用自己收集的資料重新訓練。

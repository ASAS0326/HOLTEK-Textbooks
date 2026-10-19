import csv
import os
import serial
import time
from datetime import datetime


# ============================================================
# Configuration
# ============================================================

# HT32 UART COM Port
COM_PORT = "COM3"

# 一定要和 HT32 UART Baud Rate 完全相同
BAUD_RATE = 115200

# CSV 儲存位置
SAVE_DIRECTORY = "./log_data"
CSV_FILE = os.path.join(SAVE_DIRECTORY, "data.csv")

# Serial timeout
SERIAL_TIMEOUT_SEC = 1

# Serial 斷線後重新連線等待時間
RECONNECT_DELAY_SEC = 5


# ============================================================
# Initialize folder
# ============================================================

os.makedirs(
    SAVE_DIRECTORY,
    exist_ok=True
)


# ============================================================
# Create CSV header
# ============================================================

if not os.path.exists(CSV_FILE):

    with open(
        CSV_FILE,
        mode="w",
        newline="",
        encoding="utf-8-sig"
    ) as file:

        writer = csv.writer(file)

        writer.writerow([
            "timestamp",
            "sample",
            "temperature_c",
            "humidity_rh"
        ])


# ============================================================
# Start Information
# ============================================================

print("========================================")
print(" HS300x Data Logger")
print("========================================")
print(f"COM Port : {COM_PORT}")
print(f"Baud Rate: {BAUD_RATE}")
print(f"CSV File : {CSV_FILE}")
print("Save mode: Every valid DATA packet")
print("========================================")


# ============================================================
# Main
# ============================================================

while True:

    ser = None

    try:

        # ----------------------------------------------------
        # Open Serial Port
        # ----------------------------------------------------

        ser = serial.Serial(
            COM_PORT,
            BAUD_RATE,
            timeout=SERIAL_TIMEOUT_SEC
        )

        print(
            f"[{datetime.now():%Y-%m-%d %H:%M:%S}] "
            "Serial connected."
        )


        # ----------------------------------------------------
        # Receive Loop
        # ----------------------------------------------------

        while True:

            # ------------------------------------------------
            # Read UART
            # ------------------------------------------------

            raw_line = ser.readline()

            if not raw_line:
                continue


            # ------------------------------------------------
            # Decode UART
            # ------------------------------------------------

            try:

                line = raw_line.decode(
                    "utf-8",
                    errors="ignore"
                ).strip()

            except UnicodeDecodeError:

                continue


            if not line:
                continue


            # ------------------------------------------------
            # Show MCU UART
            # ------------------------------------------------

            print(
                f"UART -> {line}"
            )


            # ------------------------------------------------
            # Only process DATA packet
            #
            # Expected:
            #
            # DATA,1,25.42,60.15
            #
            # DATA,
            # sample,
            # temperature,
            # humidity
            # ------------------------------------------------

            if not line.startswith("DATA,"):
                continue


            # ------------------------------------------------
            # Split DATA
            # ------------------------------------------------

            parts = line.split(",")


            if len(parts) != 4:

                print(
                    f"Invalid DATA format: {line}"
                )

                continue


            # ------------------------------------------------
            # Convert DATA
            # ------------------------------------------------

            try:

                sample = int(
                    parts[1]
                )

                temperature = float(
                    parts[2]
                )

                humidity = float(
                    parts[3]
                )

            except ValueError:

                print(
                    f"Invalid numeric data: {line}"
                )

                continue


            # ------------------------------------------------
            # PC Timestamp
            # ------------------------------------------------

            timestamp = datetime.now().strftime(
                "%Y-%m-%d %H:%M:%S"
            )


            # ------------------------------------------------
            # Save CSV
            #
            # IMPORTANT:
            #
            # 不再使用 Python 5 秒計時。
            #
            # MCU 已經控制：
            #
            # SAMPLE_INTERVAL_MS = 5000
            #
            # 因此 Python 每收到一筆 DATA
            # 就立即儲存。
            # ------------------------------------------------

            with open(
                CSV_FILE,
                mode="a",
                newline="",
                encoding="utf-8-sig"
            ) as file:

                writer = csv.writer(file)

                writer.writerow([
                    timestamp,
                    sample,
                    f"{temperature:.2f}",
                    f"{humidity:.2f}"
                ])

                # 確保資料立即寫入檔案
                file.flush()

                os.fsync(
                    file.fileno()
                )


            # ------------------------------------------------
            # Show Saved DATA
            # ------------------------------------------------

            print(
                f"SAVED -> "
                f"{timestamp} | "
                f"#{sample} | "
                f"T={temperature:.2f} C | "
                f"RH={humidity:.2f} %"
            )


    # ========================================================
    # Serial Error
    # ========================================================

    except serial.SerialException as error:

        print(
            f"[{datetime.now():%Y-%m-%d %H:%M:%S}] "
            f"Serial error: {error}"
        )

        print(
            f"Reconnect after "
            f"{RECONNECT_DELAY_SEC} seconds..."
        )

        time.sleep(
            RECONNECT_DELAY_SEC
        )


    # ========================================================
    # Ctrl + C
    # ========================================================

    except KeyboardInterrupt:

        print()
        print(
            "Data logging stopped by user."
        )

        break


    # ========================================================
    # Close Serial
    # ========================================================

    finally:

        if ser is not None:

            if ser.is_open:

                ser.close()
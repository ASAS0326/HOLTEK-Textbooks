#include "LSM6DS3.h"
#include "i2c.h"
#include <stdio.h>
#include <string.h>

#include "hw_crg.h"
#include "hw_pmu.h"
#include "hw_efuse.h"
#include "hw_gpio.h"
#include "hw_i2c.h"
#include "hw_sys_ctrl.h"
#include "hw_wdt.h"
#include "hal_pmu.h"
#include "hw_dma.h"
#include "patch_hw_i2c.h"

#include "app_cfg.h"
#include "boards.h"
#include "utility.h"
#include "app_debug.h"

static int lsm6ds3_ready;

static int lsm6ds3_write_reg(uint8_t reg_addr, uint8_t data)
{
    gpu8MasterSendData[0] = reg_addr;
    gpu8MasterSendData[1] = data;
    
    return (int)patch_hw_i2c_master_write(I2C_HANDLE, gpu8MasterSendData, 2, 1);
}

static int lsm6ds3_read_regs(uint8_t reg_addr, uint8_t *pBuf, uint16_t len)
{
    int sta;
    
    gpu8MasterSendData[0] = reg_addr;
    
    sta = (int)patch_hw_i2c_master_write(I2C_HANDLE, gpu8MasterSendData, 1, 0);
    if (sta != 0) return sta;
    
   
    sta = (int)patch_hw_i2c_master_read(I2C_HANDLE, pBuf, len, 0);
    if (sta != 0) return sta;
    
    return (int)patch_hw_i2c_master_send_stop(I2C_HANDLE);
}


void lsm6ds3_init(void)
{
    uint8_t who_am_i = 0;
    uint8_t config[3];
    int sta;

    lsm6ds3_ready = 0;
    sta = lsm6ds3_read_regs(LSM6DS3_WHO_AM_I, &who_am_i, 1);
    if (sta != 0 || who_am_i != 0x6A) {
        PRINTF("LSM6DS3 Connect Failed.\r\n");
        return;
    }

    /* ODR_XL[7:4] = 0100 (104 Hz), FS_XL[3:2] = 01 (+/-16 g). */
    sta = lsm6ds3_write_reg(LSM6DS3_CTRL1_XL, 0x44);
    if (sta != 0) {
        PRINTF("LSM6DS3 CTRL1_XL Write Failed: %d\r\n", sta);
        return;
    }

    /* Match the archived ICM-20948 range to avoid clipping fast swings.
     * ODR_G[7:4] = 0100 (104 Hz), FS_G[3:2] = 11 (+/-2000 dps).
     * FS_125[1] = 0; reserved bit [0] = 0.
     */
    sta = lsm6ds3_write_reg(LSM6DS3_CTRL2_G, 0x4C);
    if (sta != 0) {
        PRINTF("LSM6DS3 CTRL2_G Write Failed: %d\r\n", sta);
        return;
    }

    /* BDU=1, IF_INC=1, BLE=0: coherent little-endian burst samples. */
    sta = lsm6ds3_write_reg(LSM6DS3_CTRL3_C, 0x44);
    if (sta != 0) {
        PRINTF("LSM6DS3 CTRL3_C Write Failed: %d\r\n", sta);
        return;
    }
    sta = lsm6ds3_read_regs(LSM6DS3_CTRL1_XL, config, 3);
    if (sta != 0 || config[0] != 0x44 || config[1] != 0x4C ||
        config[2] != 0x44) {
        PRINTF("LSM6DS3 configuration readback failed.\r\n");
        return;
    }

    rom_delay_ms(50);
    lsm6ds3_ready = 1;
    PRINTF("LSM6DS3 Init OK: WHO_AM_I=0x%02X\r\n", who_am_i);
    PRINTF("Accelerometer: 104 Hz, +/-16 g, CTRL1_XL=0x44\r\n");
    PRINTF("Gyroscope: 104 Hz, +/-2000 dps, CTRL2_G=0x4C\r\n");
    PRINTF("IMU1: seq,read_us,Ax_raw,Ay_raw,Az_raw,Gx_raw,Gy_raw,Gz_raw\r\n");
    PRINTF("Collector: Acc=raw*0.000488 g; Gyro=raw*0.070 dps; nominal 104 Hz\r\n");
}

int lsm6ds3_is_ready(void)
{
    return lsm6ds3_ready;
}

int lsm6ds3_data_ready(void)
{
    uint8_t status = 0;
    if (!lsm6ds3_ready) return -1;
    if (lsm6ds3_read_regs(LSM6DS3_STATUS_REG, &status, 1) != 0) return -1;
    /* XLDA[0] and GDA[1] clear when the corresponding outputs are read. */
    return ((status & 0x03U) == 0x03U) ? 1 : 0;
}

static float lsm6ds3_ei_count(float value)
{
    if (value >= 32767.0f) return 32767.0f;
    if (value <= -32768.0f) return -32768.0f;
    return (float)(int32_t)(value >= 0.0f ? value + 0.5f : value - 0.5f);
}

void lsm6ds3_raw_to_ei(const int16_t raw[6], float out[6])
{
    unsigned int i;
    for (i = 0; i < 3; ++i) {
        out[i] = lsm6ds3_ei_count((float)raw[i] *
            LSM6DS3_ACCEL_G_PER_LSB * LSM6DS3_EI_ACCEL_COUNTS_PER_G);
        out[3 + i] = lsm6ds3_ei_count((float)raw[3 + i] *
            LSM6DS3_GYRO_DPS_PER_LSB * LSM6DS3_EI_GYRO_COUNTS_PER_DPS);
    }
}

void lsm6ds3_debug_ei(const int16_t raw[6], const float out[6])
{
#if LSM6DS3_EI_DEBUG_EVERY_N > 0
    static uint32_t count;
    if (++count < LSM6DS3_EI_DEBUG_EVERY_N) return;
    count = 0;
    PRINTF("RAW: AX=%d AY=%d AZ=%d GX=%d GY=%d GZ=%d\r\n",
        (int)raw[0], (int)raw[1], (int)raw[2],
        (int)raw[3], (int)raw[4], (int)raw[5]);
    PRINTF("EI INPUT: AX=%ld AY=%ld AZ=%ld GX=%ld GY=%ld GZ=%ld\r\n",
        (long)out[0], (long)out[1], (long)out[2],
        (long)out[3], (long)out[4], (long)out[5]);
#else
    (void)raw;
    (void)out;
#endif
}

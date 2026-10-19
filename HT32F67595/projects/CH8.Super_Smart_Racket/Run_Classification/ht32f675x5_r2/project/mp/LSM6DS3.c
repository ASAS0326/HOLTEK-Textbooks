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



/* Initialization and FIFO configuration follow ST AN5130.
 * Low-level I2C write/read/STOP helpers above are intentionally unchanged.
 */
static int sensor_ready = 0;

#define FIFO_CTRL1      0x06U
#define FIFO_CTRL2      0x07U
#define FIFO_CTRL3      0x08U
#define FIFO_CTRL4      0x09U
#define FIFO_CTRL5      0x0AU
#define FIFO_STATUS1    0x3AU
#define FIFO_DATA_OUT_L 0x3EU
#define FIFO_CONTINUOUS_104HZ 0x26U

void lsm6ds3_init(void)
{
    uint8_t who = 0;
    uint8_t actual[3];
    static const uint8_t config[][2] = {
        { FIFO_CTRL5, 0x00U }, /* Bypass flushes the FIFO. */
        { LSM6DS3_CTRL3_C, LSM6DS3_CTRL3_C_VALUE },
        { LSM6DS3_CTRL1_XL, LSM6DS3_CTRL1_XL_VALUE },
        { LSM6DS3_CTRL2_G, LSM6DS3_CTRL2_G_VALUE },
        { FIFO_CTRL1, 0x00U }, /* No watermark interrupt. */
        { FIFO_CTRL2, 0x00U }, /* No timestamps, temperature or pedometer in FIFO. */
        { FIFO_CTRL3, 0x09U }, /* Store every gyro and accelerometer sample. */
        { FIFO_CTRL4, 0x00U }  /* No external sensors; all 16 bits per axis. */
    };
    sensor_ready = 0;
    if (lsm6ds3_read_regs(LSM6DS3_WHO_AM_I, &who, 1) != 0 || who != 0x6A) {
        PRINTF("LSM6DS3 Connect Failed. WHO_AM_I=0x%02X\r\n", who);
        return;
    }
    for (unsigned int i = 0; i < sizeof(config) / sizeof(config[0]); ++i) {
        if (lsm6ds3_write_reg(config[i][0], config[i][1]) != 0) {
            PRINTF("LSM6DS3 initialization write failed: 0x%02X\r\n", config[i][0]);
            return;
        }
    }
    if (lsm6ds3_read_regs(LSM6DS3_CTRL1_XL, actual, 3) != 0 ||
        actual[0] != LSM6DS3_CTRL1_XL_VALUE ||
        actual[1] != LSM6DS3_CTRL2_G_VALUE ||
        actual[2] != LSM6DS3_CTRL3_C_VALUE) {
        PRINTF("LSM6DS3 configuration readback failed.\r\n");
        return;
    }
    rom_delay_ms(50);
    sensor_ready = 1;
    PRINTF("LSM6DS3: 104Hz, Acc +/-16g (0.000488g/LSB), Gyro +/-2000dps (0.070dps/LSB)\r\n");
    PRINTF("CTRL1_XL=0x44 CTRL2_G=0x4C CTRL3_C=0x44; Ax,Ay,Az,Gx,Gy,Gz\r\n");
}

int lsm6ds3_is_ready(void)
{
    return sensor_ready;
}

static int16_t decode_i16_le(const uint8_t *bytes)
{
    uint16_t value = (uint16_t)bytes[0] | ((uint16_t)bytes[1] << 8);
    return (int16_t)((value & 0x8000U) ? (int32_t)value - 65536 : value);
}

static void decode_6axis(const uint8_t data[12], int16_t raw[6])
{
    /* Output registers and FIFO pattern are Gx,Gy,Gz,Ax,Ay,Az. */
    for (unsigned int axis = 0; axis < 3; ++axis) {
        raw[axis] = decode_i16_le(&data[6 + axis * 2]);
        raw[axis + 3] = decode_i16_le(&data[axis * 2]);
    }
}

void lsm6ds3_raw_to_physical(const int16_t raw[6], float physical[6])
{
    for (unsigned int axis = 0; axis < 3; ++axis) {
        physical[axis] = raw[axis] * LSM6DS3_ACC_G_PER_LSB;
        physical[axis + 3] = raw[axis + 3] * LSM6DS3_GYRO_DPS_PER_LSB;
    }
}

static uint32_t fifo_diagnostics;
static int fifo_has_sample;

uint32_t lsm6ds3_fifo_diagnostics(void)
{
    return fifo_diagnostics;
}

/* Read count and flags BEFORE considering pattern. An empty/partial FIFO is
 * normal at 104 Hz and does not provide a complete six-axis sample.
 */
static int fifo_read_status(uint16_t *words, uint16_t *pattern)
{
    uint8_t status[4];
    if (lsm6ds3_read_regs(FIFO_STATUS1, status, 4) != 0) return LSM6DS3_ERR_IO;
    *words = (uint16_t)status[0] | ((uint16_t)(status[1] & 0x07U) << 8);
    *pattern = (uint16_t)status[2] | ((uint16_t)(status[3] & 0x03U) << 8);
    fifo_diagnostics = (uint32_t)*words | ((uint32_t)*pattern << 12) |
                       ((uint32_t)status[1] << 24);
    if (status[1] & 0x40U) return LSM6DS3_ERR_FIFO_OVERRUN;
    if (status[1] & 0x10U) *words = 0;
    return 0;
}

int lsm6ds3_fifo_start(void)
{
    uint8_t actual[5];
    fifo_has_sample = 0;
    fifo_diagnostics = 0;
    if (!sensor_ready) return LSM6DS3_ERR_NOT_READY;
    if (lsm6ds3_write_reg(FIFO_CTRL5, 0x00U) != 0 ||
        lsm6ds3_write_reg(FIFO_CTRL5, FIFO_CONTINUOUS_104HZ) != 0 ||
        lsm6ds3_read_regs(FIFO_CTRL1, actual, 5) != 0) {
        return LSM6DS3_ERR_IO;
    }
    if (actual[0] != 0 || actual[1] != 0 || actual[2] != 0x09U ||
        actual[3] != 0 || actual[4] != FIFO_CONTINUOUS_104HZ) {
        return LSM6DS3_ERR_FIFO_CONFIG;
    }
    return 0;
}

int lsm6ds3_fifo_read_6axis_raw(int16_t raw[6])
{
    uint8_t data[12], discard[2];
    uint16_t words, pattern;
    int ret;
    if (!sensor_ready) return LSM6DS3_ERR_NOT_READY;
    ret = fifo_read_status(&words, &pattern);
    if (ret != 0) return ret;

    /* Leave one six-word frame in FIFO. This avoids racing the empty boundary
     * and adds only one sensor period (~9.6 ms) of buffering, not a rate change.
     */
    if (words < 12U) return 0;
    if (pattern >= 6U) return LSM6DS3_ERR_FIFO_PATTERN;
    if (pattern != 0U) {
        if (fifo_has_sample) return LSM6DS3_ERR_FIFO_PATTERN;
        /* At startup only, discard a partial leading frame to reach Gx.
         * Never splice a later alignment loss into an existing model window.
         */
        for (uint16_t i = pattern; i < 6U; ++i) {
            if (lsm6ds3_read_regs(FIFO_DATA_OUT_L, discard, 2) != 0)
                return LSM6DS3_ERR_IO;
        }
        ret = fifo_read_status(&words, &pattern);
        if (ret != 0) return ret;
        if (words < 12U) return 0;
        if (pattern != 0U) return LSM6DS3_ERR_FIFO_PATTERN;
    }

    /* Explicit 16-bit FIFO words: each transaction starts at 0x3E/0x3F.
     * Keep the existing I2C helper/STOP flow. Do not assume that the board's
     * sensor/transport returns all six words correctly in a 12-byte burst.
     */
    for (unsigned int word = 0; word < 6U; ++word) {
        if (lsm6ds3_read_regs(FIFO_DATA_OUT_L, &data[word * 2U], 2) != 0)
            return LSM6DS3_ERR_IO;
    }
    ret = fifo_read_status(&words, &pattern);
    if (ret != 0) return ret;
    if (words >= 6U && pattern != 0U) return LSM6DS3_ERR_FIFO_PATTERN;
    decode_6axis(data, raw);
    fifo_has_sample = 1;
    return 1;
}

/* Legacy direct-read API retained for existing callers; return order unchanged. */
int lsm6ds3_read_6axis_raw(
    int16_t *gyro_x, int16_t *gyro_y, int16_t *gyro_z,
    int16_t *accel_x, int16_t *accel_y, int16_t *accel_z)
{
    uint8_t data[12];
    int16_t raw[6];
    int ret;
    if (!sensor_ready) return LSM6DS3_ERR_NOT_READY;
    ret = lsm6ds3_read_regs(LSM6DS3_OUTX_L_G, data, 12);
    if (ret != 0) return ret;
    decode_6axis(data, raw);
    *accel_x = raw[0]; *accel_y = raw[1]; *accel_z = raw[2];
    *gyro_x = raw[3]; *gyro_y = raw[4]; *gyro_z = raw[5];
    return 0;
}
 
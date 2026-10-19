#ifndef __LSM6DS3_H
#define __LSM6DS3_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define LSM6DS3TRC_WHO_VALUE    0x6A

typedef struct
{
  int16_t ax;
  int16_t ay;
  int16_t az;
  int16_t gx;
  int16_t gy;
  int16_t gz;
} lsm6ds3trc_data_type;

/* =========================================================================================
 * Registers
 * ========================================================================================= */

#define LSM6DS3_WHO_AM_I        0x0F
#define LSM6DS3_CTRL1_XL        0x10
#define LSM6DS3_CTRL2_G         0x11
#define LSM6DS3_CTRL3_C         0x12
#define LSM6DS3_CTRL4_C         0x13
#define LSM6DS3_STATUS_REG      0x1E
#define LSM6DS3_OUTX_L_G        0x22


/* =========================================================================================
 * Sensor configuration (same as the ht32f675x5_r2 Data_collection firmware)
 *
 * CTRL1_XL = 0x44 : 104 Hz, +/-16 g    -> 0.000488 g/LSB
 * CTRL2_G  = 0x4C : 104 Hz, +/-2000 dps -> 0.070 dps/LSB
 * CTRL3_C  = 0x44 : BDU=1, IF_INC=1
 *
 * IMU1 serial frames carry the signed raw values; collect_training_data.py
 * multiplies them by the factors below.
 * ========================================================================================= */

#define LSM6DS3_CTRL1_XL_VALUE  0x44
#define LSM6DS3_CTRL2_G_VALUE   0x4C
#define LSM6DS3_CTRL3_C_VALUE   0x44

#define LSM6DS3_ACCEL_G_PER_LSB     (0.000488f)
#define LSM6DS3_GYRO_DPS_PER_LSB    (0.070f)


/* =========================================================================================
 * CS
 * ========================================================================================= */

#define LSM6DS3_CS_HIGH()       gpio_bits_set(GPIOE, GPIO_PINS_5)
#define LSM6DS3_CS_LOW()        gpio_bits_reset(GPIOE, GPIO_PINS_5)


/* =========================================================================================
 * DMA
 * ========================================================================================= */

#define LSM6DS3_DMA_RX_CHANNEL  DMA1_CHANNEL3
#define LSM6DS3_DMA_TX_CHANNEL  DMA1_CHANNEL4

#define LSM6DS3_DMA_RX_IRQn     DMA1_Channel3_IRQn
#define LSM6DS3_DMA_TX_IRQn     DMA1_Channel4_IRQn

#define LSM6DS3_DMA_SIZE        12U


/*
 * Known-good polling initialization.
 * DMA is NOT touched inside this function.
 */
uint8_t lsm6ds3trc_init(void);

uint8_t lsm6ds3trc_who_am_i(void);
uint8_t lsm6ds3trc_read_register(uint8_t reg);

/*
 * Reset and reconfigure the sensor while the application runs.
 * delay_ms() reprograms SysTick, so the caller passes a wait that does
 * not, and keeps every other SPI user (the sampling interrupt) off the
 * bus meanwhile. Returns 1 when the configuration reads back correctly.
 */
uint8_t lsm6ds3trc_reconfigure(void (*wait_ms)(uint32_t ms));


/*
 * Runtime DMA/IRQ layer.
 * Call only after lsm6ds3trc_init() has returned 1.
 */
void lsm6ds3trc_dma_init(void);

/*
 * 1 when both XLDA and GDA are set (a new 104 Hz sample is waiting).
 * Polling SPI read; returns 0 while a DMA burst is in progress.
 */
uint8_t lsm6ds3trc_data_ready(void);

/*
 * Polling SPI burst of the twelve output bytes (no DMA).
 * Returns 0 while a DMA burst is in progress.
 */
uint8_t lsm6ds3trc_read_6axis(lsm6ds3trc_data_type *data);

uint8_t lsm6ds3trc_start_6axis_dma(void);
void lsm6ds3trc_process(void);

uint8_t lsm6ds3trc_get_6axis( lsm6ds3trc_data_type *data);

uint8_t lsm6ds3trc_is_busy(void);

void lsm6ds3trc_get_last_raw(uint8_t raw[12]);


/* DMA IRQ hooks */
void lsm6ds3trc_dma_rx_irq_handler(void);
void lsm6ds3trc_dma_tx_irq_handler(void);


/* Validation */
uint32_t lsm6ds3trc_get_dma_irq_count(void);
uint32_t lsm6ds3trc_get_dma_error_count(void);

#ifdef __cplusplus
}
#endif

#endif

#ifndef __LSM6DS3_H__
#define __LSM6DS3_H__

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define LSM6DS3_ADDR        0x6A
#define LSM6DS3_WHO_AM_I    0x0F
#define LSM6DS3_CTRL1_XL    0x10
#define LSM6DS3_CTRL2_G     0x11
#define LSM6DS3_CTRL3_C     0x12
#define LSM6DS3_OUTX_L_G    0x22

/* Same physical units and ranges as the pinpon v3 training recorder.
 * CTRL1_XL = 0x44: 104 Hz, +/-16 g, 0.488 mg/LSB.
 * CTRL2_G  = 0x4C: 104 Hz, +/-2000 dps, 70 mdps/LSB.
 * The model consumes six axes; no magnetometer, offsets or axis inversions.
 */
#define LSM6DS3_CTRL1_XL_VALUE  0x44U
#define LSM6DS3_CTRL2_G_VALUE   0x4CU
#define LSM6DS3_CTRL3_C_VALUE   0x44U /* BDU, IF_INC, little-endian */
#define LSM6DS3_ODR_HZ         104U
#define LSM6DS3_ACC_G_PER_LSB   0.000488f
#define LSM6DS3_GYRO_DPS_PER_LSB 0.070f

#define LSM6DS3_ERR_IO         (-1)
#define LSM6DS3_ERR_NOT_READY  (-2)
#define LSM6DS3_ERR_FIFO       (-3) /* Legacy general FIFO error. */
#define LSM6DS3_ERR_FIFO_CONFIG  (-10)
#define LSM6DS3_ERR_FIFO_OVERRUN (-11)
#define LSM6DS3_ERR_FIFO_PATTERN (-12)

void lsm6ds3_init(void);
int lsm6ds3_is_ready(void);
int lsm6ds3_fifo_start(void);
/* bits 0..10: words; 12..21: pattern; 24..31: raw FIFO_STATUS2. */
uint32_t lsm6ds3_fifo_diagnostics(void);
/* 1 = complete sample, 0 = not yet available, negative = reset stream. */
int lsm6ds3_fifo_read_6axis_raw(int16_t raw[6]);
/* Both arrays are Ax, Ay, Az, Gx, Gy, Gz; output is g, g, g, dps, dps, dps. */
void lsm6ds3_raw_to_physical(const int16_t raw[6], float physical[6]);

int lsm6ds3_read_6axis_raw(
    int16_t *gyro_x,
    int16_t *gyro_y,
    int16_t *gyro_z,
    int16_t *accel_x,
    int16_t *accel_y,
    int16_t *accel_z
);

#ifdef __cplusplus
}
#endif

#endif

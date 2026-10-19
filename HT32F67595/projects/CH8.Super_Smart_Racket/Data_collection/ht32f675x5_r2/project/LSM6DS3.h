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
#define LSM6DS3_STATUS_REG  0x1E
#define LSM6DS3_OUTX_L_G    0x22 

/* Sensitivity for CTRL1_XL=0x44 and CTRL2_G=0x4C:
 * acceleration: 0.488 mg/LSB = 0.000488 g/LSB
 * angular rate: 70 mdps/LSB = 0.070 dps/LSB (+/-2000 dps)
 * Multiply each signed int16_t raw value by the corresponding factor.
 * IMU1 serial frames carry signed raw values in Ax,Ay,Az,Gx,Gy,Gz order.
 * collect_training_data.py converts them to g/dps for NEW 104 Hz training.
 * The old myTrainSet model instead needs the count conversion below.
 */
#define LSM6DS3_ACCEL_G_PER_LSB     (0.000488f)
#define LSM6DS3_GYRO_DPS_PER_LSB    (0.070f)

/* Archived ICM-20948 raw6 path: +/-16 g, +/-2000 dps; gravity retained.
 * myTrainSet contains integer counts, not g, m/s^2, dps or rad/s.
 */
#define LSM6DS3_EI_ACCEL_COUNTS_PER_G   (2048.0f)
#define LSM6DS3_EI_GYRO_COUNTS_PER_DPS  (16.4f)
#ifndef LSM6DS3_EI_DEBUG_EVERY_N
#define LSM6DS3_EI_DEBUG_EVERY_N 0U /* Capture mode: avoid blocking UART logs.
                                   * Set 100 for manual RAW/EI diagnostics. */
#endif

void lsm6ds3_init(void);
int lsm6ds3_is_ready(void);
/* 1: both sensors have new data, 0: wait, negative: communication error. */
int lsm6ds3_data_ready(void);

/* Both arrays are Ax,Ay,Az,Gx,Gy,Gz. Identity axis/sign mapping; no bias,
 * gravity removal, normalization or temporal filter. Output is signed-int16
 * equivalent counts carried in float, rounded and saturated before inference.
 */
void lsm6ds3_raw_to_ei(const int16_t raw[6], float out[6]);
void lsm6ds3_debug_ei(const int16_t raw[6], const float out[6]);

#ifdef __cplusplus
}
#endif
#endif

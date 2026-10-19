#include "ht32f493x5_board.h"
#include "ht32f493x5_clock.h"
#include "LSM6DS3.h"

#include <stdio.h>
#include <stdint.h>


/*
 * UART output is line-for-line the same as the ht32f675x5_r2
 * Data_collection firmware (i2c.c + LSM6DS3.c there):
 *
 *   LSM6DS3 Init OK / Accelerometer / Gyroscope / IMU1: / Collector:  once
 *   #FW,... and #STREAM,...                                          once
 *   #RATE,<fps> fps,err=<n>                                once per second
 *   IMU1,seq,read_us,Ax_raw,Ay_raw,Az_raw,Gx_raw,Gy_raw,Gz_raw  per sample
 *
 * Raw values are signed LSB at +/-16 g and +/-2000 dps (see LSM6DS3.h);
 * collect_training_data.py converts them to g and dps.
 * A read starts only when XLDA and GDA are set, so the rate is the
 * sensor's 104 Hz ODR.
 */

#define IMU_POLL_INTERVAL_US      200UL
#define RATE_REPORT_INTERVAL_US   1000000UL
#define IMU_WAIT_REPORT_US        1000000UL


extern uint32_t SysTick_GetTick(void);
extern __IO uint32_t uwTick;


/*
 * Microseconds from the 1 ms SysTick: uwTick plus the elapsed part of the
 * current tick. Wraps naturally at 2^32 us; the collector unwraps it.
 */
static uint32_t imu_now_us(void)
{
  uint32_t ms;
  uint32_t val;

  do
  {
    ms = uwTick;
    val = SysTick->VAL;
  } while(ms != uwTick);

  return (ms * 1000U) +
         ((SysTick->LOAD - val) / (system_core_clock / 1000000U));
}


/* Report completed transmissions, not the configured sensor ODR. */
static uint32_t capture_fps_x10(uint32_t samples,
                                uint32_t elapsed_us)
{
  if(elapsed_us == 0U)
  {
    return 0U;
  }

  return (uint32_t)(((uint64_t)samples * 10000000ULL + elapsed_us / 2U) /
                    elapsed_us);
}


int main(void)
{
  lsm6ds3trc_data_type imu;

  uint32_t now_us;
  uint32_t last_poll_us;
  uint32_t last_sample_us;
  uint32_t rate_since_us;
  uint32_t fps_x10;

  uint32_t sequence = 0U;
  uint32_t sent_window = 0U;
  uint32_t error_base;
  uint32_t error_now;


  system_clock_config();

  ht32_board_init();

  uart_print_init(115200);


  /*
   * Stage 1:
   * EXACT known-good polling initialization.
   */
  if(lsm6ds3trc_init() == 0U)
  {
    printf("LSM6DS3 Connect Failed.\r\n");

    while(1)
    {
    }
  }


  printf("LSM6DS3 Init OK: WHO_AM_I=0x%02X\r\n",
         lsm6ds3trc_who_am_i());
  printf("Accelerometer: 104 Hz, +/-16 g, CTRL1_XL=0x%02X\r\n",
         LSM6DS3_CTRL1_XL_VALUE);
  printf("Gyroscope: 104 Hz, +/-2000 dps, CTRL2_G=0x%02X\r\n",
         LSM6DS3_CTRL2_G_VALUE);
  printf("IMU1: seq,read_us,Ax_raw,Ay_raw,Az_raw,Gx_raw,Gy_raw,Gz_raw\r\n");
  printf("Collector: Acc=raw*0.000488 g; Gyro=raw*0.070 dps; nominal 104 Hz\r\n");


  /*
   * Stage 3:
   * DMA/NVIC is enabled only now.
   */
  nvic_priority_group_config(
      NVIC_PRIORITY_GROUP_4);


  lsm6ds3trc_dma_init();


  printf("#FW,PINPON_C_FAST104_V2,%s,%s\r\n",
         __DATE__, __TIME__);
  printf("#STREAM,104Hz,115200baud,IMU1,recording-only\r\n");


  /*
   * All delay_ms() calls are finished.
   * Configure permanent 1 ms tick for runtime scheduling.
   */
  uwTick = 0U;

  if(SysTick_Config(
         system_core_clock / 1000U) != 0U)
  {
    printf("Capture clock init failed.\r\n");

    while(1)
    {
    }
  }


  now_us =
      imu_now_us();

  last_poll_us = now_us;
  last_sample_us = now_us;
  rate_since_us = now_us;
  error_base = lsm6ds3trc_get_dma_error_count();


  while(1)
  {
    now_us =
        imu_now_us();


    if((uint32_t)(now_us - rate_since_us) >=
       RATE_REPORT_INTERVAL_US)
    {
      fps_x10 =
          capture_fps_x10(sent_window,
                          (uint32_t)(now_us - rate_since_us));

      error_now =
          lsm6ds3trc_get_dma_error_count();

      /* One short status line per second; the recorder does not count
       * it as a six-axis sample. */
      printf("#RATE,%lu.%lu fps,err=%lu\r\n",
             (unsigned long)(fps_x10 / 10U),
             (unsigned long)(fps_x10 % 10U),
             (unsigned long)(error_now - error_base));

      error_base = error_now;
      rate_since_us = now_us;
      sent_window = 0U;
    }


    /*
     * No fixed 10 ms timer: the next read waits for XLDA and GDA.
     * No __WFI either, the 1 ms wake-up is too coarse for 104 Hz.
     *
     * The twelve output bytes are read with the known-good polling
     * SPI access; the DMA burst returned misaligned registers.
     */
    if((uint32_t)(now_us - last_poll_us) >=
       IMU_POLL_INTERVAL_US)
    {
      last_poll_us =
          now_us;

      if(lsm6ds3trc_data_ready() == 0U)
      {
        if((uint32_t)(now_us - last_sample_us) >=
           IMU_WAIT_REPORT_US)
        {
          printf("IMU waiting for fresh accel/gyro data.\r\n");

          last_sample_us = now_us;
        }
      }
      else if(lsm6ds3trc_read_6axis(&imu) != 0U)
      {
        last_sample_us = now_us;

        /* Compact frame: no floating-point printf. */
        printf("IMU1,%lu,%lu,%d,%d,%d,%d,%d,%d\r\n",
               (unsigned long)sequence++,
               (unsigned long)now_us,
               (int)imu.ax, (int)imu.ay, (int)imu.az,
               (int)imu.gx, (int)imu.gy, (int)imu.gz);

        sent_window++;
      }
    }
  }
}

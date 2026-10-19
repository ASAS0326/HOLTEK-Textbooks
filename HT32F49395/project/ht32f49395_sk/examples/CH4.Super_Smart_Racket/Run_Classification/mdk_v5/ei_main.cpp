#include "ei_main.h"

#include "ht32f493x5.h"
#include "ht32f493x5_board.h"

extern "C" {
#include "LSM6DS3.h"
#include "ble_uart4.h"
}

#include "ei_run_classifier.h"
#include "edge-impulse-sdk/porting/ei_classifier_porting.h"

#include <math.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

/*
 * pinpon2 V7 (Edge Impulse project 1121506, deploy version 7,
 * CMSIS pack EdgeImpulse.pinpon2.7.0.0)
 *
 *   input  : 52 samples of Ax Ay Az [g] + Gx Gy Gz [dps] at 104 Hz
 *   labels : BC BP BS FC FP FS NONE
 *
 * All versions share the input, labels, window and normalisation
 * (identical standard-scaler arrays; Edge Impulse kept them even after
 * clips were added, so they do not tell which data a version saw).
 * V2 changed the network from Conv2D/MaxPool to fully-connected layers
 * (312-20-10-7); V3 to V7 keep that network with retrained weights.
 * The V6/V7 packs ask for EI-SDK 1.95.15; its sources are identical to the
 * 1.95.14 pack this project uses (only the version number differs).
 *
 * The training clips were recorded with pinpon_C and
 * collect_training_data.py: LSM6DS3 at +/-16 g and +/-2000 dps,
 * one polling read per XLDA/GDA, cut around the gyro-magnitude peak
 * of a swing with the peak at index 31 of the window.
 * swing_push() mirrors firmware_peaks() in that script, so the model
 * sees the same alignment it was trained on.
 */

#define IMU_AXIS_COUNT        6U
#define IMU_INTERVAL_US       ((uint32_t)(EI_CLASSIFIER_INTERVAL_MS * 1000.0 + 0.5))
#define IMU_GAP_US            (IMU_INTERVAL_US * 3U / 2U)
#define IMU_TIMEOUT_US        100000U
#define IMU_FIFO_SIZE         64U   /* 0.6 s: covers inference + BLE output */

#define SWING_WINDOW          ((uint32_t)EI_CLASSIFIER_RAW_SAMPLE_COUNT)
#define SWING_PEAK_INDEX      31U
#define SWING_AFTER_PEAK      (SWING_WINDOW - SWING_PEAK_INDEX - 1U)
#define SWING_THRESHOLD_DPS   250.0f
#define SWING_REFRACTORY      47U   /* 0.45 s from the peak of a stroke */

#define NONE_LABEL            "NONE"

/*
 * V2 AI frame parsed by index.html (32 bytes, little-endian):
 *
 *    0  u8  0xAA, 0x55     sync
 *    2  u8  0x01           version
 *    3  u8  0x02           type AI
 *    4  u32                frame sequence number
 *    8  u32                read time of the peak sample [us]
 *   12  u8                 label index (BC BP BS FC FP FS NONE)
 *   13  u8                 confidence * 255
 *   14  u16 x 7            class scores * 10000
 *   28  u16                run_classifier() time [ms]
 *   30  u16                sum of bytes 0..29
 */
#define AI_FRAME_SIZE         32U
#define AI_FRAME_SYNC0        0xAAU
#define AI_FRAME_SYNC1        0x55U
#define AI_FRAME_VERSION      0x01U
#define AI_FRAME_TYPE_AI      0x02U
#define AI_FRAME_CLASS_COUNT  7U

/*
 * The BM67C593 BLE module forwards UART data only when its receive
 * buffer fills (index.html showed bursts of 97..159 bytes, cut in the
 * middle of a frame), not when the UART goes idle, so a lone frame
 * waited for the next swings. Follow every frame with zeros so the
 * buffer always fills right behind it; index.html skips the zeros
 * while looking for 0xAA 0x55.
 */
#define BLE_FLUSH_PAD_SIZE    160U

/*
 * Catches a build that still picks an older pack. Before bumping this for
 * a new deployment, check its window, labels and axes against this file.
 */
static_assert(EI_CLASSIFIER_PROJECT_DEPLOY_VERSION == 7,
              "expected pinpon2 deploy version 7 (EdgeImpulse.pinpon2.7.0.0 pack)");

static_assert(EI_CLASSIFIER_RAW_SAMPLES_PER_FRAME == IMU_AXIS_COUNT,
              "pinpon2 expects Ax Ay Az Gx Gy Gz");

static_assert(SWING_WINDOW == 52U,
              "peak index 31 belongs to the 0.5 s window of pinpon2");

static_assert(EI_CLASSIFIER_LABEL_COUNT == AI_FRAME_CLASS_COUNT,
              "the V2 frame carries seven class scores");

static float features[
    EI_CLASSIFIER_DSP_INPUT_FRAME_SIZE] = {0};

/*
 * Samples read in the 1 ms SysTick interrupt, so the stream keeps
 * going while run_classifier() and the blocking UART/BLE output run.
 * Written only by ei_main_sample_tick(), read only by read_one_imu().
 */
typedef struct
{
  lsm6ds3trc_data_type imu;
  uint32_t read_us;
} imu_sample_t;

static imu_sample_t imu_fifo[IMU_FIFO_SIZE];
static volatile uint32_t imu_fifo_head = 0U;
static volatile uint32_t imu_fifo_tail = 0U;
static volatile bool imu_sampler_on = false;

/*
 * Last SWING_WINDOW raw samples, imu_head points to the oldest one.
 */
static lsm6ds3trc_data_type imu_ring[SWING_WINDOW];
static uint32_t imu_head = 0U;

/*
 * Swing detector state, kept across ei_main() calls.
 */
static struct
{
  bool     started;
  uint32_t last_us;   /* read time of the newest sample */
  uint32_t n;         /* sample index, also advanced over lost samples */
  uint32_t run;       /* samples since the last gap, up to SWING_WINDOW */
  bool     rising;    /* |gyro| was below the threshold since the last swing */
  bool     active;    /* a swing is open, its peak is not confirmed yet */
  uint32_t peak;
  uint32_t peak_us;   /* read time of the peak sample */
  float    peak_dps;
  uint32_t rearm;     /* no new swing starts before this sample index */
} swing;

static int raw_feature_get_data(
    size_t offset,
    size_t length,
    float *out_ptr)
{
  memcpy(
      out_ptr,
      features + offset,
      length * sizeof(float));

  return 0;
}

static uint32_t now_us(void)
{
  return (uint32_t)ei_read_timer_us();
}

/*
 * Called from SysTick_Handler every 1 ms.
 *
 * Reads a new 104 Hz sample (XLDA and GDA set) with the polling SPI
 * burst, the same way pinpon_C/src/main.c does. 1 ms polling is well
 * inside the 9.6 ms ODR, so no sample is skipped.
 */
extern "C"
void ei_main_sample_tick(void)
{
  lsm6ds3trc_data_type imu;
  uint32_t next;

  if(!imu_sampler_on)
  {
    return;
  }

  if(lsm6ds3trc_data_ready() == 0U)
  {
    return;
  }

  if(lsm6ds3trc_read_6axis(
         &imu) == 0U)
  {
    return;
  }

  next =
      (imu_fifo_head + 1U) %
      IMU_FIFO_SIZE;

  /*
   * Full: drop the sample, swing_push() sees the time jump as a gap.
   */
  if(next == imu_fifo_tail)
  {
    return;
  }

  imu_fifo[imu_fifo_head].imu = imu;
  imu_fifo[imu_fifo_head].read_us = now_us();

  imu_fifo_head = next;
}

/*
 * Take the oldest sample from the FIFO, waiting up to IMU_TIMEOUT_US.
 */
static int read_one_imu(
    lsm6ds3trc_data_type *imu,
    uint32_t *read_us)
{
  uint32_t start_us;

  imu_sampler_on = true;

  start_us =
      now_us();

  while(1)
  {
    __disable_irq();

    if(imu_fifo_tail != imu_fifo_head)
    {
      *imu = imu_fifo[imu_fifo_tail].imu;
      *read_us = imu_fifo[imu_fifo_tail].read_us;

      imu_fifo_tail =
          (imu_fifo_tail + 1U) %
          IMU_FIFO_SIZE;

      __enable_irq();

      return 0;
    }

    __enable_irq();

    if((uint32_t)(
         now_us() -
         start_us) >=
       IMU_TIMEOUT_US)
    {
      return -1;
    }

    __WFI();
  }
}

/*
 * Busy wait on the SysTick time base (delay_ms() would reprogram SysTick).
 */
static void wait_ms_busy(
    uint32_t ms)
{
  uint32_t start_us =
      now_us();

  while((uint32_t)(
            now_us() -
            start_us) <
        (ms * 1000U))
  {
  }
}

/*
 * No new sample for IMU_TIMEOUT_US: print the sensor state and reset /
 * reconfigure it, so a sensor left misconfigured (e.g. by a floating CS
 * during an MCU reset) recovers without a power cycle.
 */
static void imu_recover(void)
{
  /*
   * Keep the SysTick sampler off the SPI bus. It checks this flag first
   * and cannot preempt itself, so from here on only this code uses SPI.
   */
  imu_sampler_on = false;

  printf(
      "LSM6DS3 WHO=0x%02X STATUS=0x%02X CTRL1_XL=0x%02X CTRL2_G=0x%02X "
      "CTRL3_C=0x%02X CTRL4_C=0x%02X\r\n",
      lsm6ds3trc_read_register(LSM6DS3_WHO_AM_I),
      lsm6ds3trc_read_register(LSM6DS3_STATUS_REG),
      lsm6ds3trc_read_register(LSM6DS3_CTRL1_XL),
      lsm6ds3trc_read_register(LSM6DS3_CTRL2_G),
      lsm6ds3trc_read_register(LSM6DS3_CTRL3_C),
      lsm6ds3trc_read_register(LSM6DS3_CTRL4_C));

  printf(
      "LSM6DS3 reconfigure %s\r\n",
      (lsm6ds3trc_reconfigure(&wait_ms_busy) != 0U) ? "OK" : "FAILED");

  /* read_one_imu() turns the sampler back on */
}

static float gyro_dps(
    const lsm6ds3trc_data_type *imu)
{
  float gx = (float)imu->gx;
  float gy = (float)imu->gy;
  float gz = (float)imu->gz;

  return sqrtf(
             gx * gx +
             gy * gy +
             gz * gz) *
         LSM6DS3_GYRO_DPS_PER_LSB;
}

/*
 * Feed one sample to the detector.
 *
 * A swing starts when |gyro| rises through SWING_THRESHOLD_DPS, its
 * peak is the largest |gyro| until no larger value arrives for
 * SWING_AFTER_PEAK samples.
 *
 * return true when the peak is confirmed and the ring holds
 * [peak - 31, peak + 20] without a gap.
 */
static bool swing_push(
    const lsm6ds3trc_data_type *imu,
    uint32_t read_us)
{
  uint32_t elapsed;
  float dps;

  elapsed =
      read_us - swing.last_us;

  swing.last_us = read_us;

  if(!swing.started ||
     (elapsed > IMU_GAP_US))
  {
    /*
     * Samples were lost (first sample, FIFO overflow, sensor stall):
     * restart the stream like firmware_peaks(). n keeps counting
     * sample periods, so a pending refractory period ends on time.
     */
    if(swing.started)
    {
      swing.n +=
          (elapsed + IMU_INTERVAL_US / 2U) /
          IMU_INTERVAL_US;
    }

    swing.started = true;
    swing.run = 1U;
    swing.rising = false;
    swing.active = false;
  }
  else
  {
    swing.n++;

    if(swing.run < SWING_WINDOW)
    {
      swing.run++;
    }
  }

  imu_ring[imu_head] = *imu;

  imu_head =
      (imu_head + 1U) %
      SWING_WINDOW;

  dps =
      gyro_dps(imu);

  if(swing.active)
  {
    if(dps > swing.peak_dps)
    {
      swing.peak = swing.n;
      swing.peak_us = read_us;
      swing.peak_dps = dps;

      return false;
    }

    if((uint32_t)(
         swing.n -
         swing.peak) <
       SWING_AFTER_PEAK)
    {
      return false;
    }

    swing.active = false;
    swing.rising = false;

    return swing.run >= SWING_WINDOW;
  }

  if(dps < SWING_THRESHOLD_DPS)
  {
    swing.rising = true;
  }
  else if(swing.rising &&
          ((int32_t)(
               swing.n -
               swing.rearm) >= 0))
  {
    swing.active = true;
    swing.peak = swing.n;
    swing.peak_us = read_us;
    swing.peak_dps = dps;
  }

  return false;
}

/*
 * Ring (oldest first) -> features, in the units of the training CSV:
 * Ax Ay Az [g], Gx Gy Gz [dps].
 */
static void swing_to_features(void)
{
  const lsm6ds3trc_data_type *s;

  uint32_t slot = imu_head;
  size_t frame_index = 0U;
  uint32_t k;

  for(k = 0U;
      k < SWING_WINDOW;
      k++)
  {
    s = &imu_ring[slot];

    features[frame_index++] =
        (float)s->ax * LSM6DS3_ACCEL_G_PER_LSB;

    features[frame_index++] =
        (float)s->ay * LSM6DS3_ACCEL_G_PER_LSB;

    features[frame_index++] =
        (float)s->az * LSM6DS3_ACCEL_G_PER_LSB;

    features[frame_index++] =
        (float)s->gx * LSM6DS3_GYRO_DPS_PER_LSB;

    features[frame_index++] =
        (float)s->gy * LSM6DS3_GYRO_DPS_PER_LSB;

    features[frame_index++] =
        (float)s->gz * LSM6DS3_GYRO_DPS_PER_LSB;

    slot =
        (slot + 1U) %
        SWING_WINDOW;
  }
}

/*
 * index.html label table (LABELS), in frame order.
 * Scores are placed by name, so the model's category order
 * does not have to match.
 */
static const char *const ai_frame_labels[AI_FRAME_CLASS_COUNT] =
{
  "BC", "BP", "BS", "FC", "FP", "FS", NONE_LABEL
};

static int ai_frame_label_index(
    const char *label)
{
  uint32_t k;

  for(k = 0U;
      k < AI_FRAME_CLASS_COUNT;
      k++)
  {
    if(strcmp(
           label,
           ai_frame_labels[k]) == 0)
    {
      return (int)k;
    }
  }

  return -1;
}

static uint32_t ai_frame_scale(
    float value,
    float full_scale)
{
  if(!(value > 0.0f))
  {
    return 0U;
  }

  if(value > 1.0f)
  {
    value = 1.0f;
  }

  return (uint32_t)(value * full_scale + 0.5f);
}

static void put_u16(
    uint8_t *p,
    uint32_t value)
{
  p[0] = (uint8_t)value;
  p[1] = (uint8_t)(value >> 8);
}

static void put_u32(
    uint8_t *p,
    uint32_t value)
{
  p[0] = (uint8_t)value;
  p[1] = (uint8_t)(value >> 8);
  p[2] = (uint8_t)(value >> 16);
  p[3] = (uint8_t)(value >> 24);
}

/*
 * Send one V2 AI frame to index.html over BLE.
 *
 * UART4 (PA0 UTXD / PA1 URXD) goes to the on-board BM67C593-1
 * (HT32F67593) module of the ESK32-AE401.
 */
static void ble_send_ai_frame(
    const ei_impulse_result_t *result,
    int best_index,
    uint32_t latency_ms)
{
  static uint32_t seq = 0U;
  static const uint8_t flush_pad[BLE_FLUSH_PAD_SIZE] = {0};

  uint8_t frame[AI_FRAME_SIZE] = {0};
  uint32_t sum = 0U;
  int label_index;
  int k;
  size_t i;

  label_index =
      ai_frame_label_index(
          result->classification[best_index].label);

  if(label_index < 0)
  {
    printf(
        "ERROR: label %s is not in index.html\r\n",
        result->classification[best_index].label);

    return;
  }

  frame[0] = AI_FRAME_SYNC0;
  frame[1] = AI_FRAME_SYNC1;
  frame[2] = AI_FRAME_VERSION;
  frame[3] = AI_FRAME_TYPE_AI;

  put_u32(&frame[4], ++seq);
  put_u32(&frame[8], swing.peak_us);

  frame[12] = (uint8_t)label_index;
  frame[13] =
      (uint8_t)ai_frame_scale(
          result->classification[best_index].value,
          255.0f);

  for(i = 0U;
      i < EI_CLASSIFIER_LABEL_COUNT;
      i++)
  {
    k = ai_frame_label_index(
            result->classification[i].label);

    if(k >= 0)
    {
      put_u16(
          &frame[14 + 2 * k],
          ai_frame_scale(
              result->classification[i].value,
              10000.0f));
    }
  }

  put_u16(
      &frame[28],
      (latency_ms > 0xFFFFU) ? 0xFFFFU : latency_ms);

  for(i = 0U;
      i < 30U;
      i++)
  {
    sum += frame[i];
  }

  put_u16(&frame[30], sum & 0xFFFFU);

  ble_uart4_send(
      frame,
      AI_FRAME_SIZE);

  ble_uart4_send(
      flush_pad,
      BLE_FLUSH_PAD_SIZE);
}

extern "C"
void ei_main_print_model(void)
{
  printf(
      "Model: %s (Edge Impulse %d) deploy v%d, %d labels, %d x %d @ %d Hz\r\n",
      EI_CLASSIFIER_PROJECT_NAME,
      (int)EI_CLASSIFIER_PROJECT_ID,
      (int)EI_CLASSIFIER_PROJECT_DEPLOY_VERSION,
      (int)EI_CLASSIFIER_LABEL_COUNT,
      (int)EI_CLASSIFIER_RAW_SAMPLE_COUNT,
      (int)EI_CLASSIFIER_RAW_SAMPLES_PER_FRAME,
      (int)(EI_CLASSIFIER_FREQUENCY + 0.5));
}

extern "C"
int ei_main(void)
{
  ei_impulse_result_t result = {0};

  signal_t signal;

  EI_IMPULSE_ERROR res;

  lsm6ds3trc_data_type imu;

  uint32_t read_us;

  uint32_t start_us;

  uint32_t latency_ms;

  int best_index = -1;

  float best_value = -1.0f;

  size_t i;

  printf(
      "\r\nWaiting for a swing (> %u dps)...\r\n",
      (unsigned int)SWING_THRESHOLD_DPS);

  /*
   * Stream 104 Hz samples until one swing window is complete
   */
  do
  {
    if(read_one_imu(
           &imu,
           &read_us) != 0)
    {
      printf(
          "ERROR: LSM6DS3 sample timeout\r\n");

      imu_recover();

      return -1;
    }
  } while(!swing_push(
              &imu,
              read_us));

  printf(
      "Swing peak = %u dps\r\n",
      (unsigned int)swing.peak_dps);

  swing_to_features();

  signal.total_length =
      EI_CLASSIFIER_DSP_INPUT_FRAME_SIZE;

  signal.get_data =
      &raw_feature_get_data;

  /*
   * Edge Impulse inference
   */
  start_us =
      now_us();

  res =
      run_classifier(
          &signal,
          &result,
          false);

  latency_ms =
      ((uint32_t)(now_us() - start_us) + 500U) /
      1000U;

  if(res != EI_IMPULSE_OK)
  {
    printf(
        "run_classifier ERROR: %d\r\n",
        (int)res);

    return -2;
  }

  /*
   * Best class
   */
  for(i = 0U;
      i < EI_CLASSIFIER_LABEL_COUNT;
      i++)
  {
    if(result.classification[i].value >
       best_value)
    {
      best_value =
          result.classification[i].value;

      best_index =
          (int)i;
    }
  }

  if(best_index < 0)
  {
    return -2;
  }

  /*
   * BLE first, the debug UART text below takes ~25 ms.
   *
   * Only strokes go to index.html (it ignores NONE anyway).
   * A stroke also starts the refractory period, NONE does not
   * (the NONE clips were extracted under the same rule).
   */
  if(strcmp(
         result.classification[
             best_index].label,
         NONE_LABEL) != 0)
  {
    ble_send_ai_frame(
        &result,
        best_index,
        latency_ms);

    swing.rearm =
        swing.peak +
        SWING_REFRACTORY;
  }

  printf(
      "Predictions:\r\n");

  /*
   * Score of every label (debug UART only)
   */
  for(i = 0U;
      i < EI_CLASSIFIER_LABEL_COUNT;
      i++)
  {
    printf(
        "  %s = ",
        result.classification[i].label);

    ei_printf_float(
        result.classification[i].value);

    printf(
        "\r\n");
  }

#if EI_CLASSIFIER_HAS_ANOMALY == 1

  printf(
      "  anomaly = ");

  ei_printf_float(
      result.anomaly);

  printf(
      "\r\n");

#endif

  printf(
      "Result: %s  confidence=",
      result.classification[
          best_index].label);

  ei_printf_float(
      best_value);

  printf(
      "\r\n");

  printf(
      "Timing: DSP=%d ms, NN=%d ms, total=%u ms\r\n",
      result.timing.dsp,
      result.timing.classification,
      (unsigned int)latency_ms);

  return best_index;
}

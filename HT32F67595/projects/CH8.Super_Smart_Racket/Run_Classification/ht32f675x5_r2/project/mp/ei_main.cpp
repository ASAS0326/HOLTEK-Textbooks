#include "ei_main.h"
#include "edge-impulse-sdk/classifier/ei_run_classifier.h"
#include "edge-impulse-sdk/porting/ei_classifier_porting.h"
#include <ARMCM33_DSP_FP.h>
#include <math.h>
#include <stdint.h>
#include <stddef.h>
#include <string.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include "LSM6DS3.h"
#include "shared_memory.h"

extern "C" {
#include "RegHT32F675x5.h"
#include "err_def.h"
#include "type_def.h"
#include "hw_uart.h"
#include "app_cfg.h"
#include "boards.h"
    void rom_delay_ms(uint32_t ms);
    uint64_t SysTick_GetMicroseconds(void);
}

#ifndef EI_UART_HANDLE
#define EI_UART_HANDLE UART_HANDLE_MP_APP_DEBUG
#endif

#define AXIS_COUNT 6U
#define WINDOW_SAMPLES EI_CLASSIFIER_RAW_SAMPLE_COUNT
#define SAMPLES_AFTER_PEAK (WINDOW_SAMPLES - SWING_PEAK_INDEX - 1U)

static_assert(EI_CLASSIFIER_PROJECT_ID == 1111023 && EI_CLASSIFIER_PROJECT_DEPLOY_VERSION == 11,
              "Select the pinpon 11.0.0 model pack in the MP project.");
static_assert(EI_CLASSIFIER_RAW_SAMPLES_PER_FRAME == AXIS_COUNT, "Model must have six axes.");
static_assert(EI_CLASSIFIER_RAW_SAMPLE_COUNT == 52 &&
              EI_CLASSIFIER_DSP_INPUT_FRAME_SIZE == 52 * AXIS_COUNT,
              "Model window changed: set SWING_PEAK_INDEX to the collector's "
              "peak_index_in_window, then update this check.");
static_assert(EI_CLASSIFIER_INTERVAL_MS > 9.5 && EI_CLASSIFIER_INTERVAL_MS < 9.75,
              "Model must be trained on the 104 Hz sensor grid; samples are not resampled.");
static_assert(SWING_PEAK_INDEX >= 1U && SWING_PEAK_INDEX + 2U <= WINDOW_SAMPLES,
              "The peak must leave samples on both sides of the window.");
static_assert(EI_CLASSIFIER_LABEL_COUNT == 7 && AI_NONE_CLASS_INDEX == 6U,
              "Model must contain BC, BP, BS, FC, FP, FS, NONE.");
static_assert(EI_CLASSIFIER_HAS_DATA_NORMALIZATION == 1 &&
              EI_CLASSIFIER_TFLITE_INPUT_DATATYPE == EI_CLASSIFIER_DATATYPE_INT8,
              "Use the int8 model with its embedded normalization.");
static_assert(sizeof(shared_ai_result_t) == 24, "Keep the MP/CP payload ABI.");
static_assert(sizeof(shared_ai_details_t) == 36 &&
              SHARED_AI_CLASS_COUNT == EI_CLASSIFIER_LABEL_COUNT,
              "MP/CP must agree on the full seven-class details.");

/* Chronological model window handed to run_classifier. */
static float features[EI_CLASSIFIER_DSP_INPUT_FRAME_SIZE] = {0};

__attribute__((weak)) EI_IMPULSE_ERROR ei_run_impulse_check_canceled()
{
    return EI_IMPULSE_OK;
}
__attribute__((weak)) EI_IMPULSE_ERROR ei_sleep(int32_t time_ms)
{
    if (time_ms > 0) rom_delay_ms((uint32_t)time_ms);
    return EI_IMPULSE_OK;
}
uint64_t ei_read_timer_us() { return SysTick_GetMicroseconds(); }
uint64_t ei_read_timer_ms() { return ei_read_timer_us() / 1000U; }
void ei_putc(char c) { rom_hw_uart_send_byte(EI_UART_HANDLE, (uint8_t)c); }

__attribute__((weak)) void ei_printf(const char *format, ...)
{
    char buffer[384] = {};
    va_list args;
    va_start(args, format);
    int length = vsnprintf(buffer, sizeof(buffer), format, args);
    va_end(args);
    if (length <= 0) return;
    /* Send only initialized, terminated text. The integer-only target printf
     * cannot format %f reliably; never trust its returned count as UART length.
     */
    buffer[sizeof(buffer) - 1U] = '\0';
    for (size_t i = 0; i < sizeof(buffer) - 1U && buffer[i] != '\0'; ++i)
        ei_putc(buffer[i]);
}

static void print_fixed_float(float value, bool six_decimals)
{
    const uint32_t scale = six_decimals ? 1000000U : 1000U;
    const float scaled = value * (float)scale;
    if (!(scaled > -2147483000.0f && scaled < 2147483000.0f)) {
        ei_printf("invalid");
        return;
    }
    const int32_t rounded = (int32_t)(scaled + (scaled < 0.0f ? -0.5f : 0.5f));
    const uint32_t magnitude = rounded < 0 ? (uint32_t)(-rounded) : (uint32_t)rounded;
    if (six_decimals)
        ei_printf("%s%lu.%06lu", rounded < 0 ? "-" : "",
                  (unsigned long)(magnitude / scale), (unsigned long)(magnitude % scale));
    else
        ei_printf("%s%lu.%03lu", rounded < 0 ? "-" : "",
                  (unsigned long)(magnitude / scale), (unsigned long)(magnitude % scale));
}
__attribute__((weak)) void ei_printf_float(float value) { print_fixed_float(value, false); }
__attribute__((weak)) void *ei_malloc(size_t size) { return malloc(size); }
__attribute__((weak)) void *ei_calloc(size_t count, size_t size) { return calloc(count, size); }
__attribute__((weak)) void ei_free(void *ptr) { free(ptr); }
#if defined(__cplusplus) && EI_C_LINKAGE == 1
extern "C"
#endif
__attribute__((weak)) void DebugLog(const char *text) { ei_printf("%s", text); }

int raw_feature_get_data(size_t offset, size_t length, float *out_ptr)
{
    if (out_ptr == NULL || offset > EI_CLASSIFIER_DSP_INPUT_FRAME_SIZE ||
        length > EI_CLASSIFIER_DSP_INPUT_FRAME_SIZE - offset) return -1;
    memcpy(out_ptr, features + offset, length * sizeof(float));
    return 0;
}

/* Newest WINDOW_SAMPLES sensor samples (g, g, g, dps, dps, dps); stream index
 * i lives in ring[i % WINDOW_SAMPLES]. Samples feed the model 1:1, exactly as
 * the collector wrote them on the 104 Hz grid.
 */
static float ring[WINDOW_SAMPLES][AXIS_COUNT];
static uint32_t stream_samples;     /* samples since the FIFO stream (re)started */
static uint32_t classified_swings;  /* since boot, for the UART log */

struct swing_detector_t {
    bool rising;        /* |gyro| was below the threshold since the last swing */
    bool active;        /* a peak is being confirmed */
    uint32_t peak;      /* stream index of the peak */
    float peak_dps;
    uint32_t rearm;     /* no swing may start before this stream index */
};
static swing_detector_t detector;

/* Mirror of SwingDetector in collect_training_data.py. Returns true when the
 * newest sample completes the window around a confirmed peak.
 */
static bool detector_push(uint32_t index, float dps)
{
    swing_detector_t &d = detector;
    if (d.active) {
        if (dps > d.peak_dps) {
            d.peak = index;
            d.peak_dps = dps;
            return false;
        }
        if (index - d.peak < SAMPLES_AFTER_PEAK) return false;
        d.active = false;
        d.rising = false;
        return true;    /* classify_swing sets the refractory period if published */
    }
    if (dps < SWING_THRESHOLD_DPS) {
        d.rising = true;
    } else if (d.rising && (int32_t)(index - d.rearm) >= 0) {
        d.active = true;
        d.peak = index;
        d.peak_dps = dps;
    }
    return false;
}

static uint32_t swing_state(uint32_t index)
{
    if (stream_samples < WINDOW_SAMPLES) return AI_STATE_COLLECTING;
    if (detector.active) return AI_STATE_SWING_ACTIVE;
    if ((int32_t)(index - detector.rearm) < 0) return AI_STATE_SWING_LOCKED;
    return AI_STATE_WAITING_SWING;
}

static int read_sample(float physical[AXIS_COUNT])
{
    const uint64_t started = ei_read_timer_ms();
    for (;;) {
        int16_t raw[AXIS_COUNT];
        int ret = lsm6ds3_fifo_read_6axis_raw(raw);
        SHARED_AI_FIFO = lsm6ds3_fifo_diagnostics();
        if (ret < 0) return ret;
        if (ret == 1) {
            lsm6ds3_raw_to_physical(raw, physical);
            ++SHARED_AI_SAMPLES;
            return 0;
        }
        if (ei_read_timer_ms() - started >= 500U) return -4;
        rom_delay_ms(1);
    }
}

/* CP only consumes an unchanged, even, nonzero sequence, so it never reads a
 * torn result. The details carry this swing's seven probabilities.
 */
static void write_swing_result(const float scores[EI_CLASSIFIER_LABEL_COUNT],
                               size_t best, size_t second,
                               uint32_t tick_us, uint16_t latency_ms)
{
    shared_ai_result_t next = {};
    strncpy(next.label0, ei_classifier_inferencing_categories[best], sizeof(next.label0) - 1);
    strncpy(next.label1, ei_classifier_inferencing_categories[second], sizeof(next.label1) - 1);
    next.value0 = scores[best];
    next.value1 = scores[second];
    shared_ai_details_t details = {};
    for (size_t i = 0; i < SHARED_AI_CLASS_COUNT; ++i)
        details.scores[i] = scores[i];
    details.tick_us = tick_us;
    details.latency_ms = latency_ms;

    uint32_t sequence = SHARED_AI_SEQUENCE;
    if (sequence & 1U) ++sequence;
    SHARED_AI_SEQUENCE = sequence + 1U;
    __DMB();
    volatile uint8_t *dst = (volatile uint8_t *)SHARED_AI_RESULT_ADDR;
    const uint8_t *src = (const uint8_t *)&next;
    for (size_t i = 0; i < sizeof(next); ++i) dst[i] = src[i];
    dst = (volatile uint8_t *)SHARED_AI_DETAILS_ADDR;
    src = (const uint8_t *)&details;
    for (size_t i = 0; i < sizeof(details); ++i) dst[i] = src[i];
    __DMB();
    uint32_t complete = sequence + 2U;
    SHARED_AI_SEQUENCE = (complete == 0U) ? 2U : complete;
    __DMB();
}

static unsigned int basis_points(float score)
{
    return (unsigned int)(score * 10000.0f + 0.5f);
}

/* Classify the window ending at stream index `newest` (peak at
 * SWING_PEAK_INDEX). Returns 1 if published, 0 if not, negative on error.
 */
static int classify_swing(uint32_t newest)
{
    const uint32_t peak = detector.peak;
    const unsigned int peak_dps = (unsigned int)(detector.peak_dps + 0.5f);
    if (newest + 1U < WINDOW_SAMPLES) {
        ei_printf("SWING skipped: only %lu samples since the stream started\r\n",
                  (unsigned long)(newest + 1U));
        return 0;
    }
    for (uint32_t i = 0; i < WINDOW_SAMPLES; ++i) {
        const uint32_t index = newest - (WINDOW_SAMPLES - 1U) + i;
        memcpy(&features[i * AXIS_COUNT], ring[index % WINDOW_SAMPLES], sizeof(ring[0]));
    }

    SHARED_AI_STATE = AI_STATE_CLASSIFYING;
    __DMB();
    signal_t signal;
    signal.total_length = EI_CLASSIFIER_DSP_INPUT_FRAME_SIZE;
    signal.get_data = &raw_feature_get_data;
    ei_impulse_result_t result = {};
    const uint64_t started = ei_read_timer_ms();
    const EI_IMPULSE_ERROR error = run_classifier(&signal, &result, false);
    const uint64_t elapsed = ei_read_timer_ms() - started;
    const uint16_t latency_ms = (uint16_t)(elapsed > 65535U ? 65535U : elapsed);
    if (error != EI_IMPULSE_OK) {
        ei_printf("run_classifier failed: %d\r\n", error);
        SHARED_AI_ERROR = (int32_t)error;
        return -5;
    }
    ++SHARED_AI_WINDOWS;
    ++classified_swings;

    float scores[EI_CLASSIFIER_LABEL_COUNT];
    for (size_t i = 0; i < EI_CLASSIFIER_LABEL_COUNT; ++i) {
        scores[i] = result.classification[i].value;
        if (!(scores[i] >= 0.0f && scores[i] <= 1.0f)) {  // NaN fails too
            ei_printf("SWING skipped: invalid model score\r\n");
            return 0;
        }
    }
    size_t best = scores[1] > scores[0] ? 1U : 0U;
    size_t second = 1U - best;
    for (size_t i = 2; i < EI_CLASSIFIER_LABEL_COUNT; ++i) {
        if (scores[i] > scores[best]) {
            second = best;
            best = i;
        } else if (scores[i] > scores[second]) {
            second = i;
        }
    }
    const bool publish = best != AI_NONE_CLASS_INDEX && scores[best] >= SWING_MIN_CONFIDENCE;
    if (publish) {
        const uint32_t tick_us = (uint32_t)((uint64_t)peak * 1000000ULL / LSM6DS3_ODR_HZ);
        write_swing_result(scores, best, second, tick_us, latency_ms);
        /* Only a reported stroke blocks the next one. After NONE (e.g. a
         * backswing) the real stroke that follows must still be caught.
         */
        detector.rearm = peak + SWING_REFRACTORY_SAMPLES;
    }
#if EI_SWING_LOG
    ei_printf("SWING #%lu peak=%u dps -> %s %u bp (%s) |",
              (unsigned long)classified_swings, peak_dps,
              ei_classifier_inferencing_categories[best], basis_points(scores[best]),
              publish ? "sent" : best == AI_NONE_CLASS_INDEX ? "NONE" : "low confidence");
    for (size_t i = 0; i < EI_CLASSIFIER_LABEL_COUNT; ++i)
        ei_printf(" %s=%u", ei_classifier_inferencing_categories[i], basis_points(scores[i]));
    ei_printf(" | infer=%u ms\r\n", (unsigned int)latency_ms);
#endif
    return publish ? 1 : 0;
}

static bool model_contract_valid(void)
{
    static const char *const expected[] = {"BC", "BP", "BS", "FC", "FP", "FS", "NONE"};
    if (strcmp(EI_CLASSIFIER_FUSION_AXES_STRING, "Ax + Ay + Az + Gx + Gy + Gz") != 0)
        return false;
    for (size_t i = 0; i < EI_CLASSIFIER_LABEL_COUNT; ++i)
        if (strcmp(ei_classifier_inferencing_categories[i], expected[i]) != 0) return false;
    return true;
}

int ei_main(void)
{
    static bool startup_printed = false;
    static uint32_t restarts = 0;
    static uint64_t last_error_ms = 0;
    SHARED_AI_SEQUENCE = 0;
    SHARED_AI_STATE = AI_STATE_SENSOR_INIT;
    __DMB();
    if (!lsm6ds3_is_ready()) {
        lsm6ds3_init();
        if (!lsm6ds3_is_ready()) {
            SHARED_AI_ERROR = LSM6DS3_ERR_NOT_READY;
            SHARED_AI_STATE = AI_STATE_ERROR;
            rom_delay_ms(500); return 1;
        }
    }
    if (!model_contract_valid()) {
        SHARED_AI_ERROR = -6;
        SHARED_AI_STATE = AI_STATE_ERROR;
        ei_printf("ERROR: incompatible model input metadata\r\n");
        rom_delay_ms(500);
        return 1;
    }
    int ret = lsm6ds3_fifo_start();
    if (ret != 0) {
        SHARED_AI_ERROR = ret;
        SHARED_AI_STATE = AI_STATE_ERROR;
        ei_printf("LSM6DS3 FIFO init failed: %d\r\n", ret);
        lsm6ds3_init();
        rom_delay_ms(100);
        return 1;
    }

    if (!startup_printed) {
        ei_printf("pinpon v%d peak trigger: %u samples @104 Hz, peak at %u, "
                  "threshold %u dps, refractory %u samples, publish >= %u bp\r\n",
                  EI_CLASSIFIER_PROJECT_DEPLOY_VERSION, (unsigned int)WINDOW_SAMPLES,
                  (unsigned int)SWING_PEAK_INDEX, (unsigned int)SWING_THRESHOLD_DPS,
                  (unsigned int)SWING_REFRACTORY_SAMPLES, basis_points(SWING_MIN_CONFIDENCE));
        startup_printed = true;
    }

    /* A restarted stream starts a fresh window; never bridge a FIFO/read gap. */
    stream_samples = 0;
    memset(&detector, 0, sizeof(detector));
    SHARED_AI_ERROR = 0;
    SHARED_AI_STATE = AI_STATE_COLLECTING;
    for (;;) {
        float physical[AXIS_COUNT];
        ret = read_sample(physical);
        if (ret != 0) break;
        const uint32_t index = stream_samples++;
        memcpy(ring[index % WINDOW_SAMPLES], physical, sizeof(ring[0]));
        const float dps = sqrtf(physical[3] * physical[3] + physical[4] * physical[4] +
                                physical[5] * physical[5]);
        if (detector_push(index, dps)) {
            ret = classify_swing(index);
            if (ret < 0) break;
            if (ret > 0) {
                SHARED_AI_STATE = AI_STATE_RESULT_READY;
                continue;
            }
        }
        SHARED_AI_STATE = swing_state(index);
    }

    SHARED_AI_SEQUENCE = 0;
    __DMB();
    if (ret != -5) SHARED_AI_ERROR = ret;
    SHARED_AI_STATE = AI_STATE_ERROR;
    ++restarts;
    const uint64_t now = ei_read_timer_ms();
    if (restarts == 1U || now - last_error_ms >= 1000U) {
        const uint32_t fifo = SHARED_AI_FIFO;
        ei_printf("IMU error=%d FIFO words=%lu pattern=%lu flags=0x%02lX; restart=%lu samples=%lu\r\n",
                  ret, (unsigned long)(fifo & 0x7FFU),
                  (unsigned long)((fifo >> 12) & 0x3FFU),
                  (unsigned long)(fifo >> 24), (unsigned long)restarts,
                  (unsigned long)SHARED_AI_SAMPLES);
        last_error_ms = now;
    }
    if (ret == LSM6DS3_ERR_IO || ret == LSM6DS3_ERR_NOT_READY) lsm6ds3_init();
    rom_delay_ms(100);
    return 1;
}

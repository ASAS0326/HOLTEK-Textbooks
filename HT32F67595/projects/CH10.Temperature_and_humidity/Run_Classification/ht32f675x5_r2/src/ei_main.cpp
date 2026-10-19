#include "ei_main.h"

#include "edge-impulse-sdk/porting/ei_classifier_porting.h"
#include "ei_run_classifier.h"

#include <stddef.h>
#include <string.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdint.h>

#include <ARMCM33_DSP_FP.h>
#include <RegHT32F675x5.h>
#include <core_cm33.h>

extern "C" {
    #include "type_def.h"
    #include "err_def.h"
    #include "hw_uart.h"
    #include "app_cfg.h"
    #include "boards.h"
    #include "i2c.h"
    #include "hs300x.h"
}

#ifndef EI_UART_HANDLE
#define EI_UART_HANDLE UART_HANDLE_APP_DEBUG
#endif

/*
 * Edge Impulse model input.
 *
 * IMPORTANT:
 * The feature order below must be exactly the same as the CSV used
 * to train the Edge Impulse model.
 *
 * features[0]  = t_m30
 * features[1]  = rh_m30
 * features[2]  = t_m25
 * features[3]  = rh_m25
 * features[4]  = t_m20
 * features[5]  = rh_m20
 * features[6]  = t_m15
 * features[7]  = rh_m15
 * features[8]  = t_m10
 * features[9]  = rh_m10
 * features[10] = t_m5
 * features[11] = rh_m5
 * features[12] = t_now
 * features[13] = rh_now
 * features[14] = dt_5
 * features[15] = dt_15
 * features[16] = dt_30
 * features[17] = drh_5
 * features[18] = drh_15
 * features[19] = drh_30
 * features[20] = rh_accel_10s
 * features[21] = target_type
 *
 * target_type = 0:
 *   label = (T(t+30) - T(now)) * 20
 *
 * target_type = 1:
 *   label = RH(t+30) - RH(now)
 */
static float features[EI_CLASSIFIER_DSP_INPUT_FRAME_SIZE] = {0.0f};

#if EI_CLASSIFIER_DSP_INPUT_FRAME_SIZE != 22
#error "This program expects an Edge Impulse model with exactly 22 input features."
#endif

#define SAMPLE_INTERVAL_MS    (5UL * 1000UL)
#define HISTORY_SIZE          (7U)
#define FORECAST_STEPS        (6U)
#define TEMP_LABEL_SCALE      (20.0f)

typedef struct
{
    float temperature;
    float humidity;
} sensor_sample_t;

typedef struct
{
    uint32_t source_sample_id;

    float source_temperature;
    float source_humidity;

    float predicted_temperature_30s;
    float predicted_humidity_30s;

    uint8_t valid;
} prediction_record_t;

static sensor_sample_t history_buffer[HISTORY_SIZE];
static uint32_t history_write_index = 0U;
static uint32_t history_count = 0U;

static prediction_record_t prediction_queue[FORECAST_STEPS];
static uint32_t queue_write_index = 0U;
static uint32_t queue_count = 0U;

static uint32_t validation_count = 0U;

static float temperature_abs_error_sum = 0.0f;
static float humidity_abs_error_sum = 0.0f;

static float temperature_max_abs_error = 0.0f;
static float humidity_max_abs_error = 0.0f;


/* ========================================================================== */
/* Edge Impulse platform functions                                            */
/* ========================================================================== */

__attribute__((weak)) EI_IMPULSE_ERROR ei_run_impulse_check_canceled()
{
    return EI_IMPULSE_OK;
}

__attribute__((weak)) EI_IMPULSE_ERROR ei_sleep(int32_t time_ms)
{
    uint32_t start_ms = I2C_HAL_GetTickMs();

    while ((uint32_t)(I2C_HAL_GetTickMs() - start_ms) < (uint32_t)time_ms)
    {
        I2C_HAL_Process();
        HS300X_Process();
        __WFI();
    }

    return EI_IMPULSE_OK;
}

uint64_t ei_read_timer_ms()
{
    return (uint64_t)I2C_HAL_GetTickMs();
}

uint64_t ei_read_timer_us()
{
    return ((uint64_t)I2C_HAL_GetTickMs()) * 1000ULL;
}

void ei_putc(char c)
{
    rom_hw_uart_send_byte(EI_UART_HANDLE, (uint8_t)c);
}

__attribute__((weak)) void ei_printf(const char *format, ...)
{
    char buffer[256] = {0};

    va_list args;
    va_start(args, format);

    int length = vsnprintf(buffer, sizeof(buffer), format, args);

    va_end(args);

    if (length <= 0)
    {
        return;
    }

    if (length >= (int)sizeof(buffer))
    {
        length = (int)sizeof(buffer) - 1;
    }

    for (int i = 0; i < length; i++)
    {
        ei_putc(buffer[i]);
    }
}

static void ei_print_fixed(float value, uint8_t decimals)
{
    uint32_t factor = 1U;

    for (uint8_t i = 0U; i < decimals; i++)
    {
        factor *= 10U;
    }

    int32_t scaled;

    if (value >= 0.0f)
    {
        scaled = (int32_t)(value * (float)factor + 0.5f);
    }
    else
    {
        scaled = (int32_t)(value * (float)factor - 0.5f);
    }

    if (scaled < 0)
    {
        ei_printf("-");
        scaled = -scaled;
    }

    uint32_t whole = (uint32_t)scaled / factor;
    uint32_t frac = (uint32_t)scaled % factor;

    ei_printf("%lu", (unsigned long)whole);

    if (decimals > 0U)
    {
        ei_printf(".");

        char fmt[8];
        snprintf(fmt, sizeof(fmt), "%%0%ulu", (unsigned long)decimals);

        ei_printf(fmt, (unsigned long)frac);
    }
}

__attribute__((weak)) void ei_printf_float(float f)
{
    ei_print_fixed(f, 5U);
}

__attribute__((weak)) void *ei_malloc(size_t size)
{
    return malloc(size);
}

__attribute__((weak)) void *ei_calloc(size_t nitems, size_t size)
{
    return calloc(nitems, size);
}

__attribute__((weak)) void ei_free(void *ptr)
{
    free(ptr);
}

#if defined(__cplusplus) && EI_C_LINKAGE == 1
extern "C"
#endif
__attribute__((weak)) void DebugLog(const char *s)
{
    ei_printf("%s", s);
}


/* ========================================================================== */
/* History buffer                                                             */
/* ========================================================================== */

static void history_push(float temperature, float humidity)
{
    history_buffer[history_write_index].temperature = temperature;
    history_buffer[history_write_index].humidity = humidity;

    history_write_index =
        (history_write_index + 1U) % HISTORY_SIZE;

    if (history_count < HISTORY_SIZE)
    {
        history_count++;
    }
}

static bool history_ready(void)
{
    return (history_count >= HISTORY_SIZE);
}

static void history_build_features(float target_type)
{
    uint32_t oldest_index = history_write_index;

    float t[HISTORY_SIZE];
    float rh[HISTORY_SIZE];

    for (uint32_t i = 0U; i < HISTORY_SIZE; i++)
    {
        uint32_t index = (oldest_index + i) % HISTORY_SIZE;

        t[i] = history_buffer[index].temperature;
        rh[i] = history_buffer[index].humidity;

        features[i * 2U] = t[i];
        features[i * 2U + 1U] = rh[i];
    }

    /*
     * History index:
     *
     * 0 = -30 sec
     * 1 = -25 sec
     * 2 = -20 sec
     * 3 = -15 sec
     * 4 = -10 sec
     * 5 =  -5 sec
     * 6 = now
     */
    features[14] = t[6] - t[5];
    features[15] = t[6] - t[3];
    features[16] = t[6] - t[0];

    features[17] = rh[6] - rh[5];
    features[18] = rh[6] - rh[3];
    features[19] = rh[6] - rh[0];

    /*
     * RH acceleration:
     *
     * recent 10 sec   = RH(now) - RH(-10)
     * previous 10 sec = RH(-10) - RH(-20)
     *
     * acceleration = recent - previous
     */
    float recent_10s_change = rh[6] - rh[4];
    float previous_10s_change = rh[4] - rh[2];

    features[20] = recent_10s_change - previous_10s_change;
    features[21] = target_type;
}

static void print_history(void)
{
    static const int32_t seconds[HISTORY_SIZE] =
    {
        -30, -25, -20, -15, -10, -5, 0
    };

    uint32_t oldest_index = history_write_index;

    ei_printf("HISTORY       ");

    for (uint32_t i = 0U; i < HISTORY_SIZE; i++)
    {
        uint32_t index =
            (oldest_index + i) % HISTORY_SIZE;

        ei_printf("[%ld:", (long)seconds[i]);

        ei_print_fixed(
            history_buffer[index].temperature,
            2U
        );

        ei_printf(",");

        ei_print_fixed(
            history_buffer[index].humidity,
            2U
        );

        ei_printf("] ");
    }

    ei_printf("\r\n");
}


static void print_trend_features(void)
{
    history_build_features(0.0f);

    ei_printf("TREND         dT5=");
    ei_print_fixed(features[14], 2U);

    ei_printf(" dT15=");
    ei_print_fixed(features[15], 2U);

    ei_printf(" dT30=");
    ei_print_fixed(features[16], 2U);

    ei_printf(" | dRH5=");
    ei_print_fixed(features[17], 2U);

    ei_printf(" dRH15=");
    ei_print_fixed(features[18], 2U);

    ei_printf(" dRH30=");
    ei_print_fixed(features[19], 2U);

    ei_printf(" | RH_ACC=");
    ei_print_fixed(features[20], 2U);

    ei_printf("\r\n");
}


/* ========================================================================== */
/* Edge Impulse inference                                                     */
/* ========================================================================== */

static int raw_feature_get_data(size_t offset, size_t length, float *out_ptr)
{
    memcpy(out_ptr, features + offset, length * sizeof(float));
    return 0;
}

static EI_IMPULSE_ERROR run_regression_once(
    float target_type,
    float *predicted_delta)
{
    history_build_features(target_type);

    signal_t signal;
    signal.total_length = EI_CLASSIFIER_DSP_INPUT_FRAME_SIZE;
    signal.get_data = &raw_feature_get_data;

    ei_impulse_result_t result = {};

    EI_IMPULSE_ERROR err =
        run_classifier(&signal, &result, false);

    if (err != EI_IMPULSE_OK)
    {
        return err;
    }

    *predicted_delta =
        result.classification[0].value;

    return EI_IMPULSE_OK;
}

static int predict_30sec(
    float current_temperature,
    float current_humidity,
    float *future_temperature,
    float *future_humidity)
{
    EI_IMPULSE_ERROR err;

    float temperature_model_output = 0.0f;
    float temperature_delta = 0.0f;
    float humidity_delta = 0.0f;

    /*
     * Temperature:
     * Training label was multiplied by 20.
     * Convert the model output back to real Celsius delta.
     */
    err = run_regression_once(0.0f, &temperature_model_output);

    if (err != EI_IMPULSE_OK)
    {
        ei_printf("ERR,temperature_inference,%d\r\n", (int)err);
        return -1;
    }

    temperature_delta =
        temperature_model_output / TEMP_LABEL_SCALE;

    /*
     * Humidity:
     * Training label is the real RH delta.
     */
    err = run_regression_once(1.0f, &humidity_delta);

    if (err != EI_IMPULSE_OK)
    {
        ei_printf("ERR,humidity_inference,%d\r\n", (int)err);
        return -2;
    }

    *future_temperature =
        current_temperature + temperature_delta;

    *future_humidity =
        current_humidity + humidity_delta;

    ei_printf("PRED DELTA    dT=");
    ei_print_fixed(temperature_delta, 2U);

    ei_printf(" C | dRH=");
    ei_print_fixed(humidity_delta, 2U);

    ei_printf(" %%RH\r\n");

    return 0;
}


/* ========================================================================== */
/* Validation                                                                 */
/* ========================================================================== */

static void validate_old_prediction(
    const prediction_record_t *old_prediction,
    uint32_t current_sample_id,
    float actual_temperature,
    float actual_humidity)
{
    if (old_prediction->valid == 0U)
    {
        return;
    }

    float temp_abs_error =
        fabsf(
            actual_temperature -
            old_prediction->predicted_temperature_30s
        );

    float hum_abs_error =
        fabsf(
            actual_humidity -
            old_prediction->predicted_humidity_30s
        );

    temperature_abs_error_sum +=
        temp_abs_error;

    humidity_abs_error_sum +=
        hum_abs_error;

    validation_count++;

    if (temp_abs_error > temperature_max_abs_error)
    {
        temperature_max_abs_error =
            temp_abs_error;
    }

    if (hum_abs_error > humidity_max_abs_error)
    {
        humidity_max_abs_error =
            hum_abs_error;
    }

    float temp_mae =
        temperature_abs_error_sum /
        (float)validation_count;

    float hum_mae =
        humidity_abs_error_sum /
        (float)validation_count;

    ei_printf("\r\n");

    ei_printf(
        "[VALIDATE #%lu -> #%lu]\r\n",
        (unsigned long)old_prediction->source_sample_id,
        (unsigned long)current_sample_id
    );

    ei_printf("Temperature : PRED=");
    ei_print_fixed(
        old_prediction->predicted_temperature_30s,
        2U
    );

    ei_printf(" C, ACTUAL=");
    ei_print_fixed(
        actual_temperature,
        2U
    );

    ei_printf(" C, ERR=");
    ei_print_fixed(
        temp_abs_error,
        2U
    );

    ei_printf(" C\r\n");

    ei_printf("Humidity    : PRED=");
    ei_print_fixed(
        old_prediction->predicted_humidity_30s,
        2U
    );

    ei_printf(" %%RH, ACTUAL=");
    ei_print_fixed(
        actual_humidity,
        2U
    );

    ei_printf(" %%RH, ERR=");
    ei_print_fixed(
        hum_abs_error,
        2U
    );

    ei_printf(" %%RH\r\n");

    /*
     * MAE / MAX ERROR UART output is intentionally disabled.
     * The running error values are still updated above.
     */
}

static void push_prediction(
    uint32_t sample_id,
    float current_temperature,
    float current_humidity,
    float predicted_temperature,
    float predicted_humidity)
{
    prediction_record_t *slot =
        &prediction_queue[queue_write_index];

    slot->source_sample_id =
        sample_id;

    slot->source_temperature =
        current_temperature;

    slot->source_humidity =
        current_humidity;

    slot->predicted_temperature_30s =
        predicted_temperature;

    slot->predicted_humidity_30s =
        predicted_humidity;

    slot->valid = 1U;

    queue_write_index =
        (queue_write_index + 1U) %
        FORECAST_STEPS;

    if (queue_count < FORECAST_STEPS)
    {
        queue_count++;
    }
}


/* ========================================================================== */
/* Application                                                                */
/* ========================================================================== */

static void process_new_sensor_sample(uint32_t sample_id)
{
    float current_temperature =
        g_hs300x_temperature;

    float current_humidity =
        g_hs300x_humidity;

    float predicted_temperature = 0.0f;
    float predicted_humidity = 0.0f;

    history_push(
        current_temperature,
        current_humidity
    );

    ei_printf("\r\n");
    ei_printf("========================================\r\n");

    ei_printf(
        "[Sample #%lu]\r\n",
        (unsigned long)sample_id
    );

    ei_printf("NOW           T=");
    ei_print_fixed(
        current_temperature,
        2U
    );

    ei_printf(" C | RH=");
    ei_print_fixed(
        current_humidity,
        2U
    );

    ei_printf(" %%RH\r\n");

    /*
     * The first six samples do not yet contain a complete
     * 30-second history. Start inference from sample #6.
     */
    if (!history_ready())
    {
        ei_printf(
            "HISTORY       %lu/%u samples, waiting...\r\n",
            (unsigned long)history_count,
            (unsigned int)HISTORY_SIZE
        );

        ei_printf("========================================\r\n");
        return;
    }

    print_history();
    print_trend_features();

    /*
     * Prediction queue depth is six samples.
     * At 5 seconds/sample this validates exactly 30 seconds later.
     */
    if (queue_count >= FORECAST_STEPS)
    {
        validate_old_prediction(
            &prediction_queue[queue_write_index],
            sample_id,
            current_temperature,
            current_humidity
        );
    }

    if (predict_30sec(
            current_temperature,
            current_humidity,
            &predicted_temperature,
            &predicted_humidity) == 0)
    {
        ei_printf("PRED +30 sec  T=");

        ei_print_fixed(
            predicted_temperature,
            2U
        );

        ei_printf(" C | RH=");

        ei_print_fixed(
            predicted_humidity,
            2U
        );

        ei_printf(" %%RH\r\n");

        push_prediction(
            sample_id,
            current_temperature,
            current_humidity,
            predicted_temperature,
            predicted_humidity
        );
    }

    ei_printf("========================================\r\n");
}

int ei_main(void)
{
    uint32_t sample_id = 0U;
    uint32_t last_sample_start_ms = 0U;

    HS300X_STATUS_T sensor_status;

    memset(
        history_buffer,
        0,
        sizeof(history_buffer)
    );

    memset(
        prediction_queue,
        0,
        sizeof(prediction_queue)
    );

    ei_printf("\r\n");
    ei_printf("========================================\r\n");
    ei_printf(" HS300x + Edge Impulse Validation\r\n");
    ei_printf(" Sample interval : 5 sec\r\n");
    ei_printf(" History window  : 30 sec / 7 samples\r\n");
    ei_printf(" Forecast horizon: +30 sec\r\n");
    ei_printf(" Model input     : 22 history/trend features\r\n");
    ei_printf(" Model output    : scaled dT / real dRH\r\n");
    ei_printf("========================================\r\n");

    if (I2C_HAL_MasterDMA_Init() != I2C_HAL_STATUS_OK)
    {
        ei_printf("ERR,I2C_DMA_Init\r\n");
        return -1;
    }

    HS300X_Init();

    sensor_status =
        HS300X_StartMeasurement();

    if (sensor_status == HS300X_STATUS_OK)
    {
        last_sample_start_ms =
            I2C_HAL_GetTickMs();
    }
    else
    {
        ei_printf(
            "ERR,HS300X_StartMeasurement,%d\r\n",
            (int)sensor_status
        );
    }

    while (1)
    {
        I2C_HAL_Process();
        HS300X_Process();

        if (HS300X_DataReady())
        {
            HS300X_ClearDataReady();

            process_new_sensor_sample(
                sample_id
            );

            sample_id++;
        }

        /*
         * Start one HS300x acquisition every 5 seconds.
         * The ~40 ms conversion time does not accumulate because
         * timing is referenced to the acquisition start time.
         */
        if ((!HS300X_IsBusy()) &&
            (!I2C_HAL_IsBusy()) &&
            ((uint32_t)(
                I2C_HAL_GetTickMs() -
                last_sample_start_ms
            ) >= SAMPLE_INTERVAL_MS))
        {
            sensor_status =
                HS300X_StartMeasurement();

            if (sensor_status == HS300X_STATUS_OK)
            {
                last_sample_start_ms =
                    I2C_HAL_GetTickMs();
            }
            else if (
                sensor_status ==
                HS300X_STATUS_I2C_ERROR
            )
            {
                ei_printf(
                    "ERR,HS300X_StartMeasurement,I2C=%lu\r\n",
                    (unsigned long)I2C_HAL_GetLastError()
                );

                last_sample_start_ms =
                    I2C_HAL_GetTickMs();
            }
        }

        __WFI();
    }

    return 0;
}

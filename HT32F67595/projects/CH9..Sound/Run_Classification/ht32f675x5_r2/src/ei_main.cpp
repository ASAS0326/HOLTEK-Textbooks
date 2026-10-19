#include "ei_main.h"

#include "I2S.h"
#include "SPH0645LM4H.h"

#include "edge-impulse-sdk/porting/ei_classifier_porting.h"
#include "ei_run_classifier.h"

#include <stddef.h>
#include <stdint.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <RegHT32F675x5.h>
#include <core_cm33.h>

extern "C" {
    #include "type_def.h"
    #include "hw_uart.h"
    #include "app_cfg.h"
    #include "boards.h"
    #include "app_debug.h"

    void rom_delay_ms(uint32_t ms);
    extern uint32_t SysTick_GetTick(void);
}

static uint32_t s_dwt_last = 0;
static uint64_t s_dwt_high = 0;

#ifndef EI_UART_HANDLE
#define EI_UART_HANDLE UART_HANDLE_APP_DEBUG
#endif

#define CRY_THRESHOLD                   (0.85f)
#define CRY_MARGIN                      (0.25f)
#define LAUGH_VETO_THRESHOLD            (0.40f)

#define CRY_HISTORY_SIZE                (8U)
#define CRY_REQUIRED_COUNT              (6U)
#define CRY_AVERAGE_THRESHOLD           (0.75f)

#define CRY_RELEASE_COUNT               (5U)

#define UART_PRINTF_BUFFER_SIZE          (256U)
#define UART_PRINTF_BUFFER_SIZE          (256U)

/* Keep the formatting buffer off the small MCU stack. */
static char s_uart_printf_buffer[UART_PRINTF_BUFFER_SIZE];

#if (EI_CLASSIFIER_SENSOR != EI_CLASSIFIER_SENSOR_MICROPHONE)
#error "This ei_main.cpp is for an Edge Impulse microphone model"
#endif

#if (EI_CLASSIFIER_FREQUENCY != 8000)
#error "This microphone pipeline currently resamples to exactly 8000 Hz"
#endif

static int16_t s_audio_slice[EI_CLASSIFIER_SLICE_SIZE];
static uint8_t s_cry_history[CRY_HISTORY_SIZE] = {0U};
static float s_cry_score_history[CRY_HISTORY_SIZE] = {0.0f};

static uint32_t s_cry_history_index = 0U;
static uint32_t s_cry_release_counter = 0U;

static bool s_cry_active = false;
/* -------------------------------------------------------------------------- */
/* Edge Impulse platform / porting functions                                  */
/* -------------------------------------------------------------------------- */

EI_IMPULSE_ERROR ei_run_impulse_check_canceled()
{
    return EI_IMPULSE_OK;
}

EI_IMPULSE_ERROR ei_sleep(int32_t time_ms)
{
    rom_delay_ms((uint32_t)time_ms);
    return EI_IMPULSE_OK;
}

static uint64_t get_dwt_cycles(void)
{
    uint32_t now = DWT->CYCCNT;

    if (now < s_dwt_last)
    {
        s_dwt_high += (1ULL << 32);
    }

    s_dwt_last = now;

    return s_dwt_high | (uint64_t)now;
}

uint64_t ei_read_timer_us()
{
    uint64_t cycles = get_dwt_cycles();
    return (cycles * 1000000ULL) / (uint64_t)SystemCoreClock;
}

uint64_t ei_read_timer_ms()
{
    return ei_read_timer_us() / 1000ULL;
}

void ei_putc(char c)
{
    PRINTF("%c", c);
}

void ei_putchar(char c)
{
    ei_putc(c);
}

void ei_printf(const char *format, ...)
{
    int length;
    va_list args;

    if (format == nullptr)
    {
        return;
    }

    va_start(args, format);
    length = vsnprintf(
        s_uart_printf_buffer,
        sizeof(s_uart_printf_buffer),
        format,
        args
    );
    va_end(args);

    if (length <= 0)
    {
        return;
    }

    s_uart_printf_buffer[sizeof(s_uart_printf_buffer) - 1U] = '\0';
    PRINTF("%s", s_uart_printf_buffer);
}

void ei_printf_float(float value)
{
    int32_t whole;
    uint32_t fraction;

    if (value < 0.0f)
    {
        ei_putc('-');
        value = -value;
    }

    whole = (int32_t)value;
    fraction = (uint32_t)((value - (float)whole) * 100000.0f + 0.5f);

    if (fraction >= 100000U)
    {
        whole++;
        fraction -= 100000U;
    }

    ei_printf("%ld.%05lu", (long)whole, (unsigned long)fraction);
}

void *ei_malloc(size_t size)
{
    return malloc(size);
}

void *ei_calloc(size_t nitems, size_t size)
{
    return calloc(nitems, size);
}

void ei_free(void *ptr)
{
    free(ptr);
}

#if defined(__cplusplus) && EI_C_LINKAGE == 1
extern "C"
#endif
void DebugLog(const char *s)
{
    ei_printf("%s", s);
}

/* -------------------------------------------------------------------------- */
/* Audio signal adapter                                                        */
/* -------------------------------------------------------------------------- */

static int microphone_audio_get_data(
    size_t offset,
    size_t length,
    float *out_ptr)
{
    if ((out_ptr == nullptr) || ((offset + length) > EI_CLASSIFIER_SLICE_SIZE))
    {
        return EIDSP_PARAMETER_INVALID;
    }

    for (size_t i = 0; i < length; i++)
    {
        out_ptr[i] = (float)s_audio_slice[offset + i];
    }

    return EIDSP_OK;
}

static void print_probability(float value)
{
    uint32_t scaled;

    if (value < 0.0f)
    {
        value = 0.0f;
    }
    if (value > 1.0f)
    {
        value = 1.0f;
    }

    scaled = (uint32_t)(value * 10000.0f + 0.5f);
    ei_printf("%lu.%04lu",
              (unsigned long)(scaled / 10000U),
              (unsigned long)(scaled % 10000U));
}
static bool baby_cry_filter_update(float cry_score,
                                   float laugh_score,
                                   float noise_score)
{
    uint32_t i;
    uint32_t cry_count = 0U;
    float cry_sum = 0.0f;
    float cry_average;
    bool current_cry = false;

    /*
     * ?? Cry ????
     *
     * 1. Cry ???????
     * 2. Laugh ?????
     * 3. Cry ?????? Laugh
     * 4. Cry ?????? Noise
     */
    if ((cry_score >= CRY_THRESHOLD) &&
        (laugh_score <= LAUGH_VETO_THRESHOLD) &&
        ((cry_score - laugh_score) >= CRY_MARGIN) &&
        ((cry_score - noise_score) >= CRY_MARGIN))
    {
        current_cry = true;
    }

    /*
     * ?????? inference ??
     */
    s_cry_history[s_cry_history_index] =
        current_cry ? 1U : 0U;

    s_cry_score_history[s_cry_history_index] =
        cry_score;

    s_cry_history_index++;

    if (s_cry_history_index >= CRY_HISTORY_SIZE)
    {
        s_cry_history_index = 0U;
    }

    /*
     * ???? CRY_HISTORY_SIZE ?:
     *
     * - ?????? Cry
     * - Cry ?????
     */
    for (i = 0U; i <= (CRY_HISTORY_SIZE - 1U); i++)
    {
        if (s_cry_history[i] != 0U)
        {
            cry_count++;
        }

        cry_sum += s_cry_score_history[i];
    }

    cry_average =
        cry_sum / (float)CRY_HISTORY_SIZE;

    /*
     * ??????:
     *
     * ?? 8 ??? 6 ?? Cry
     * ???? Cry >= 0.75
     */
    if ((cry_count >= CRY_REQUIRED_COUNT) &&
        (cry_average >= CRY_AVERAGE_THRESHOLD))
    {
        return true;
    }

    return false;
}
/* 
 * ????????????:print_inference_result 
 * ?????????????
 */
static void print_inference_result(const ei_impulse_result_t *result)
{
    float cry_score = 0.0f;
    float laugh_score = 0.0f;
    float noise_score = 0.0f;
    bool cry_detected;

    ei_printf("Predictions: ");

    for (size_t i = 0U; i < EI_CLASSIFIER_LABEL_COUNT; i++)
    {
        const char *label =
            result->classification[i].label;

        float value =
            result->classification[i].value;

        if (label != nullptr)
        {
            if (strcmp(label, "cry") == 0)
            {
                cry_score = value;
            }
            else if (strcmp(label, "laugh") == 0)
            {
                laugh_score = value;
            }
            else if (strcmp(label, "noise") == 0)
            {
                noise_score = value;
            }
        }

        ei_printf(
            "%s=",
            label ? label : "?"
        );

        print_probability(value);

        if ((i + 1U) < EI_CLASSIFIER_LABEL_COUNT)
        {
            ei_printf(", ");
        }
    }

    ei_printf(
        " | DSP=%d ms, NN=%d ms",
        result->timing.dsp,
        result->timing.classification
    );

#if EI_CLASSIFIER_HAS_ANOMALY == 1

    ei_printf(
        ", Anomaly=%d ms",
        result->timing.anomaly
    );

#endif

    /*
     * Cry ????
     */
    cry_detected =
        baby_cry_filter_update(
            cry_score,
            laugh_score,
            noise_score
        );

    /*
     * Cry START
     */
    if (cry_detected)
    {
        s_cry_release_counter = 0U;

        if (!s_cry_active)
        {
            s_cry_active = true;

            ei_printf(
                " | >>> CRY START <<<"
            );
        }
        else
        {
            ei_printf(
                " | CRY"
            );
        }
    }
    else
    {
        /*
         * ???? Cry ???,
         * ???????????????
         */
        if (s_cry_active)
        {
            s_cry_release_counter++;

            if (s_cry_release_counter >= CRY_RELEASE_COUNT)
            {
                s_cry_active = false;
                s_cry_release_counter = 0U;

                ei_printf(
                    " | >>> CRY END <<<"
                );
            }
            else
            {
                ei_printf(
                    " | CRY"
                );
            }
        }
    }

    ei_printf("\r\n");
}

/* -------------------------------------------------------------------------- */
/* Main continuous inference (?????????)                             */
/* -------------------------------------------------------------------------- */

int ei_main(void)
{
    static ei_impulse_result_t result;
    static signal_t signal;
    uint32_t slice_counter = 0;
    uint32_t last_dropped = 0;

    memset(&result, 0, sizeof(result));
    memset(&signal, 0, sizeof(signal));

		memset(
			s_cry_history,
			0,
			sizeof(s_cry_history)
		);

		memset(
			s_cry_score_history,
			0,
			sizeof(s_cry_score_history)
		);

		s_cry_history_index = 0U;
		s_cry_release_counter = 0U;
		s_cry_active = false;
		
    PRINTF("[E1] ei_main entered\r\n");
    PRINTF("[E2] model %luHz win=%lu slice=%lu\r\n",
           (unsigned long)EI_CLASSIFIER_FREQUENCY,
           (unsigned long)EI_CLASSIFIER_RAW_SAMPLE_COUNT,
           (unsigned long)EI_CLASSIFIER_SLICE_SIZE);

    PRINTF("[E3] SPH init\r\n");
    SPH0645LM4H_Init();
    PRINTF("[E4] SPH OK\r\n");

    PRINTF("[E5] classifier init\r\n");
    run_classifier_init();
    PRINTF("[E6] classifier OK\r\n");

    PRINTF("[E7] I2S/DMA init\r\n");
    I2S_MasterRx_Init();
    PRINTF("[E8] I2S/DMA OK\r\n");

    signal.total_length = EI_CLASSIFIER_SLICE_SIZE;
    signal.get_data = &microphone_audio_get_data;

    ei_printf("Microphone started. Waiting for audio...\r\n");
    ei_printf("==================================\r\n");
    ei_printf("   BABY CRY INFERENCE MODE START  \r\n");
    ei_printf("==================================\r\n");

    while (1)
    {
        uint32_t dropped;
        EI_IMPULSE_ERROR res;

        /* 1. ???????? Slice ????? */
        if (!SPH0645LM4H_ReadSamples(
                s_audio_slice,
                EI_CLASSIFIER_SLICE_SIZE))
        {
            rom_delay_ms(1);
            continue;
        }

        slice_counter++;

        /* 2. ?????? (Continuous Inference) */
        res = run_classifier_continuous(
            &signal,
            &result,
            false
        );

        if (res != EI_IMPULSE_OK)
        {
            ei_printf("ERROR: run_classifier_continuous() = %d\r\n", res);
            return 1;
        }

        /* 3. ?????? */
        if (slice_counter >= EI_CLASSIFIER_SLICES_PER_MODEL_WINDOW)
        {
            print_inference_result(&result);
        }
        else
        {
            ei_printf("Warm-up slice %lu/%lu\r\n",
                      (unsigned long)slice_counter,
                      (unsigned long)EI_CLASSIFIER_SLICES_PER_MODEL_WINDOW);
        }

        /* 4. ??????? (??) */
        dropped = SPH0645LM4H_GetDroppedSampleCount();
        if (dropped != last_dropped)
        {
            ei_printf("WARNING: audio backlog, dropped=%lu samples\r\n",
                      (unsigned long)dropped);
            last_dropped = dropped;
        }

        if (I2S_GetDmaErrorCount() != 0U)
        {
            ei_printf("WARNING: DMA error count=%lu\r\n",
                      (unsigned long)I2S_GetDmaErrorCount());
        }
    }
}
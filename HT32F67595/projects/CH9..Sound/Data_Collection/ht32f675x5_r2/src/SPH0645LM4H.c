#include "SPH0645LM4H.h"

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>

#include "RegHT32F675x5.h"
#include "err_def.h"
#include "app_cfg.h"
#include "boards.h"
#include "type_def.h"
#include "app_debug.h"

#define MIC_SELECT_INDEX        (1U)
#define MIC_INPUT_RATE_HZ       (31250UL)
#define MIC_OUTPUT_RATE_HZ      (8000UL)
#define MIC_DC_SHIFT            (8U)
#define MIC_GAIN                (1)

static uint32_t s_resample_phase = 0U;
static int32_t s_group_sum = 0;
static uint32_t s_group_count = 0U;
static int32_t s_dc = 0;
static uint32_t s_output_count = 0U;

static int16_t clip_i16(int32_t x)
{
    if (x > 32767)
    {
        return 32767;
    }

    if (x < -32768)
    {
        return -32768;
    }

    return (int16_t)x;
}

static void uart_send_byte(uint8_t data)
{
    putchar((int)data);
}

static void uart_send_int16_line(int16_t value)
{
    char digits[6];
    uint16_t magnitude;
    uint8_t count = 0U;

    if (value < 0)
    {
        uart_send_byte((uint8_t)'-');
        magnitude = (uint16_t)(-(int32_t)value);
    }
    else
    {
        magnitude = (uint16_t)value;
    }

    if (magnitude == 0U)
    {
        uart_send_byte((uint8_t)'0');
    }
    else
    {
        while (magnitude != 0U)
        {
            digits[count++] =
                (char)('0' + (magnitude % 10U));

            magnitude /= 10U;
        }

        while (count != 0U)
        {
            count--;
            uart_send_byte((uint8_t)digits[count]);
        }
    }

    uart_send_byte((uint8_t)'\r');
    uart_send_byte((uint8_t)'\n');
}

void SPH0645LM4H_Init(void)
{
    s_resample_phase = 0U;
    s_group_sum = 0;
    s_group_count = 0U;
    s_dc = 0;
    s_output_count = 0U;
}

void SPH0645LM4H_ProcessBuffer(
    uint32_t *buf,
    uint32_t word_count)
{
    uint32_t i;

    if (buf == NULL)
    {
        return;
    }

    for (i = MIC_SELECT_INDEX;
         i < word_count;
         i += 2U)
    {
        uint32_t raw;
        int32_t sample24;
        int32_t sample32;
        int16_t sample16;

        raw = buf[i];

        sample24 = (int32_t)(raw >> 8);

        if (sample24 & 0x00800000L)
        {
            sample24 |= (int32_t)0xFF000000L;
        }

        sample32 = sample24 >> 8;

        s_group_sum += sample32;
        s_group_count++;

        s_resample_phase += MIC_OUTPUT_RATE_HZ;

        if (s_resample_phase >= MIC_INPUT_RATE_HZ)
        {
            s_resample_phase -= MIC_INPUT_RATE_HZ;

            sample32 =
                s_group_sum /
                (int32_t)s_group_count;

            s_group_sum = 0;
            s_group_count = 0U;

            s_dc +=
                (sample32 - s_dc) >>
                MIC_DC_SHIFT;

            sample32 -= s_dc;
            sample32 *= MIC_GAIN;

            sample16 = clip_i16(sample32);

            uart_send_int16_line(sample16);

            s_output_count++;
        }
    }
}

uint32_t SPH0645LM4H_GetOutputCount(void)
{
    return s_output_count;
}

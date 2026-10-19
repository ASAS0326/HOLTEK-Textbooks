/**
 * @file    SPH0645LM4H.c
 * @brief   SPH0645LM4H streaming PCM decode and 8 kHz resampling.
 */

#include "SPH0645LM4H.h"

#include <stddef.h>
#include <stdint.h>

/*
 * Hardware test from the previous project confirmed microphone samples are in
 * raw DMA words 1, 3, 5, ... (one channel of the stereo I2S frame).
 */
#define MIC_SELECT_INDEX                   (1U)

/* Raw I2S sample rate from 16 MHz / 8 / 64. */
#define MIC_INPUT_SAMPLE_RATE_HZ           (31250U)

/*
 * 31,250 -> 8,000 Hz is exactly 32 / 125.
 * The integer phase accumulator therefore produces the correct long-term
 * sample rate without pretending that 7,812.5 Hz is 8 kHz.
 */
#define RESAMPLE_PHASE_INCREMENT           (32U)
#define RESAMPLE_PHASE_MODULUS             (125U)

#define MIC_GAIN                           (1)
#define MIC_DC_SHIFT                       (8U)
#define AUDIO_RING_MASK                    (SPH0645LM4H_AUDIO_RING_SAMPLES - 1U)

#if ((SPH0645LM4H_AUDIO_RING_SAMPLES & AUDIO_RING_MASK) != 0U)
#error "SPH0645LM4H_AUDIO_RING_SAMPLES must be a power of two"
#endif

/*
 * ISR writes s_write_seq only. Main reads/writes s_read_seq.
 * Sequence counters avoid a shared read-modify-write sample count.
 */
static volatile int16_t s_audio_ring[SPH0645LM4H_AUDIO_RING_SAMPLES];
static volatile uint32_t s_write_seq = 0;
static volatile uint32_t s_read_seq = 0;
static volatile uint32_t s_dropped_samples = 0;

static int32_t s_dc = 0;
static int32_t s_lpf = 0;
static uint32_t s_resample_phase = 0;

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

static void ring_push_from_isr(int16_t sample)
{
    uint32_t w = s_write_seq;

    s_audio_ring[w & AUDIO_RING_MASK] = sample;
    s_write_seq = w + 1U;
}

void SPH0645LM4H_Init(void)
{
    uint32_t i;

    for (i = 0; i < SPH0645LM4H_AUDIO_RING_SAMPLES; i++)
    {
        s_audio_ring[i] = 0;
    }

    s_write_seq = 0;
    s_read_seq = 0;
    s_dropped_samples = 0;

    s_dc = 0;
    s_lpf = 0;
    s_resample_phase = 0;
}

void SPH0645LM4H_ProcessRawBufferFromISR(
    const uint32_t *buf,
    uint32_t word_count)
{
    uint32_t i;

    if (buf == NULL)
    {
        return;
    }

    for (i = MIC_SELECT_INDEX; i < word_count; i += 2U)
    {
        uint32_t raw;
        int32_t sample24;
        int32_t sample32;

        raw = buf[i];

        /* Bits 31..8 contain the 24-bit signed I2S sample. */
        sample24 = (int32_t)(raw >> 8);

        if (sample24 & 0x00800000L)
        {
            sample24 |= (int32_t)0xFF000000L;
        }

        /* 24-bit -> approximately signed 16-bit dynamic range. */
        sample32 = sample24 >> 8;

        /* Very slow DC tracking / high-pass behaviour. */
        s_dc += (sample32 - s_dc) >> MIC_DC_SHIFT;
        sample32 -= s_dc;

        /*
         * Lightweight anti-alias low-pass before reducing to 8 kHz.
         * y[n] = y[n-1] + 0.5 * (x[n] - y[n-1])
         */
        s_lpf += (sample32 - s_lpf) >> 1;

        sample32 = s_lpf * MIC_GAIN;

        /* Exact-average rational rate conversion: 32 outputs / 125 inputs. */
        s_resample_phase += RESAMPLE_PHASE_INCREMENT;

        if (s_resample_phase >= RESAMPLE_PHASE_MODULUS)
        {
            s_resample_phase -= RESAMPLE_PHASE_MODULUS;
            ring_push_from_isr(clip_i16(sample32));
        }
    }
}

uint32_t SPH0645LM4H_AvailableSamples(void)
{
    uint32_t w = s_write_seq;
    uint32_t r = s_read_seq;
    uint32_t available = w - r;

    if (available > SPH0645LM4H_AUDIO_RING_SAMPLES)
    {
        available = SPH0645LM4H_AUDIO_RING_SAMPLES;
    }

    return available;
}

bool SPH0645LM4H_ReadSamples(
    int16_t *dst,
    uint32_t sample_count)
{
    uint32_t w;
    uint32_t r;
    uint32_t available;
    uint32_t i;

    if ((dst == NULL) ||
        (sample_count == 0U) ||
        (sample_count > SPH0645LM4H_AUDIO_RING_SAMPLES))
    {
        return false;
    }

    w = s_write_seq;
    r = s_read_seq;

    available = w - r;

    /*
     * ?????? Ring Buffer ???,
     * ????????????
     */
    if (available > SPH0645LM4H_AUDIO_RING_SAMPLES)
    {
        uint32_t lost;

        lost =
            available -
            SPH0645LM4H_AUDIO_RING_SAMPLES;

        s_dropped_samples += lost;

        /*
         * ?????????????
         */
        r = w -
            SPH0645LM4H_AUDIO_RING_SAMPLES;

        available =
            SPH0645LM4H_AUDIO_RING_SAMPLES;
    }

    /*
     * ????? 2000 samples?
     */
    if (available < sample_count)
    {
        return false;
    }

    for (i = 0; i < sample_count; i++)
    {
        dst[i] =
            s_audio_ring[
                (r + i) & AUDIO_RING_MASK
            ];
    }

    s_read_seq = r + sample_count;

    return true;
}

uint32_t SPH0645LM4H_GetDroppedSampleCount(void)
{
    return s_dropped_samples;
}
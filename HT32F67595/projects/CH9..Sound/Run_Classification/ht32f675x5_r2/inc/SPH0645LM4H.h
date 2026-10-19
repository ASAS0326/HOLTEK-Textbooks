/**
 * @file    SPH0645LM4H.h
 * @brief   SPH0645LM4H PCM decoding + 31.25 kHz to 8 kHz streaming resampler.
 */

#ifndef SPH0645LM4H_H
#define SPH0645LM4H_H

#include <stdbool.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define SPH0645LM4H_OUTPUT_SAMPLE_RATE_HZ   (8000U)
#define SPH0645LM4H_AUDIO_RING_SAMPLES      (4096U)

/** Reset PCM decoder, resampler and audio ring state. */
void SPH0645LM4H_Init(void);

/**
 * Decode one completed raw I2S DMA buffer.
 * This function is intended to be called from the DMA ISR.
 */
void SPH0645LM4H_ProcessRawBufferFromISR(
    const uint32_t *buf,
    uint32_t word_count
);

/** Number of currently buffered 8 kHz int16 samples. */
uint32_t SPH0645LM4H_AvailableSamples(void);

/**
 * Read exactly sample_count samples from the ring.
 * Returns false if there is not enough audio yet.
 */
bool SPH0645LM4H_ReadSamples(
    int16_t *dst,
    uint32_t sample_count
);

/** Number of samples skipped because the consumer fell too far behind. */
uint32_t SPH0645LM4H_GetDroppedSampleCount(void);

#ifdef __cplusplus
}
#endif
#endif /* SPH0645LM4H_H */

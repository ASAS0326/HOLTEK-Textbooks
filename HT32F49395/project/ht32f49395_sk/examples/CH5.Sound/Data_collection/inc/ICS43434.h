#ifndef __ICS43434_H
#define __ICS43434_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define MIC_INPUT_SAMPLE_RATE_HZ     48000UL
#define MIC_OUTPUT_SAMPLE_RATE_HZ     8000UL
#define ICS43434_PCM_SAMPLES            128U

typedef enum
{
  ICS43434_CHANNEL_LEFT = 0,
  ICS43434_CHANNEL_RIGHT = 1
} ICS43434_channel_type;

void ICS43434_init(void);
void ICS43434_start(void);
void ICS43434_stop(void);

void ICS43434_set_channel(
    ICS43434_channel_type channel);

uint32_t ICS43434_read_pcm16(
    int16_t *pcm_buffer,
    uint32_t max_samples);

void ICS43434_dma_irq_handler(void);

uint32_t ICS43434_get_dma_irq_count(void);
uint32_t ICS43434_get_overrun_count(void);
uint32_t ICS43434_get_dma_error_count(void);

#ifdef __cplusplus
}
#endif

#endif

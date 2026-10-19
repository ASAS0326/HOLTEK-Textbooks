#ifndef SPH0645LM4H_H
#define SPH0645LM4H_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define SPH0645_INPUT_RATE_HZ     31250UL
#define SPH0645_OUTPUT_RATE_HZ     8000UL

void SPH0645LM4H_Init(void);

void SPH0645LM4H_ProcessBuffer(
    uint32_t *buf,
    uint32_t word_count);

uint32_t SPH0645LM4H_GetOutputCount(void);

#ifdef __cplusplus
}
#endif

#endif

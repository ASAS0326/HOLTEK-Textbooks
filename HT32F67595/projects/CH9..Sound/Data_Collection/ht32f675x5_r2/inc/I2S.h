#ifndef USER_I2S_H
#define USER_I2S_H

#include <stdbool.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define I2S_DATA_BUF_SIZE        (4U * 1024U)
#define I2S_DMA_SAMPLE_COUNT     (I2S_DATA_BUF_SIZE / sizeof(uint32_t))

void I2S_MasterRx_Init(void);
bool I2S_AcquireReadyBuffer(uint32_t **ppBuf);
uint32_t I2S_GetRxSampleCount(void);
uint32_t I2S_GetOverrunCount(void);

#ifdef __cplusplus
}
#endif

#endif

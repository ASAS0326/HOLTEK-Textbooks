/**
 * @file    I2S.h
 * @brief   HT32F675x5 continuous I2S RX with ping-pong DMA.
 */

#ifndef USER_I2S_H
#define USER_I2S_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/*
 * One DMA buffer = 4 KiB = 1024 x uint32_t words.
 * With stereo 32-bit slots, one microphone channel contributes 512 samples.
 */
#define I2S_DATA_BUF_SIZE        (4U * 1024U)
#define I2S_DMA_SAMPLE_COUNT     (I2S_DATA_BUF_SIZE / sizeof(uint32_t))

/** Initialize GPIO / I2S / DMA and start continuous reception. */
void I2S_MasterRx_Init(void);

/** Number of uint32_t words in one DMA buffer. */
uint32_t I2S_GetRxSampleCount(void);

/** Number of unexpected DMA interrupt events. */
uint32_t I2S_GetDmaErrorCount(void);

uint32_t I2S_GetDmaIrqCount(void);
uint32_t I2S_GetDmaDoneCount(void);
uint8_t I2S_GetDmaLastFlag(void);
uint16_t I2S_GetDmaTransferPointer(void);
uint32_t I2S_GetRawProbe0(void);
uint32_t I2S_GetRawProbe1(void);


#ifdef __cplusplus
}
#endif

#endif /* USER_I2S_H */
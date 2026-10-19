#ifndef USER_I2C_H
#define USER_I2C_H

#include <stdbool.h>
#include <stdint.h>

#include "RegHT32F675x5.h"
#include "err_def.h"
#include "hal_pmu.h"
#include "hw_crg.h"
#include "hw_pmu.h"
#include "type_def.h"

typedef enum
{
    I2C_HAL_STATUS_OK = 0,
    I2C_HAL_STATUS_BUSY,
    I2C_HAL_STATUS_PARA_ERROR,
    I2C_HAL_STATUS_HW_ERROR
} I2C_HAL_STATUS_T;

typedef enum
{
    I2C_HAL_EVENT_NONE = 0,
    I2C_HAL_EVENT_TX_DONE,
    I2C_HAL_EVENT_RX_DONE,
    I2C_HAL_EVENT_ERROR
} I2C_HAL_EVENT_T;

#define I2C_HAL_ERROR_NONE       (0U)
#define I2C_HAL_ERROR_TIMEOUT    (1U)
#define I2C_HAL_ERROR_NACK       (2U)
#define I2C_HAL_ERROR_DMA        (3U)
#define I2C_HAL_ERROR_HW         (4U)

void system_power_init(void);
void system_clock_init(EN_SYS_CLK_SRC_SEL_T enSysClkSrc);
void peripheral_init(void);

I2C_HAL_STATUS_T I2C_HAL_MasterDMA_Init(void);
I2C_HAL_STATUS_T I2C_HAL_MasterWriteDMA(uint8_t *pData, uint16_t length, bool send_stop);
I2C_HAL_STATUS_T I2C_HAL_MasterReadDMA(uint8_t *pData, uint16_t length, bool send_stop);

void I2C_HAL_Process(void);
I2C_HAL_EVENT_T I2C_HAL_TakeEvent(void);
bool I2C_HAL_IsBusy(void);
uint32_t I2C_HAL_GetLastError(void);

uint32_t I2C_HAL_GetTickMs(void);

#endif /* USER_I2C_H */

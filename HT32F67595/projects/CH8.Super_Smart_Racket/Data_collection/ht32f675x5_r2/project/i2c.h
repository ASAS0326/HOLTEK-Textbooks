/*************************************************************************************************************
 * @file    i2c.h
 * @brief   I2C module example header file.
 ************************************************************************************************************/

#ifndef __I2C_H__
#define __I2C_H__

/* 1. ?????????? */
#include <stdint.h>
#include <stdbool.h>

/* 2. ?? Holtek ???????????? */
#include "RegHT32F675x5.h"
#include "type_def.h"
#include "err_def.h"

/* 3. ????????????????? (?? EN_SYS_CLK_SRC_SEL_T ? EN_SYS_CLK_DCXO16M ??) */
#include "hw_crg.h"
#include "hal_pmu.h"
#include "hw_pmu.h"

#define I2C_BUF_SIZE    (32)

typedef enum
{
    EN_I2C_EXAMPLE_MASTER_BLOCK,
    EN_I2C_EXAMPLE_MASTER_DMA,
    EN_I2C_EXAMPLE_SLAVE_BLOCK,
    EN_I2C_EXAMPLE_SLAVE_DMA,
} EN_I2C_EXAMPLE_T;
static uint8_t gpu8MasterSendData[I2C_BUF_SIZE];
static uint8_t gpu8MasterRecvData[I2C_BUF_SIZE];
static uint8_t gpu8SlaveSendData[I2C_BUF_SIZE];
static uint8_t gpu8SlaveRecvData[I2C_BUF_SIZE];
/* ???? */
void system_power_init(void);
void system_clock_init(EN_SYS_CLK_SRC_SEL_T enSysClkSrc);
void peripheral_init(void);
void i2c_example(void);

#endif /* __I2C_H__ */
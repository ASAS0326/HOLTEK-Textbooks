/*************************************************************************************************************
 * @file    app_cfg.h
 * @version V1.0
 * @date    2021-06-10
 * @brief   I2S example code app configuration.
 *************************************************************************************************************
 * @attention
 *
 * Firmware Disclaimer Information
 *
 * 1. The customer hereby acknowledges and agrees that the program technical documentation, including the
 *    code, which is supplied by Holtek Semiconductor Inc., (hereinafter referred to as "HOLTEK") is the
 *    proprietary and confidential intellectual property of HOLTEK, and is protected by copyright law and
 *    other intellectual property laws.
 *
 * 2. The customer hereby acknowledges and agrees that the program technical documentation, including the
 *    code, is confidential information belonging to HOLTEK, and must not be disclosed to any third parties
 *    other than HOLTEK and the customer.
 *
 * 3. The program technical documentation, including the code, is provided "as is" and for customer reference
 *    only. After delivery by HOLTEK, the customer shall use the program technical documentation, including
 *    the code, at their own risk. HOLTEK disclaims any expressed, implied or statutory warranties, including
 *    the warranties of merchantability, satisfactory quality and fitness for a particular purpose.
 *
 * <h2><center>Copyright (C) Holtek Semiconductor Inc. All rights reserved</center></h2>
 ************************************************************************************************************/


#ifndef __APP_CFG_H__
#define __APP_CFG_H__

#include "..\..\..\..\..\sources\mem_cfg\ht32f675x5_mem_cfg_r2.h"

#define RAM_VECTOR_ADDR                    (RAM_2ND_BOOT_ADDR)
#define RAM_VECTOR_SIZE_MAX                (512)

#define RAM_CODE_ADDR                      (RAM_VECTOR_ADDR + RAM_VECTOR_SIZE_MAX)
#define RAM_CODE_SIZE_MAX                  (32 * KBYTE - RAM_VECTOR_SIZE_MAX)

#define RAM_DATA_ADDR                      (RAM_CODE_ADDR + RAM_CODE_SIZE_MAX)
#define RAM_DATA_SIZE_MAX                  (20 * KBYTE)

#define RAM_STACK_SIZE_MAX                 (4 * KBYTE)
#define RAM_HEAP_SIZE_MAX                  (0 * KBYTE)
#define RAM_STACK_HEAP_SIZE_MAX            (RAM_STACK_SIZE_MAX + RAM_HEAP_SIZE_MAX)
#define RAM_STACK_HEAP_ADDR                (RAM_DATA_ADDR + RAM_DATA_SIZE_MAX - RAM_STACK_HEAP_SIZE_MAX)

#define FLASH_APP_CODE_ADDR                (FLASH_BASE_ADDR + FLASH_BOOT_RESERVED_SIZE_MAX)
#define FLASH_APP_CODE_SIZE_MAX            (FLASH_SIZE_MAX - FLASH_BOOT_RESERVED_SIZE_MAX)

#define GPIO_PORT_APP_DEBUG_TX             (GPIO_PORT_UART0_TX)
#define GPIO_PIN_APP_DEBUG_TX              (GPIO_PIN_UART0_TX)

#define GPIO_PORT_I2S_WCLK                 (GPIOB)
#define GPIO_PIN_I2S_WCLK                  (GPIO_PIN_0)
#define GPIO_PORT_I2S_BCLK                 (GPIOA)
#define GPIO_PIN_I2S_BCLK                  (GPIO_PIN_9)
#define GPIO_PORT_I2S_OUT_DATA             (GPIOA)
#define GPIO_PIN_I2S_OUT_DATA              (GPIO_PIN_21)
#define GPIO_PORT_I2S_MCLK                 (GPIOA)
#define GPIO_PIN_I2S_MCLK                  (GPIO_PIN_24)
 
#define GPIO_PORT_I2S_Power                (GPIOB)
#define GPIO_PIN_I2S_Power                 (GPIO_PIN_11)//P43


#define UART_HANDLE_APP_DEBUG              (UART0)
#define UART_BPS_APP_DEBUG                 (921600)

#define RC_HCLK_TUNE_DEFAUT_VAL            (0x56)
#define RC_LCLK_TUNE_DEFAUT_VAL            (0xA9)

#define DCXO_HCLK_STABLE_TIME_2500US       (2500)
#define DCXO_HCLK_STABLE_TIME_2000US       (2000)

#define APP_DEBUG_ENABLED                  (1)

#if APP_DEBUG_ENABLED
    #define PRINTF(fmt, args...)           printf(fmt, ##args)
#else
    #define PRINTF(fmt, args...)
#endif

#endif /* __APP_CFG_H__ */

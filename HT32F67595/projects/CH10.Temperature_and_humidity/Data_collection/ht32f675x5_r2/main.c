/*************************************************************************************************************
 * @file    main.c
 * @brief   HS300x data collection using I2C DMA + UART.
 ************************************************************************************************************/

#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>

#include "RegHT32F675x5.h"
#include "type_def.h"
#include "err_def.h"

#include "app_cfg.h"
#include "boards.h"

#include "hw_wdt.h"
#include "utility.h"
#include "app_debug.h"

#include "i2c.h"
#include "hs300x.h"

/*
 * ??????
 *
 * 1000U   = 1 ?
 * 60000U  = 1 ??
 * 360000U = 6 ??
 */
#define HS300X_SAMPLE_PERIOD_MS    (5000U)

int main(void)
{
    uint32_t last_measurement_ms = 0U;
    uint32_t sample_count = 0U;
    HS300X_STATUS_T sensor_status;

    rom_hw_wdt_disable(WDT0);
    rom_delay_ms(100U);

    system_power_init();
    system_clock_init(EN_SYS_CLK_DCXO16M);
    peripheral_init();

    PRINTF("HS300x Data Logger Start\r\n");

    if (I2C_HAL_MasterDMA_Init() != I2C_HAL_STATUS_OK)
    {
        PRINTF("ERROR,I2C_INIT\r\n");

        for (;;)
        {
        }
    }

    HS300X_Init();

    sensor_status = HS300X_StartMeasurement();

    if (sensor_status == HS300X_STATUS_OK)
    {
        last_measurement_ms = I2C_HAL_GetTickMs();
    }

    for (;;)
    {
        I2C_HAL_Process();
        HS300X_Process();

        /*
         * ???????????
         */
        if (HS300X_DataReady())
        {
            sample_count++;

            /*
             * Python ???? DATA ??????
             *
             * ??:
             * DATA,??,??,??
             *
             * ??:
             * DATA,1,25.42,60.15
             */
            PRINTF(
                "DATA,%lu,%.2f,%.2f\r\n",
                (unsigned long)sample_count,
                g_hs300x_temperature,
                g_hs300x_humidity
            );

            HS300X_ClearDataReady();
        }

        /*
         * ????????????????
         */
        if ((!HS300X_IsBusy()) &&
            ((uint32_t)(I2C_HAL_GetTickMs() - last_measurement_ms) >=
             HS300X_SAMPLE_PERIOD_MS))
        {
            sensor_status = HS300X_StartMeasurement();

            if (sensor_status == HS300X_STATUS_OK)
            {
                last_measurement_ms = I2C_HAL_GetTickMs();
            }
            else if (sensor_status == HS300X_STATUS_I2C_ERROR)
            {
                PRINTF(
                    "ERROR,I2C,%u\r\n",
                    (unsigned int)I2C_HAL_GetLastError()
                );

                last_measurement_ms = I2C_HAL_GetTickMs();
            }
        }

        __WFI();
    }
}
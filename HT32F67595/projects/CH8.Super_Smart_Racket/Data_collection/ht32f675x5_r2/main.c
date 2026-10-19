/*************************************************************************************************************
 * @file    main.c
 * @version V1.0
 * @date    2024-05-21
 * @brief   I2C module example main file.
 ************************************************************************************************************/

/* 1. ???? i2c.h (????? stdint.h ??????) */
#include "i2c.h"

/* 2. ??????????????? */
#include "hw_wdt.h"
#include "utility.h"

/**
 * @brief  I2C example code main function.
 * @return 0.
 */
int main(void)
{
    // Disable watchdog timer.
    rom_hw_wdt_disable(WDT0);

    rom_delay_ms(100);

    // Initialize System Power, Clock, and Peripherals
    system_power_init();
    system_clock_init(EN_SYS_CLK_DCXO16M); 
    peripheral_init();

    // Start I2C Example Process
    i2c_example();

    for (;;)
        ;

    return 0;
}
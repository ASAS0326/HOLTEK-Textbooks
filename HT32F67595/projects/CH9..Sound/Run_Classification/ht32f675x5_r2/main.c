/*************************************************************************************************************
 * @file    main.c
 * @brief   HT32F67595 + SPH0645LM4H + Edge Impulse baby cry inference.
 ************************************************************************************************************/

#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>

#include "RegHT32F675x5.h"
#include "err_def.h"
#include "hw_pmu.h"
#include "hw_efuse.h"
#include "hw_gpio.h"
#include "hw_sys_ctrl.h"
#include "hw_wdt.h"
#include "hal_pmu.h"

#include "app_cfg.h"
#include "boards.h"
#include "utility.h"
#include "app_debug.h"
#include "core_cm33.h"

#include "ei_main.h"

void *__dso_handle = 0;

/* Minimal libc hooks required by the C++/newlib build used by EI. */
void _init(void) {}
void _fini(void) {}

volatile uint32_t g_u32TickCount = 0;

void SysTick_Handler(void)
{
    g_u32TickCount++;
}

uint32_t SysTick_GetTick(void)
{
    /* ??????,???? SysTick_Handler ????? */
    return g_u32TickCount;
}
static void system_power_init(void)
{
    rom_hw_pmu_set_ldo_act_voltage(EN_LDO_ACT_1200mV);
    rom_hw_pmu_set_ldo_dig_voltage(EN_LDO_DIG_1100mV);
    rom_hw_pmu_set_ldo_ret_sleep_voltage(EN_LDO_RET_1100mV);

    rom_hal_pmu_sel_power_act_out_mode(PWR_SEL_LDO);
}

static void system_clock_init(EN_SYS_CLK_SRC_SEL_T enSysClkSrc)
{
    uint8_t u8Tune = 0;

    rom_hw_efuse_read_bytes(EFUSE_RC_HCLK_TUNE_ADDR, &u8Tune, sizeof(u8Tune));
    if (0 == u8Tune)
    {
        rom_hw_pmu_set_rc_hclk_tune(RC_HCLK_TUNE_DEFAUT_VAL);
    }

    rom_hw_efuse_read_bytes(EFUSE_RC_LCLK_TUNE_ADDR, &u8Tune, sizeof(u8Tune));
    if (u8Tune)
    {
        rom_hw_pmu_set_rc_lclk_tune(u8Tune);
    }
    else
    {
        rom_hw_pmu_set_rc_lclk_tune(RC_LCLK_TUNE_DEFAUT_VAL);
    }

    rom_hw_pmu_sel_dcxo_hclk_pwr(EN_DCXO_HCLK_PWR_VDDR);
    rom_hal_pmu_cfg_dcxo_hclk_param(
        DCXO_HCLK_IB_3,
        DCXO_HCLK_NGM_3,
        DCXO_HCLK_CAP_10PF
    );
    rom_hal_pmu_set_sys_clk_src(enSysClkSrc, DCXO_HCLK_STABLE_TIME_2500US);
}

static void peripheral_init(void)
{
    rom_hw_sys_ctrl_peri_int_ctrl(SYS_CTRL_MP, 0, 0);

#if APP_DEBUG_ENABLED
    app_debug_init(
        GPIO_PORT_APP_DEBUG_TX,
        GPIO_PIN_APP_DEBUG_TX,
        UART_HANDLE_APP_DEBUG,
        UART_BPS_APP_DEBUG,
        NULL
    );

    PRINTF("UART ready.\r\n");
#endif
}

int main(void)
{
		SCB->VTOR = 0x10002000;
    rom_hw_wdt_disable(WDT0);

    rom_delay_ms(100);

    system_power_init();
    system_clock_init(EN_SYS_CLK_PLL64M);

    SystemCoreClockUpdate();

    /* Enable Cortex-M33 DWT cycle counter */
CoreDebug->DEMCR |=
    CoreDebug_DEMCR_TRCENA_Msk;

DWT->CYCCNT = 0;

DWT->CTRL |=
    DWT_CTRL_CYCCNTENA_Msk;

peripheral_init();

    peripheral_init();
PRINTF("SystemCoreClock = %lu Hz\r\n",
       (unsigned long)SystemCoreClock);
    /* Allow app_debug UART to finish the startup line before EI logs begin. */
    rom_delay_ms(20);               // <-- ????
    PRINTF("[M1] call ei_main\r\n");
    rom_delay_ms(5);                // <-- ????
		
    (void)ei_main();
		
    PRINTF("[M2] ERROR ei_main returned\r\n");

    while (1) {}
}
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include "RegHT32F675x5.h"
#include "err_def.h"
#include "hw_efuse.h"
#include "hw_pmu.h"
#include "hw_sys_ctrl.h"
#include "hw_wdt.h"
#include "hal_pmu.h"

#include "app_cfg.h"
#include "boards.h"
#include "type_def.h"

#include "app_debug.h"
#include "utility.h"

#include "I2S.h"
#include "SPH0645LM4H.h"

#define EDGE_IMPULSE_UART_BAUD    (921600UL)

static void system_power_init(void)
{
    rom_hw_pmu_set_ldo_act_voltage(
        EN_LDO_ACT_1200mV);

    rom_hw_pmu_set_ldo_dig_voltage(
        EN_LDO_DIG_1100mV);

    rom_hw_pmu_set_ldo_ret_sleep_voltage(
        EN_LDO_RET_1100mV);

    rom_hal_pmu_sel_power_act_out_mode(
        PWR_SEL_LDO);
}

static void system_clock_init(
    EN_SYS_CLK_SRC_SEL_T enSysClkSrc)
{
    uint8_t u8Tune = 0U;

    rom_hw_efuse_read_bytes(
        EFUSE_RC_HCLK_TUNE_ADDR,
        &u8Tune,
        sizeof(u8Tune));

    if (u8Tune == 0U)
    {
        rom_hw_pmu_set_rc_hclk_tune(
            RC_HCLK_TUNE_DEFAUT_VAL);
    }

    rom_hw_efuse_read_bytes(
        EFUSE_RC_LCLK_TUNE_ADDR,
        &u8Tune,
        sizeof(u8Tune));

    if (u8Tune != 0U)
    {
        rom_hw_pmu_set_rc_lclk_tune(
            u8Tune);
    }
    else
    {
        rom_hw_pmu_set_rc_lclk_tune(
            RC_LCLK_TUNE_DEFAUT_VAL);
    }

    rom_hw_pmu_sel_dcxo_hclk_pwr(
        EN_DCXO_HCLK_PWR_VDDR);

    rom_hal_pmu_cfg_dcxo_hclk_param(
        DCXO_HCLK_IB_3,
        DCXO_HCLK_NGM_3,
        DCXO_HCLK_CAP_10PF);

    rom_hal_pmu_set_sys_clk_src(
        enSysClkSrc,
        DCXO_HCLK_STABLE_TIME_2500US);
}

static void peripheral_init(void)
{


    rom_hw_sys_ctrl_peri_int_ctrl(
        SYS_CTRL_MP,
        0,
        0);

    app_debug_init(
        GPIO_PORT_APP_DEBUG_TX,
        GPIO_PIN_APP_DEBUG_TX,
        UART_HANDLE_APP_DEBUG,
        EDGE_IMPULSE_UART_BAUD,
        NULL);
}

int main(void)
{
    uint32_t *ready_buf = NULL;

    rom_hw_wdt_disable(WDT0);
    rom_delay_ms(1000);

    system_power_init();
    system_clock_init(EN_SYS_CLK_DCXO16M);
    peripheral_init();

    SPH0645LM4H_Init();

    I2S_MasterRx_Init();

    for (;;)
    {
        if (I2S_AcquireReadyBuffer(&ready_buf))
        {
            SPH0645LM4H_ProcessBuffer(
                ready_buf,
                I2S_GetRxSampleCount());
        }
    }

    return 0;
}

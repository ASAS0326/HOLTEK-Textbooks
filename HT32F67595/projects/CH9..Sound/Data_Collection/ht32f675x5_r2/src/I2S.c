#include "I2S.h"

#include <string.h>

#include "RegHT32F675x5.h"
#include "err_def.h"
#include "hw_crg.h"
#include "hw_dma.h"
#include "hw_gpio.h"
#include "hw_i2s.h"
#include "hw_sys_ctrl.h"
#include "utility.h"

#include "app_cfg.h"
#include "boards.h"
#include "type_def.h"

#define I2S_DMA_DATA_SIZE        (DMA_DATA_4BYTES)

static uint32_t s_au32RxBuf[2][I2S_DMA_SAMPLE_COUNT]
    __attribute__((aligned(4)));

static stDmaInit_t s_dma_rx_init;
static volatile uint8_t s_dma_active = 0U;
static volatile uint8_t s_ready_mask = 0U;
static volatile uint32_t s_overrun_count = 0U;

static void i2s_enable_rx(void)
{
    I2S->I2S_CFG2 |=
        (ENABLE & I2S_RX_ENABLE_MSK) << I2S_RX_ENABLE_SHIFT;
}

static void i2s_rx_init(
    EN_I2S_WORK_MODE_T enWorkMode,
    bool bEnableMclk)
{
    uint32_t u32Cfg = 0U;

    rom_hw_crg_enable_clk_gate(CRG_I2S_CLK_GATE);
    rom_hw_crg_keep_reset(CRG_I2S_SW_RST);
    rom_hw_crg_release_reset(CRG_I2S_SW_RST);

    /*
     * 16 MHz / 8 = 2 MHz BCLK
     * 2 MHz / 64 stereo-bit clocks = 31.25 kHz frame rate.
     */
    rom_hw_crg_set_i2s_bclk_divisor(
        EN_CRG_I2S_BCLK_DIV_8);

    rom_hw_i2s_deinit();
    rom_hw_i2s_clear_interrupt_flag(I2S_INT_MASK);

    u32Cfg = I2S_CFG_INIT_DEFAULT(
        enWorkMode,
        I2S_STANDARD_I2S,
        EN_I2S_DATA_FORMAT_32BIT,
        I2S_CH_STEREO,
        I2S_BCLK_CPOL_NEGATIVE);

    if (bEnableMclk)
    {
        u32Cfg |=
            ((ENABLE & I2S_MCLK_EN_MSK) << I2S_MCLK_EN_SHIFT);
    }

    rom_hw_i2s_init(u32Cfg);
    rom_delay_us(4);
    rom_hw_i2s_set_wclk_freq(EN_I2S_WCLK_WIDTH_32);
}

static void dma_arm_buffer(uint8_t buffer_index)
{
    rom_hw_dma_disable(DMA0);

    s_dma_rx_init.u32DstAddr =
        (uint32_t)s_au32RxBuf[buffer_index];

    rom_hw_dma_init(DMA0, &s_dma_rx_init);

    rom_hw_dma_set_interrupt_channel(
        DMA0,
        DMA_INT0);

    rom_hw_dma_enable_interrupt(
        DMA0,
        DMA_INT_4_4_DONE);

    rom_hw_dma_enable(DMA0);
}

__RAM_FUNC void DMA_IRQ0_Handler(void)
{
    uint8_t u8Flag = 0U;
    uint8_t completed;
    uint8_t next;
    uint8_t completed_bit;
    uint8_t next_bit;

    rom_hw_dma_get_interrupt_flag(DMA0, &u8Flag);
    rom_hw_dma_clear_interrupt_flag(DMA0, u8Flag);

    if (!(u8Flag & DMA_INT_4_4_DONE))
    {
        return;
    }

    completed = s_dma_active;
    next = completed ^ 1U;

    completed_bit = (uint8_t)(1U << completed);
    next_bit = (uint8_t)(1U << next);

    if (s_ready_mask & completed_bit)
    {
        s_overrun_count++;
    }

    if (s_ready_mask & next_bit)
    {
        s_overrun_count++;
        s_ready_mask &= (uint8_t)~next_bit;
    }

    s_ready_mask |= completed_bit;

    s_dma_active = next;
    dma_arm_buffer(next);
}

void I2S_MasterRx_Init(void)
{
    rom_hw_gpio_set_pin_pid(
        GPIO_PORT_I2S_WCLK,
        GPIO_PIN_I2S_WCLK,
        PID_I2S_WCLK);

    rom_hw_gpio_set_pin_pid(
        GPIO_PORT_I2S_BCLK,
        GPIO_PIN_I2S_BCLK,
        PID_I2S_BCLK);

    rom_hw_gpio_set_pin_pid(
        GPIO_PORT_I2S_OUT_DATA,
        GPIO_PIN_I2S_OUT_DATA,
        PID_I2S_IN_DATA);

    rom_hw_gpio_set_pin_pid(
        GPIO_PORT_I2S_Power,
        GPIO_PIN_11,
        PID_GPIO_PIN);

    rom_hw_gpio_set_pin_input_output(
        GPIO_PORT_I2S_Power,
        GPIO_PIN_11,
        GPIO_MODE_OUTPUT);

    rom_hw_gpio_set_pin_drive_strength(
        GPIO_PORT_I2S_Power,
        GPIO_PIN_11,
        GPIO_DRV_STRENGTH_LEVEL3);

    rom_hw_gpio_set_pin_output_level(
        GPIO_PORT_I2S_Power,
        GPIO_PIN_11,
        GPIO_LEVEL_HI);

    rom_delay_ms(20);

    memset(s_au32RxBuf, 0, sizeof(s_au32RxBuf));
    memset(&s_dma_rx_init, 0, sizeof(s_dma_rx_init));

    s_dma_active = 0U;
    s_ready_mask = 0U;
    s_overrun_count = 0U;

    i2s_rx_init(I2S_WORK_MODE_MASTER, false);

    rom_hw_crg_enable_clk_gate(CRG_DMA_CLK_GATE);

    rom_hw_sys_ctrl_enable_peri_int(
        SYS_CTRL_MP,
        DMA_IRQ0);

    NVIC_ClearPendingIRQ(DMA_IRQ0);
    NVIC_SetPriority(DMA_IRQ0, 0x3);
    NVIC_EnableIRQ(DMA_IRQ0);

    s_dma_rx_init.u32SrcAddr =
        (uint32_t)&I2S->I2S_RX_FIFO;

    s_dma_rx_init.u32DstAddr =
        (uint32_t)s_au32RxBuf[0];

    s_dma_rx_init.u32TimeOut = 1000;

    s_dma_rx_init.unPeriSel.stPeriSel.enPeriID =
        DMA_PERI_I2S_RX;

    s_dma_rx_init.unCfg.u32DMACfg =
        DMA_INIT_PERI_TO_MEM_DEFAULT_CFG(
            I2S_DMA_SAMPLE_COUNT,
            I2S_DMA_DATA_SIZE);

    dma_arm_buffer(0U);
    i2s_enable_rx();
}

bool I2S_AcquireReadyBuffer(uint32_t **ppBuf)
{
    uint8_t mask;

    if (ppBuf == NULL)
    {
        return false;
    }

    mask = s_ready_mask;

    if (mask & 0x01U)
    {
        s_ready_mask &= (uint8_t)~0x01U;
        *ppBuf = s_au32RxBuf[0];
        return true;
    }

    if (mask & 0x02U)
    {
        s_ready_mask &= (uint8_t)~0x02U;
        *ppBuf = s_au32RxBuf[1];
        return true;
    }

    return false;
}

uint32_t I2S_GetRxSampleCount(void)
{
    return I2S_DMA_SAMPLE_COUNT;
}

uint32_t I2S_GetOverrunCount(void)
{
    return s_overrun_count;
}

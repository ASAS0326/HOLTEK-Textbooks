/*************************************************************************************************************
 * @file    i2c.c
 * @brief   HT32F675x5 I2C master HAL using DMA + DMA interrupt + non-blocking state machine.
 ************************************************************************************************************/

#include "i2c.h"

#include <stddef.h>
#include <string.h>

#include "app_cfg.h"
#include "app_debug.h"
#include "boards.h"
#include "hal_pmu.h"
#include "hw_crg.h"
#include "hw_dma.h"
#include "hw_efuse.h"
#include "hw_gpio.h"
#include "hw_i2c.h"
#include "hw_pmu.h"
#include "hw_sys_ctrl.h"
#include "hw_stim.h"
#include "utility.h"

#define I2C_HAL_TIMEOUT_MS    (10U)

typedef enum
{
    I2C_STATE_IDLE = 0,

    I2C_STATE_TX_WAIT_START,
    I2C_STATE_TX_WAIT_DMA,
    I2C_STATE_TX_WAIT_BUS_END,
    I2C_STATE_TX_WAIT_IDLE,

    I2C_STATE_RX_WAIT_START,
    I2C_STATE_RX_WAIT_FULL_STRETCH,
    I2C_STATE_RX_WAIT_DMA,
    I2C_STATE_RX_WAIT_NACK,
    I2C_STATE_RX_WAIT_IDLE
} I2C_HAL_STATE_T;

static volatile uint32_t s_tick_ms = 0U;

#define I2C_HAL_STIM_TICK_MS      (1U)
#define I2C_HAL_STIM_TICK_COUNT   (33U)

static volatile bool s_tx_dma_done = false;
static volatile bool s_rx_dma_done = false;

static I2C_HAL_STATE_T s_state = I2C_STATE_IDLE;
static I2C_HAL_EVENT_T s_event = I2C_HAL_EVENT_NONE;

static bool s_busy = false;
static bool s_send_stop = true;
static uint32_t s_state_tick = 0U;
static uint32_t s_last_error = I2C_HAL_ERROR_NONE;

static stDmaInit_t s_rx_dma_init;
static stDmaInit_t s_tx_dma_init;

static uint8_t *s_rx_buffer = NULL;
static uint16_t s_rx_length = 0U;

static void i2c_clk_and_gpio_init(void);
static I2C_HAL_STATUS_T i2c_timebase_init(void);
static void i2c_timebase_irq_handler(void);
static I2C_HAL_STATUS_T i2c_master_init(void);
static I2C_HAL_STATUS_T i2c_dma_init(void);
static I2C_HAL_STATUS_T i2c_arm_tx_dma(uint8_t *pData, uint16_t length);
static I2C_HAL_STATUS_T i2c_arm_rx_dma(uint8_t *pData, uint16_t length);
static void i2c_set_state(I2C_HAL_STATE_T state);
static void i2c_complete(I2C_HAL_EVENT_T event);
static void i2c_fail(uint32_t error_code);
static bool i2c_state_timeout(void);

void system_power_init(void)
{
    rom_hw_pmu_set_ldo_act_voltage(EN_LDO_ACT_1200mV);
    rom_hw_pmu_set_ldo_dig_voltage(EN_LDO_DIG_1100mV);
    rom_hw_pmu_set_ldo_ret_sleep_voltage(EN_LDO_RET_1100mV);
    rom_hal_pmu_sel_power_act_out_mode(PWR_SEL_LDO);
}

void system_clock_init(EN_SYS_CLK_SRC_SEL_T enSysClkSrc)
{
    uint8_t u8Tune = 0U;

    rom_hw_efuse_read_bytes(EFUSE_RC_HCLK_TUNE_ADDR, &u8Tune, sizeof(u8Tune));
    if (u8Tune == 0U)
    {
        rom_hw_pmu_set_rc_hclk_tune(RC_HCLK_TUNE_DEFAUT_VAL);
    }

    rom_hw_efuse_read_bytes(EFUSE_RC_LCLK_TUNE_ADDR, &u8Tune, sizeof(u8Tune));
    if (u8Tune != 0U)
    {
        rom_hw_pmu_set_rc_lclk_tune(u8Tune);
    }
    else
    {
        rom_hw_pmu_set_rc_lclk_tune(RC_LCLK_TUNE_DEFAUT_VAL);
    }

    rom_hw_pmu_sel_dcxo_hclk_pwr(EN_DCXO_HCLK_PWR_VDDR);
    rom_hal_pmu_cfg_dcxo_hclk_param(DCXO_HCLK_IB_3, DCXO_HCLK_NGM_3, DCXO_HCLK_CAP_10PF);
    rom_hal_pmu_set_sys_clk_src(enSysClkSrc, DCXO_HCLK_STABLE_TIME_2500US);
}

void peripheral_init(void)
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
#endif
}

static I2C_HAL_STATUS_T i2c_timebase_init(void)
{
    uint32_t count = 0U;

    if (rom_hw_crg_enable_clk_gate(CRG_STIM0_CLK_GATE) != ERR_STA_OK)
    {
        return I2C_HAL_STATUS_HW_ERROR;
    }

    rom_hw_stim_stop(STIM0);
    rom_hw_stim_clear_count(STIM0);

    if (rom_hw_stim_set_prescale(STIM0, 0U) != ERR_STA_OK)
    {
        return I2C_HAL_STATUS_HW_ERROR;
    }

    rom_hw_stim_disable_interrupt(STIM0, STIM_INT_MASK);
    rom_hw_stim_clear_interrupt_flag(
        STIM0,
        STIM_CH0_INT_MATCH | STIM_INT_TICK | STIM_INT_OVERFLOW
    );

    if (rom_hw_sys_ctrl_enable_peri_int(SYS_CTRL_MP, STIM0_IRQ0) != ERR_STA_OK)
    {
        return I2C_HAL_STATUS_HW_ERROR;
    }

    if (rom_hw_stim_enable_interrupt(STIM0, STIM_CH0_INT_MATCH) != ERR_STA_OK)
    {
        return I2C_HAL_STATUS_HW_ERROR;
    }

    rom_hw_stim_get_count(STIM0, &count);
    rom_hw_stim_set_compare(STIM0, STIM_CH0, count + I2C_HAL_STIM_TICK_COUNT);

    NVIC_ClearPendingIRQ(STIM0_IRQ0);
    NVIC_SetPriority(STIM0_IRQ0, 0x03U);
    NVIC_EnableIRQ(STIM0_IRQ0);
    __enable_irq();

    if (rom_hw_stim_start(STIM0) != ERR_STA_OK)
    {
        return I2C_HAL_STATUS_HW_ERROR;
    }

    return I2C_HAL_STATUS_OK;
}

static void i2c_timebase_irq_handler(void)
{
    uint16_t int_flag = 0U;
    uint32_t count = 0U;

    rom_hw_stim_get_interrupt_flag(STIM0, &int_flag);

    if ((int_flag & STIM_CH0_INT_MATCH) != 0U)
    {
        rom_hw_stim_clear_interrupt_flag(STIM0, STIM_CH0_INT_MATCH);

        s_tick_ms += I2C_HAL_STIM_TICK_MS;

        rom_hw_stim_get_count(STIM0, &count);
        rom_hw_stim_set_compare(
            STIM0,
            STIM_CH0,
            count + I2C_HAL_STIM_TICK_COUNT
        );
    }

    int_flag &= (uint16_t)(STIM_INT_TICK | STIM_INT_OVERFLOW);
    if (int_flag != 0U)
    {
        rom_hw_stim_clear_interrupt_flag(STIM0, int_flag);
    }
}

/*
 * STIM0 channel-0 IRQ entry.
 *
 * This project SDK uses direct IRQ handler symbols (the same pattern as
 * DMA_IRQ6_Handler / I2C0_IRQ_Handler) instead of g_periIrqFuncTable.
 */
__RAM_FUNC void STIM0_IRQ0_Handler(void)
{
    i2c_timebase_irq_handler();
}

static void i2c_clk_and_gpio_init(void)
{
    EN_GPIO_PID_T enSclkPid;
    EN_GPIO_PID_T enSdaPid;
    EN_CRG_CLK_GATE_T enClkGate;

    if (I2C_HANDLE == I2C0)
    {
        enClkGate = CRG_I2C0_CLK_GATE;
        enSclkPid = PID_I2C0_SCL;
        enSdaPid = PID_I2C0_SDA;
    }
    else if (I2C_HANDLE == I2C1)
    {
        enClkGate = CRG_I2C1_CLK_GATE;
        enSclkPid = PID_I2C1_SCL;
        enSdaPid = PID_I2C1_SDA;
    }
    else
    {
        enClkGate = CRG_I2C2_CLK_GATE;
        enSclkPid = PID_I2C2_SCL;
        enSdaPid = PID_I2C2_SDA;
    }

    rom_hw_crg_enable_clk_gate(enClkGate);

    rom_hw_gpio_set_pin_pid(GPIO_PORT_I2C_SCLK, GPIO_PIN_I2C_SCLK, enSclkPid);
    rom_hw_gpio_set_pin_pid(GPIO_PORT_I2C_SDA, GPIO_PIN_I2C_SDA, enSdaPid);

    rom_hw_gpio_set_pin_pull_mode(GPIO_PORT_I2C_SCLK, GPIO_PIN_I2C_SCLK, GPIO_PULL_NONE);
    rom_hw_gpio_set_pin_pull_mode(GPIO_PORT_I2C_SDA, GPIO_PIN_I2C_SDA, GPIO_PULL_NONE);

    /* Keep the sensor power-enable GPIO behavior from the original project. */
    rom_hw_gpio_set_pin_pid(GPIO_PORT_I2C_SCLK, GPIO_PIN_10, PID_GPIO_PIN);
    rom_hw_gpio_set_pin_input_output(GPIO_PORT_I2C_SCLK, GPIO_PIN_10, GPIO_MODE_OUTPUT);
    rom_hw_gpio_set_pin_drive_strength(GPIO_PORT_I2C_SCLK, GPIO_PIN_10, GPIO_DRV_STRENGTH_LEVEL1);
    rom_hw_gpio_set_pin_output_level(GPIO_PORT_I2C_SCLK, GPIO_PIN_10, GPIO_LEVEL_HI);
}

static I2C_HAL_STATUS_T i2c_master_init(void)
{
    stI2cMasterInit_t stInit;

    i2c_clk_and_gpio_init();

    memset(&stInit, 0, sizeof(stInit));

    stInit.u32BaudRate = I2C_BAUDRATE_100K;
    stInit.u16SlaveAddr = 0x44U;
    stInit.unCfg.stCfg.u8AddrMode = I2C_ADDR_MODE_7_BITS;
    stInit.unCfg.stCfg.u8StretchEn = I2C_STRETCH_ENABLE;
    stInit.unCfg.stCfg.u8TrxMode = I2C_MASTER_MODE_READ;
    stInit.unCfg.stCfg.u8Enable = I2C_ENABLE;

    rom_hw_i2c_master_init(I2C_HANDLE, &stInit);

    return I2C_HAL_STATUS_OK;
}

static I2C_HAL_STATUS_T i2c_dma_init(void)
{
    EN_DMA_PERI_SEL_T enRxPeriID;
    EN_DMA_PERI_SEL_T enTxPeriID;

    if (I2C_HANDLE == I2C0)
    {
        enRxPeriID = DMA_PERI_I2C0_RX;
        enTxPeriID = DMA_PERI_I2C0_TX;
    }
    else if (I2C_HANDLE == I2C1)
    {
        enRxPeriID = DMA_PERI_I2C1_RX;
        enTxPeriID = DMA_PERI_I2C1_TX;
    }
    else
    {
        enRxPeriID = DMA_PERI_I2C2_RX;
        enTxPeriID = DMA_PERI_I2C2_TX;
    }

    if (rom_hw_crg_enable_clk_gate(CRG_DMA_CLK_GATE) != ERR_STA_OK)
    {
        return I2C_HAL_STATUS_HW_ERROR;
    }

    memset(&s_rx_dma_init, 0, sizeof(s_rx_dma_init));
    memset(&s_tx_dma_init, 0, sizeof(s_tx_dma_init));

    s_rx_dma_init.unPeriSel.stPeriSel.enPeriID = enRxPeriID;
    s_rx_dma_init.u32TimeOut = 200U;
    s_rx_dma_init.u32SrcAddr = (uint32_t)&I2C_HANDLE->I2C_RX_FIFO;
    s_rx_dma_init.u32DstAddr = 0U;
    s_rx_dma_init.unCfg.stDmaCfg.u16Length = 1U;
    s_rx_dma_init.unCfg.stDmaCfg.u8CircEn = DMA_NORM;
    s_rx_dma_init.unCfg.stDmaCfg.u8Priority = DMA_PRIO_LEVEL_LOW;
    s_rx_dma_init.unCfg.stDmaCfg.u8WorkMode = DMA_PERI_TO_MEM;
    s_rx_dma_init.unCfg.stDmaCfg.u8DstSize = DMA_DATA_1BYTE;
    s_rx_dma_init.unCfg.stDmaCfg.u8DstIncEN = DMA_ADDR_INC_ENABLE;
    s_rx_dma_init.unCfg.stDmaCfg.u8SrcSize = DMA_DATA_1BYTE;
    s_rx_dma_init.unCfg.stDmaCfg.u8SrcIncEN = DMA_ADDR_INC_DISABLE;
    s_rx_dma_init.unCfg.stDmaCfg.u8StopCfg = 0U;
    s_rx_dma_init.unCfg.stDmaCfg.u8PauseEn = 0U;
    s_rx_dma_init.unCfg.stDmaCfg.u8Enable = DMA_DISABLE;

    if (rom_hw_dma_init(I2C_RX_DMA_HANDLE, &s_rx_dma_init) != ERR_STA_OK)
    {
        return I2C_HAL_STATUS_HW_ERROR;
    }

    s_tx_dma_init.unPeriSel.stPeriSel.enPeriID = enTxPeriID;
    s_tx_dma_init.u32TimeOut = 200U;
    s_tx_dma_init.u32SrcAddr = 0U;
    s_tx_dma_init.u32DstAddr = (uint32_t)&I2C_HANDLE->I2C_TX_FIFO;
    s_tx_dma_init.unCfg.stDmaCfg.u16Length = 1U;
    s_tx_dma_init.unCfg.stDmaCfg.u8CircEn = DMA_NORM;
    s_tx_dma_init.unCfg.stDmaCfg.u8Priority = DMA_PRIO_LEVEL_LOW;
    s_tx_dma_init.unCfg.stDmaCfg.u8WorkMode = DMA_MEM_TO_PERI;
    s_tx_dma_init.unCfg.stDmaCfg.u8DstSize = DMA_DATA_1BYTE;
    s_tx_dma_init.unCfg.stDmaCfg.u8DstIncEN = DMA_ADDR_INC_DISABLE;
    s_tx_dma_init.unCfg.stDmaCfg.u8SrcSize = DMA_DATA_1BYTE;
    s_tx_dma_init.unCfg.stDmaCfg.u8SrcIncEN = DMA_ADDR_INC_ENABLE;
    s_tx_dma_init.unCfg.stDmaCfg.u8StopCfg = 0U;
    s_tx_dma_init.unCfg.stDmaCfg.u8PauseEn = 0U;
    s_tx_dma_init.unCfg.stDmaCfg.u8Enable = DMA_DISABLE;

    if (rom_hw_dma_init(I2C_TX_DMA_HANDLE, &s_tx_dma_init) != ERR_STA_OK)
    {
        return I2C_HAL_STATUS_HW_ERROR;
    }

    if (rom_hw_sys_ctrl_enable_peri_int(SYS_CTRL_MP, DMA_IRQ6) != ERR_STA_OK)
    {
        return I2C_HAL_STATUS_HW_ERROR;
    }

    if (rom_hw_dma_set_interrupt_channel(I2C_RX_DMA_HANDLE, DMA_INT6) != ERR_STA_OK)
    {
        return I2C_HAL_STATUS_HW_ERROR;
    }

    if (rom_hw_dma_set_interrupt_channel(I2C_TX_DMA_HANDLE, DMA_INT6) != ERR_STA_OK)
    {
        return I2C_HAL_STATUS_HW_ERROR;
    }

    NVIC_ClearPendingIRQ(DMA_IRQ6);
    NVIC_SetPriority(DMA_IRQ6, 0x03U);
    NVIC_EnableIRQ(DMA_IRQ6);

    return I2C_HAL_STATUS_OK;
}

I2C_HAL_STATUS_T I2C_HAL_MasterDMA_Init(void)
{
    I2C_HAL_STATUS_T status;

    s_state = I2C_STATE_IDLE;
    s_event = I2C_HAL_EVENT_NONE;
    s_busy = false;
    s_send_stop = true;
    s_tx_dma_done = false;
    s_rx_dma_done = false;
    s_last_error = I2C_HAL_ERROR_NONE;
    s_tick_ms = 0U;

    status = i2c_timebase_init();
    if (status != I2C_HAL_STATUS_OK)
    {
        return status;
    }

    status = i2c_master_init();
    if (status != I2C_HAL_STATUS_OK)
    {
        return status;
    }

    return i2c_dma_init();
}

static I2C_HAL_STATUS_T i2c_arm_tx_dma(uint8_t *pData, uint16_t length)
{
    uint32_t dma_cfg;

    I2C_TX_DMA_HANDLE->DMA_SRC_ADDR = (uint32_t)pData;
    I2C_TX_DMA_HANDLE->DMA_DST_ADDR = (uint32_t)&I2C_HANDLE->I2C_TX_FIFO;

    dma_cfg = I2C_TX_DMA_HANDLE->DMA_CFG;
    dma_cfg &= ~(DMA_LENGTH_VAL_MSK << DMA_LENGTH_VAL_SHIFT);
    dma_cfg |= ((uint32_t)length & DMA_LENGTH_VAL_MSK) << DMA_LENGTH_VAL_SHIFT;
    I2C_TX_DMA_HANDLE->DMA_CFG = dma_cfg;

    if (rom_hw_dma_clear_interrupt_flag(I2C_TX_DMA_HANDLE, DMA_INT_MSK) != ERR_STA_OK)
    {
        return I2C_HAL_STATUS_HW_ERROR;
    }

    if (rom_hw_dma_enable_interrupt(I2C_TX_DMA_HANDLE, DMA_INT_4_4_DONE) != ERR_STA_OK)
    {
        return I2C_HAL_STATUS_HW_ERROR;
    }

    if (rom_hw_dma_set_interval_tx_index(I2C_TX_DMA_HANDLE, 0U) != ERR_STA_OK)
    {
        return I2C_HAL_STATUS_HW_ERROR;
    }

    s_tx_dma_done = false;

    if (rom_hw_dma_enable(I2C_TX_DMA_HANDLE) != ERR_STA_OK)
    {
        return I2C_HAL_STATUS_HW_ERROR;
    }

    return I2C_HAL_STATUS_OK;
}

static I2C_HAL_STATUS_T i2c_arm_rx_dma(uint8_t *pData, uint16_t length)
{
    uint32_t dma_cfg;

    I2C_RX_DMA_HANDLE->DMA_SRC_ADDR = (uint32_t)&I2C_HANDLE->I2C_RX_FIFO;
    I2C_RX_DMA_HANDLE->DMA_DST_ADDR = (uint32_t)pData;

    dma_cfg = I2C_RX_DMA_HANDLE->DMA_CFG;
    dma_cfg &= ~(DMA_LENGTH_VAL_MSK << DMA_LENGTH_VAL_SHIFT);
    dma_cfg |= ((uint32_t)length & DMA_LENGTH_VAL_MSK) << DMA_LENGTH_VAL_SHIFT;
    I2C_RX_DMA_HANDLE->DMA_CFG = dma_cfg;

    if (rom_hw_i2c_set_rxfifo_thld(I2C_HANDLE, 1U) != ERR_STA_OK)
    {
        return I2C_HAL_STATUS_HW_ERROR;
    }

    if (rom_hw_dma_clear_interrupt_flag(I2C_RX_DMA_HANDLE, DMA_INT_MSK) != ERR_STA_OK)
    {
        return I2C_HAL_STATUS_HW_ERROR;
    }

    if (rom_hw_dma_enable_interrupt(I2C_RX_DMA_HANDLE, DMA_INT_4_4_DONE) != ERR_STA_OK)
    {
        return I2C_HAL_STATUS_HW_ERROR;
    }

    s_rx_dma_done = false;

    if (rom_hw_dma_enable(I2C_RX_DMA_HANDLE) != ERR_STA_OK)
    {
        return I2C_HAL_STATUS_HW_ERROR;
    }

    return I2C_HAL_STATUS_OK;
}

I2C_HAL_STATUS_T I2C_HAL_MasterWriteDMA(uint8_t *pData, uint16_t length, bool send_stop)
{
    I2C_HAL_STATUS_T status;

    if ((pData == NULL) || (length == 0U))
    {
        return I2C_HAL_STATUS_PARA_ERROR;
    }

    if (s_busy)
    {
        return I2C_HAL_STATUS_BUSY;
    }

    s_busy = true;
    s_event = I2C_HAL_EVENT_NONE;
    s_last_error = I2C_HAL_ERROR_NONE;
    s_send_stop = send_stop;

    rom_hw_i2c_set_mode(I2C_HANDLE, I2C_MODE_MASTER);
    rom_hw_i2c_master_set_trx_mode(I2C_HANDLE, I2C_MASTER_MODE_WRITE);
    rom_hw_i2c_master_enable_stretch(I2C_HANDLE);

    I2C_HANDLE->I2C_MASTER_CMD = I2C_MASTER_CMD_CLR_STATE_MSK << I2C_MASTER_CMD_CLR_STATE_SHIFT;
    I2C_HANDLE->I2C_INT_CLR = I2C_INT_MASK;
    I2C_HANDLE->I2C_TXFIFO_CLR = I2C_CLR_TXFIFO_MSK << I2C_CLR_TXFIFO_SHIFT;
    I2C_HANDLE->I2C_RXFIFO_CLR = I2C_CLR_RXFIFO_MSK << I2C_CLR_RXFIFO_SHIFT;

    status = i2c_arm_tx_dma(pData, length);
    if (status != I2C_HAL_STATUS_OK)
    {
        i2c_fail(I2C_HAL_ERROR_DMA);
        return status;
    }

    I2C_HANDLE->I2C_MASTER_CMD = I2C_MASTER_CMD_START_MSK << I2C_MASTER_CMD_START_SHIFT;
    i2c_set_state(I2C_STATE_TX_WAIT_START);

    return I2C_HAL_STATUS_OK;
}

I2C_HAL_STATUS_T I2C_HAL_MasterReadDMA(uint8_t *pData, uint16_t length, bool send_stop)
{
    if ((pData == NULL) || (length == 0U))
    {
        return I2C_HAL_STATUS_PARA_ERROR;
    }

    /* The original DMA routine chunks reads at I2C_RX_FIFO_MAX.
     * HS300x only needs 4 bytes, so this non-blocking HAL accepts one FIFO chunk.
     */
    if (length >= ((uint16_t)I2C_RX_FIFO_MAX + 1U))
    {
        return I2C_HAL_STATUS_PARA_ERROR;
    }

    if (s_busy)
    {
        return I2C_HAL_STATUS_BUSY;
    }

    s_busy = true;
    s_event = I2C_HAL_EVENT_NONE;
    s_last_error = I2C_HAL_ERROR_NONE;
    s_send_stop = send_stop;
    s_rx_dma_done = false;
    s_rx_buffer = pData;
    s_rx_length = length;

    rom_hw_i2c_set_mode(I2C_HANDLE, I2C_MODE_MASTER);
    rom_hw_i2c_master_set_trx_mode(I2C_HANDLE, I2C_MASTER_MODE_READ);
    rom_hw_i2c_master_enable_stretch(I2C_HANDLE);

    I2C_HANDLE->I2C_MASTER_CMD = I2C_MASTER_CMD_CLR_STATE_MSK << I2C_MASTER_CMD_CLR_STATE_SHIFT;
    I2C_HANDLE->I2C_INT_CLR = I2C_INT_MASK;
    I2C_HANDLE->I2C_TXFIFO_CLR = I2C_CLR_TXFIFO_MSK << I2C_CLR_TXFIFO_SHIFT;
    I2C_HANDLE->I2C_RXFIFO_CLR = I2C_CLR_RXFIFO_MSK << I2C_CLR_RXFIFO_SHIFT;

    rom_hw_i2c_master_set_rxfifo_full_value(I2C_HANDLE, (uint8_t)length);
    rom_hw_i2c_set_rxfifo_thld(I2C_HANDLE, 1U);

    /* Save the destination and length in the DMA registers now, but enable
     * DMA only after the controller reaches FULL_STRETCH, matching the
     * sequence used by the original blocking DMA code.
     */
    I2C_RX_DMA_HANDLE->DMA_SRC_ADDR = (uint32_t)&I2C_HANDLE->I2C_RX_FIFO;
    I2C_RX_DMA_HANDLE->DMA_DST_ADDR = (uint32_t)pData;

    {
        uint32_t dma_cfg = I2C_RX_DMA_HANDLE->DMA_CFG;
        dma_cfg &= ~(DMA_LENGTH_VAL_MSK << DMA_LENGTH_VAL_SHIFT);
        dma_cfg |= ((uint32_t)length & DMA_LENGTH_VAL_MSK) << DMA_LENGTH_VAL_SHIFT;
        I2C_RX_DMA_HANDLE->DMA_CFG = dma_cfg;
    }

    I2C_HANDLE->I2C_MASTER_CMD = I2C_MASTER_CMD_START_MSK << I2C_MASTER_CMD_START_SHIFT;
    i2c_set_state(I2C_STATE_RX_WAIT_START);

    return I2C_HAL_STATUS_OK;
}

void I2C_HAL_Process(void)
{
    uint32_t master_status;

    if (!s_busy)
    {
        return;
    }

    if (i2c_state_timeout())
    {
        i2c_fail(I2C_HAL_ERROR_TIMEOUT);
        return;
    }

    master_status = I2C_HANDLE->I2C_MASTER_STATUS & 0x1FU;

    switch (s_state)
    {
        case I2C_STATE_TX_WAIT_START:
            if (master_status == MST_NACK_STRETCH)
            {
                i2c_fail(I2C_HAL_ERROR_NACK);
            }
            else if ((master_status == MST_SNED_DATA) ||
                     (master_status == MST_EMPTY_STRETCH) ||
                     (master_status == MST_RCV_DATA_ACK))
            {
                i2c_set_state(I2C_STATE_TX_WAIT_DMA);
            }
            break;

        case I2C_STATE_TX_WAIT_DMA:
            if (s_tx_dma_done)
            {
                s_tx_dma_done = false;
                i2c_set_state(I2C_STATE_TX_WAIT_BUS_END);
            }
            break;

        case I2C_STATE_TX_WAIT_BUS_END:
            if (master_status == MST_NACK_STRETCH)
            {
                i2c_fail(I2C_HAL_ERROR_NACK);
            }
            else if (master_status == MST_EMPTY_STRETCH)
            {
                if (s_send_stop)
                {
                    I2C_HANDLE->I2C_MASTER_CMD = I2C_MASTER_CMD_STOP_MSK << I2C_MASTER_CMD_STOP_SHIFT;
                    i2c_set_state(I2C_STATE_TX_WAIT_IDLE);
                }
                else
                {
                    i2c_complete(I2C_HAL_EVENT_TX_DONE);
                }
            }
            break;

        case I2C_STATE_TX_WAIT_IDLE:
            if (master_status == MST_IDLE)
            {
                i2c_complete(I2C_HAL_EVENT_TX_DONE);
            }
            break;

        case I2C_STATE_RX_WAIT_START:
            if (master_status == MST_NACK_STRETCH)
            {
                i2c_fail(I2C_HAL_ERROR_NACK);
            }
            else if ((master_status == MST_RCV_DATA) ||
                     (master_status == MST_SEND_DATA_ACK) ||
                     (master_status == MST_FULL_STRETCH))
            {
                i2c_set_state(I2C_STATE_RX_WAIT_FULL_STRETCH);
            }
            break;

        case I2C_STATE_RX_WAIT_FULL_STRETCH:
            if (master_status == MST_NACK_STRETCH)
            {
                i2c_fail(I2C_HAL_ERROR_NACK);
            }
            else if (master_status == MST_FULL_STRETCH)
            {
                if (i2c_arm_rx_dma(s_rx_buffer, s_rx_length) != I2C_HAL_STATUS_OK)
                {
                    i2c_fail(I2C_HAL_ERROR_DMA);
                }
                else
                {
                    i2c_set_state(I2C_STATE_RX_WAIT_DMA);
                }
            }
            break;

        case I2C_STATE_RX_WAIT_DMA:
            if (s_rx_dma_done)
            {
                s_rx_dma_done = false;
                I2C_HANDLE->I2C_MASTER_CMD = I2C_MASTER_CMD_NACK_MSK << I2C_MASTER_CMD_NACK_SHIFT;
                i2c_set_state(I2C_STATE_RX_WAIT_NACK);
            }
            break;

        case I2C_STATE_RX_WAIT_NACK:
            if (master_status == MST_NACK_STRETCH)
            {
                if (s_send_stop)
                {
                    I2C_HANDLE->I2C_MASTER_CMD = I2C_MASTER_CMD_STOP_MSK << I2C_MASTER_CMD_STOP_SHIFT;
                    i2c_set_state(I2C_STATE_RX_WAIT_IDLE);
                }
                else
                {
                    i2c_complete(I2C_HAL_EVENT_RX_DONE);
                }
            }
            break;

        case I2C_STATE_RX_WAIT_IDLE:
            if (master_status == MST_IDLE)
            {
                i2c_complete(I2C_HAL_EVENT_RX_DONE);
            }
            break;

        case I2C_STATE_IDLE:
        default:
            break;
    }
}

I2C_HAL_EVENT_T I2C_HAL_TakeEvent(void)
{
    I2C_HAL_EVENT_T event = s_event;
    s_event = I2C_HAL_EVENT_NONE;
    return event;
}

bool I2C_HAL_IsBusy(void)
{
    return s_busy;
}

uint32_t I2C_HAL_GetLastError(void)
{
    return s_last_error;
}

uint32_t I2C_HAL_GetTickMs(void)
{
    return s_tick_ms;
}

static void i2c_set_state(I2C_HAL_STATE_T state)
{
    s_state = state;
    s_state_tick = s_tick_ms;
}

static void i2c_complete(I2C_HAL_EVENT_T event)
{
    rom_hw_i2c_clear_interrupt_flag(I2C_HANDLE, I2C_INT_MASK);

    s_state = I2C_STATE_IDLE;
    s_busy = false;
    s_event = event;
}

static void i2c_fail(uint32_t error_code)
{
    rom_hw_dma_disable(I2C_RX_DMA_HANDLE);
    rom_hw_dma_disable(I2C_TX_DMA_HANDLE);

    I2C_HANDLE->I2C_MASTER_CMD = I2C_MASTER_CMD_STOP_MSK << I2C_MASTER_CMD_STOP_SHIFT;
    rom_hw_i2c_clear_interrupt_flag(I2C_HANDLE, I2C_INT_MASK);

    s_tx_dma_done = false;
    s_rx_dma_done = false;
    s_state = I2C_STATE_IDLE;
    s_busy = false;
    s_last_error = error_code;
    s_event = I2C_HAL_EVENT_ERROR;
}

static bool i2c_state_timeout(void)
{
    return ((uint32_t)(s_tick_ms - s_state_tick) >= I2C_HAL_TIMEOUT_MS);
}

__RAM_FUNC void DMA_IRQ6_Handler(void)
{
    uint8_t int_flag = 0U;

    rom_hw_dma_get_interrupt_flag(I2C_RX_DMA_HANDLE, &int_flag);
    if (int_flag != 0U)
    {
        rom_hw_dma_clear_interrupt_flag(I2C_RX_DMA_HANDLE, int_flag);

        if ((int_flag & DMA_INT_4_4_DONE) != 0U)
        {
            rom_hw_dma_disable(I2C_RX_DMA_HANDLE);
            s_rx_dma_done = true;
        }
    }

    int_flag = 0U;
    rom_hw_dma_get_interrupt_flag(I2C_TX_DMA_HANDLE, &int_flag);
    if (int_flag != 0U)
    {
        rom_hw_dma_clear_interrupt_flag(I2C_TX_DMA_HANDLE, int_flag);

        if ((int_flag & DMA_INT_4_4_DONE) != 0U)
        {
            rom_hw_dma_disable(I2C_TX_DMA_HANDLE);
            s_tx_dma_done = true;
        }
    }
}

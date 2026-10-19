/*************************************************************************************************************
 * @file    i2c.c
 * @brief   I2C module example implementation file.
 ************************************************************************************************************/

#include "i2c.h"
#include <stdio.h>
#include <string.h>

#include "hw_crg.h"
#include "hw_pmu.h"
#include "hw_efuse.h"
#include "hw_gpio.h"
#include "hw_i2c.h"
#include "hw_sys_ctrl.h"
#include "hw_wdt.h"
#include "hal_pmu.h"
#include "hw_dma.h"
#include "patch_hw_i2c.h"

#include "app_cfg.h"
#include "boards.h"
#include "utility.h"
#include "app_debug.h"
#include "LSM6DS3.h"

#define I2C_MASTER_DMA_TIMEOUT_US (2000)



/* ???????? */
static void i2c_example_clk_and_gpio_init(void);
static void i2c_example_master_init(void);
static EN_ERR_STA_T i2c_example_master_dma_init(void);
static void i2c_example_master_block(void);
static void i2c_example_master_dma(void);
static void i2c_example_slave_init(void);
static EN_ERR_STA_T i2c_example_slave_dma_init(void);
static void i2c_example_slave_block(void);
static void i2c_example_slave_dma(void);
static void i2c_example_irq_handler(void);
static EN_ERR_STA_T i2c_example_slave_read_by_dma(stI2C_Handle_t *pstI2C, stDMA_Handle_t *pstDMA, uint8_t *pu8RxBuf, uint16_t u16Len);
static EN_ERR_STA_T i2c_example_slave_write_by_dma(stI2C_Handle_t *pstI2C, stDMA_Handle_t *pstDMA, uint8_t *pu8TxBuf, uint16_t u16Len);
static EN_I2C_MASTER_STAT_T i2c_example_master_read_by_dma(stI2C_Handle_t *pstI2C, stDMA_Handle_t *pstDMA, uint8_t *pu8RxBuf, uint16_t u16Len, uint8_t u8SendStop);
static EN_I2C_MASTER_STAT_T i2c_example_master_write_by_dma(stI2C_Handle_t *pstI2C, stDMA_Handle_t *pstDMA, uint8_t *pu8TxBuf, uint16_t u16Len, uint8_t u8SendStop);

/**
 * @brief  System power manage.
 */
void system_power_init(void)
{
    rom_hw_pmu_set_ldo_act_voltage(EN_LDO_ACT_1200mV);
    rom_hw_pmu_set_ldo_dig_voltage(EN_LDO_DIG_1100mV);
    rom_hw_pmu_set_ldo_ret_sleep_voltage(EN_LDO_RET_1100mV);

    // Power selection
    rom_hal_pmu_sel_power_act_out_mode(PWR_SEL_LDO);
}

/**
 * @brief  System clock init.
 */
void system_clock_init(EN_SYS_CLK_SRC_SEL_T enSysClkSrc)
{
    uint8_t u8Tune = 0;

    /* Set rc_hclk tune value */
    rom_hw_efuse_read_bytes(EFUSE_RC_HCLK_TUNE_ADDR, &u8Tune, sizeof(u8Tune));
    if (0 == u8Tune)
    {
        rom_hw_pmu_set_rc_hclk_tune(RC_HCLK_TUNE_DEFAUT_VAL);
    }

    /* Set rc32k tune value */
    rom_hw_efuse_read_bytes(EFUSE_RC_LCLK_TUNE_ADDR, &u8Tune, sizeof(u8Tune));
    if (u8Tune)
    {
        rom_hw_pmu_set_rc_lclk_tune(u8Tune);
    }
    else
    {
        rom_hw_pmu_set_rc_lclk_tune(RC_LCLK_TUNE_DEFAUT_VAL);
    }

    /* System clock */
    rom_hw_pmu_sel_dcxo_hclk_pwr(EN_DCXO_HCLK_PWR_VDDR);
    rom_hal_pmu_cfg_dcxo_hclk_param(DCXO_HCLK_IB_3, DCXO_HCLK_NGM_3, DCXO_HCLK_CAP_10PF);
    rom_hal_pmu_set_sys_clk_src(enSysClkSrc, DCXO_HCLK_STABLE_TIME_2500US);
}

/**
 * @brief  All peripheral init.
 */
void peripheral_init(void)
{
    /* Disable MP all Peripheral interrupt. */
    rom_hw_sys_ctrl_peri_int_ctrl(SYS_CTRL_MP, 0, 0);

#if APP_DEBUG_ENABLED
    app_debug_init(GPIO_PORT_APP_DEBUG_TX, GPIO_PIN_APP_DEBUG_TX, UART_HANDLE_APP_DEBUG, UART_BPS_APP_DEBUG, NULL);
    //PRINTF("[%s T %s]I2C example code start to work.\n", __DATE__, __TIME__);
#endif
}

static EN_ERR_STA_T i2c_example_slave_read_by_dma(stI2C_Handle_t *pstI2C, stDMA_Handle_t *pstDMA, uint8_t *pu8RxBuf, uint16_t u16Len)
{
    uint32_t u32DmaCfg;
    EN_ERR_STA_T enRet;
    
    if (NULL == pstI2C || NULL == pstDMA || NULL == pu8RxBuf || 0 == u16Len)
        return ERR_PARA_ERR;
    
    pstDMA->DMA_SRC_ADDR = (uint32_t)&pstI2C->I2C_RX_FIFO;
    pstDMA->DMA_DST_ADDR = (uint32_t)pu8RxBuf;
    
    u32DmaCfg = pstDMA->DMA_CFG;
    u32DmaCfg &= ~(DMA_LENGTH_VAL_MSK << DMA_LENGTH_VAL_SHIFT);
    u32DmaCfg |= (u16Len & DMA_LENGTH_VAL_MSK) << 0;
    pstDMA->DMA_CFG = u32DmaCfg;

    enRet = rom_hw_i2c_set_rxfifo_thld(pstI2C, 1);
    ERR_RETURN_IF_ERROR(enRet);
    
    enRet = rom_hw_dma_clear_interrupt_flag(pstDMA, DMA_INT_MSK);
    ERR_RETURN_IF_ERROR(enRet);
    
    enRet = rom_hw_dma_enable_interrupt(pstDMA, DMA_INT_4_4_DONE);
    ERR_RETURN_IF_ERROR(enRet);
    
    enRet = rom_hw_dma_enable(pstDMA);
    ERR_RETURN_IF_ERROR(enRet);
    
    return ERR_STA_OK;
}

static EN_ERR_STA_T i2c_example_slave_write_by_dma(stI2C_Handle_t *pstI2C, stDMA_Handle_t *pstDMA, uint8_t *pu8TxBuf, uint16_t u16Len)
{
    uint32_t u32DmaCfg;
    EN_ERR_STA_T enRet;
    
    if (NULL == pstI2C || NULL == pstDMA || NULL == pu8TxBuf || 0 == u16Len)
        return ERR_PARA_ERR;
    
    pstDMA->DMA_SRC_ADDR = (uint32_t)pu8TxBuf;
    pstDMA->DMA_DST_ADDR = (uint32_t)&pstI2C->I2C_TX_FIFO;
    
    u32DmaCfg = pstDMA->DMA_CFG;
    u32DmaCfg &= ~(DMA_LENGTH_VAL_MSK << DMA_LENGTH_VAL_SHIFT);
    u32DmaCfg |= (u16Len & DMA_LENGTH_VAL_MSK) << 0;
    pstDMA->DMA_CFG = u32DmaCfg;
    
    enRet = rom_hw_dma_clear_interrupt_flag(pstDMA, DMA_INT_MSK);
    ERR_RETURN_IF_ERROR(enRet);
    
    enRet = rom_hw_dma_enable_interrupt(pstDMA, DMA_INT_4_4_DONE);
    ERR_RETURN_IF_ERROR(enRet);
    
    enRet = rom_hw_dma_set_interval_tx_index(pstDMA, 0);
    ERR_RETURN_IF_ERROR(enRet);
    
    enRet = rom_hw_dma_enable(pstDMA);
    ERR_RETURN_IF_ERROR(enRet);
    
    return ERR_STA_OK;
}

static void i2c_example_irq_handler(void)
{
    uint16_t u16IntFlag;
    uint16_t u16RecvCnt = 0;
    
    rom_hw_i2c_get_interrupt_flag(I2C_HANDLE, &u16IntFlag);

    if (u16IntFlag & I2C_INT_RXFIFO_NOT_EMPTY)
    {
        while(I2C_HANDLE->I2C_RXFIFO_CNT && u16RecvCnt < I2C_BUF_SIZE)
        {
            gpu8SlaveRecvData[u16RecvCnt++] = I2C_HANDLE->I2C_RX_FIFO;
        }
        if (u16RecvCnt)
        {
            for (int i = 0; i < u16RecvCnt; i++)
            {
                PRINTF("%02X ", gpu8SlaveRecvData[i]);
            }
            u16RecvCnt = 0;
        }
    }
    rom_hw_i2c_clear_interrupt_flag(I2C_HANDLE, u16IntFlag);
}

void I2C0_IRQ_Handler(void) { i2c_example_irq_handler(); }
void I2C1_IRQ_Handler(void) { i2c_example_irq_handler(); }
void I2C2_IRQ_Handler(void) { i2c_example_irq_handler(); }

void DMA_IRQ6_Handler(void)
{
    uint8_t u8IntFlag;
    uint16_t u16RxCnt;
    rom_hw_dma_get_interrupt_flag(I2C_RX_DMA_HANDLE, &u8IntFlag);
    rom_hw_dma_clear_interrupt_flag(I2C_RX_DMA_HANDLE, u8IntFlag);
    
    if (u8IntFlag & DMA_INT_4_4_DONE)
    {
        rom_hw_dma_get_trx_pointer(I2C_RX_DMA_HANDLE, &u16RxCnt);
        rom_hw_dma_disable(I2C_RX_DMA_HANDLE);
        PRINTF("rx done\n");
        for(int i = 0; i < u16RxCnt; i++)
        {
            PRINTF("%02X ", gpu8SlaveRecvData[i]);
        }
        PRINTF("\n");
        i2c_example_slave_read_by_dma(I2C_HANDLE, I2C_RX_DMA_HANDLE, gpu8SlaveRecvData, sizeof(gpu8SlaveRecvData));
    }
    
    u8IntFlag = 0;
    rom_hw_dma_get_interrupt_flag(I2C_TX_DMA_HANDLE, &u8IntFlag);
    rom_hw_dma_clear_interrupt_flag(I2C_TX_DMA_HANDLE, u8IntFlag);
    
    if (u8IntFlag & DMA_INT_4_4_DONE)
    {
        rom_hw_dma_disable(I2C_TX_DMA_HANDLE);
        PRINTF("tx done\n");
        i2c_example_slave_write_by_dma(I2C_HANDLE, I2C_TX_DMA_HANDLE, gpu8SlaveSendData, sizeof(gpu8SlaveSendData));
    }
}

static void i2c_example_clk_and_gpio_init(void)
{
    EN_GPIO_PID_T enSclkPid;
    EN_GPIO_PID_T enSdaPid;
    EN_CRG_CLK_GATE_T enClkGate;
    
    if (I2C0 == I2C_HANDLE)
    {
        enClkGate = CRG_I2C0_CLK_GATE;
        enSclkPid = PID_I2C0_SCL;
        enSdaPid = PID_I2C0_SDA;
    }
    else if (I2C1 == I2C_HANDLE)
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
		
    rom_hw_gpio_set_pin_pid(GPIO_PORT_I2C_SCLK, GPIO_PIN_10, PID_GPIO_PIN);
    rom_hw_gpio_set_pin_input_output(GPIO_PORT_I2C_SCLK, GPIO_PIN_10, GPIO_MODE_OUTPUT);
    rom_hw_gpio_set_pin_drive_strength(GPIO_PORT_I2C_SCLK, GPIO_PIN_10, GPIO_DRV_STRENGTH_LEVEL1);
    rom_hw_gpio_set_pin_output_level(GPIO_PORT_I2C_SCLK, GPIO_PIN_10, GPIO_LEVEL_HI);
}

static void i2c_example_master_init(void)
{
    i2c_example_clk_and_gpio_init();
    
    stI2cMasterInit_t stInit;
    stInit.u32BaudRate = I2C_BAUDRATE_100K;
    stInit.u16SlaveAddr = 0x6A;
    stInit.unCfg.stCfg.u8AddrMode = I2C_ADDR_MODE_7_BITS;
    stInit.unCfg.stCfg.u8StretchEn = I2C_STRETCH_ENABLE;
    stInit.unCfg.stCfg.u8TrxMode = I2C_MASTER_MODE_READ;
    stInit.unCfg.stCfg.u8Enable = I2C_ENABLE;
    
    rom_hw_i2c_master_init(I2C_HANDLE, &stInit);
    
    for (int i = 0; i < I2C_BUF_SIZE; i++)
    {
        gpu8MasterSendData[i] = i;
    }
}

static EN_ERR_STA_T i2c_example_master_dma_init(void)
{
    EN_ERR_STA_T enRet;
    EN_DMA_PERI_SEL_T enRxPeriID;
    EN_DMA_PERI_SEL_T enTxPeriID;

    if (I2C0 == I2C_HANDLE)
    {
        enRxPeriID = DMA_PERI_I2C0_RX;
        enTxPeriID = DMA_PERI_I2C0_TX;
    }
    else if (I2C1 == I2C_HANDLE)
    {
        enRxPeriID = DMA_PERI_I2C1_RX;
        enTxPeriID = DMA_PERI_I2C1_TX;
    }
    else
    {
        enRxPeriID = DMA_PERI_I2C2_RX;
        enTxPeriID = DMA_PERI_I2C2_TX;
    }

    enRet = rom_hw_crg_enable_clk_gate(CRG_DMA_CLK_GATE);
    ERR_RETURN_IF_ERROR(enRet);

    stDmaInit_t stDmaInit;
    stDmaInit.unPeriSel.stPeriSel.enPeriID = enRxPeriID;
    stDmaInit.u32TimeOut = 200;
    stDmaInit.u32SrcAddr = (uint32_t)&I2C_HANDLE->I2C_RX_FIFO;
    stDmaInit.u32DstAddr = (uint32_t)gpu8MasterRecvData;
    stDmaInit.unCfg.stDmaCfg.u16Length = I2C_BUF_SIZE;
    stDmaInit.unCfg.stDmaCfg.u8CircEn = DMA_NORM;
    stDmaInit.unCfg.stDmaCfg.u8Priority = DMA_PRIO_LEVEL_LOW;
    stDmaInit.unCfg.stDmaCfg.u8WorkMode = DMA_PERI_TO_MEM;
    stDmaInit.unCfg.stDmaCfg.u8DstSize = DMA_DATA_1BYTE;
    stDmaInit.unCfg.stDmaCfg.u8DstIncEN = DMA_ADDR_INC_ENABLE;
    stDmaInit.unCfg.stDmaCfg.u8SrcSize = DMA_DATA_1BYTE;
    stDmaInit.unCfg.stDmaCfg.u8SrcIncEN = DMA_ADDR_INC_DISABLE;
    stDmaInit.unCfg.stDmaCfg.u8StopCfg = 0;
    stDmaInit.unCfg.stDmaCfg.u8PauseEn = 0;
    stDmaInit.unCfg.stDmaCfg.u8Enable = DMA_DISABLE;
    enRet = rom_hw_dma_init(I2C_RX_DMA_HANDLE, &stDmaInit);
    ERR_RETURN_IF_ERROR(enRet);

    stDmaInit.unPeriSel.stPeriSel.enPeriID = enTxPeriID;
    stDmaInit.u32TimeOut = 200;
    stDmaInit.u32SrcAddr = (uint32_t)gpu8MasterSendData;
    stDmaInit.u32DstAddr = (uint32_t)&I2C_HANDLE->I2C_TX_FIFO;
    stDmaInit.unCfg.stDmaCfg.u16Length = I2C_BUF_SIZE;
    stDmaInit.unCfg.stDmaCfg.u8CircEn = DMA_NORM;
    stDmaInit.unCfg.stDmaCfg.u8Priority = DMA_PRIO_LEVEL_LOW;
    stDmaInit.unCfg.stDmaCfg.u8WorkMode = DMA_MEM_TO_PERI;
    stDmaInit.unCfg.stDmaCfg.u8DstSize = DMA_DATA_1BYTE;
    stDmaInit.unCfg.stDmaCfg.u8DstIncEN = DMA_ADDR_INC_DISABLE;
    stDmaInit.unCfg.stDmaCfg.u8SrcSize = DMA_DATA_1BYTE;
    stDmaInit.unCfg.stDmaCfg.u8SrcIncEN = DMA_ADDR_INC_ENABLE;
    stDmaInit.unCfg.stDmaCfg.u8StopCfg = 0;
    stDmaInit.unCfg.stDmaCfg.u8PauseEn = 0;
    stDmaInit.unCfg.stDmaCfg.u8Enable = DMA_DISABLE;
    enRet = rom_hw_dma_init(I2C_TX_DMA_HANDLE, &stDmaInit);
    ERR_RETURN_IF_ERROR(enRet);

    return ERR_STA_OK;
}

static EN_I2C_MASTER_STAT_T i2c_example_master_read_by_dma(stI2C_Handle_t *pstI2C, stDMA_Handle_t *pstDMA, uint8_t *pu8RxBuf, uint16_t u16Len, uint8_t u8SendStop)
{
    uint8_t u8DmaIntFlag;
    uint8_t u8CurLen;
    uint8_t u8NextLen;
    uint16_t u16RcvLen;
    uint32_t u32Timeout;
    uint32_t u32DmaCfg;

    if (!(IS_VALID_I2C_HANDLE(pstI2C)) || (NULL == pstDMA) || (0 == u16Len) || (NULL == pu8RxBuf))
    {
        return EN_I2C_MASTER_STAT_PARA_ERR;
    }

    rom_hw_i2c_set_mode(pstI2C, I2C_MODE_MASTER);
    rom_hw_i2c_master_set_trx_mode(pstI2C, I2C_MASTER_MODE_READ);
    rom_hw_i2c_master_enable_stretch(pstI2C);

    pstI2C->I2C_MASTER_CMD = I2C_MASTER_CMD_CLR_STATE_MSK << I2C_MASTER_CMD_CLR_STATE_SHIFT;
    pstI2C->I2C_INT_CLR = I2C_INT_MASK;
    pstI2C->I2C_TXFIFO_CLR = I2C_CLR_TXFIFO_MSK << I2C_CLR_TXFIFO_SHIFT;
    pstI2C->I2C_RXFIFO_CLR = I2C_CLR_RXFIFO_MSK << I2C_CLR_RXFIFO_SHIFT;

    u16RcvLen = 0;
    u8CurLen = (u16Len > I2C_RX_FIFO_MAX) ? I2C_RX_FIFO_MAX : u16Len;
    rom_hw_i2c_master_set_rxfifo_full_value(pstI2C, u8CurLen);
    rom_hw_i2c_set_rxfifo_thld(pstI2C, 1);

    pstI2C->I2C_MASTER_CMD = I2C_MASTER_CMD_START_MSK << I2C_MASTER_CMD_START_SHIFT;
    u32Timeout = 0;
    while (((pstI2C->I2C_MASTER_STATUS & 0x1F) != MST_RCV_DATA) &&
           ((pstI2C->I2C_MASTER_STATUS & 0x1F) != MST_SEND_DATA_ACK) &&
           ((pstI2C->I2C_MASTER_STATUS & 0x1F) != MST_FULL_STRETCH))
    {
        if ((pstI2C->I2C_MASTER_STATUS & 0x1F) == MST_NACK_STRETCH)
        {
            return EN_I2C_MASTER_STAT_NACK_ON_TRANSMIT_ADDR;
        }
        if (++u32Timeout >= I2C_MASTER_DMA_TIMEOUT_US)
        {
            return EN_I2C_MASTER_STAT_TIMEOUT;
        }
        rom_delay_us(1);
    }

    while (u16RcvLen < u16Len)
    {
        u32Timeout = 0;
        while ((pstI2C->I2C_MASTER_STATUS & 0x1F) != MST_FULL_STRETCH)
        {
            if (++u32Timeout >= I2C_MASTER_DMA_TIMEOUT_US)
            {
                pstI2C->I2C_MASTER_CMD = I2C_MASTER_CMD_NACK_MSK << I2C_MASTER_CMD_NACK_SHIFT;
                pstI2C->I2C_MASTER_CMD = I2C_MASTER_CMD_STOP_MSK << I2C_MASTER_CMD_STOP_SHIFT;
                return EN_I2C_MASTER_STAT_TIMEOUT;
            }
            rom_delay_us(1);
        }

        if ((u16Len - u16RcvLen) > u8CurLen)
        {
            u8NextLen = ((u16Len - u16RcvLen - u8CurLen) > I2C_RX_FIFO_MAX) ? I2C_RX_FIFO_MAX : (u16Len - u16RcvLen - u8CurLen);
        }
        else
        {
            u8NextLen = 0;
        }
        rom_hw_i2c_master_set_rxfifo_full_value(pstI2C, u8NextLen);

        pstDMA->DMA_SRC_ADDR = (uint32_t)&pstI2C->I2C_RX_FIFO;
        pstDMA->DMA_DST_ADDR = (uint32_t)(pu8RxBuf + u16RcvLen);
        u32DmaCfg = pstDMA->DMA_CFG;
        u32DmaCfg &= ~(DMA_LENGTH_VAL_MSK << DMA_LENGTH_VAL_SHIFT);
        u32DmaCfg |= (u8CurLen & DMA_LENGTH_VAL_MSK) << DMA_LENGTH_VAL_SHIFT;
        pstDMA->DMA_CFG = u32DmaCfg;

        rom_hw_dma_clear_interrupt_flag(pstDMA, DMA_INT_MSK);
        rom_hw_dma_enable_interrupt(pstDMA, DMA_INT_4_4_DONE);
        rom_hw_dma_enable(pstDMA);

        u32Timeout = 0;
        while (1)
        {
            u8DmaIntFlag = 0;
            rom_hw_dma_get_interrupt_flag(pstDMA, &u8DmaIntFlag);
            if (u8DmaIntFlag & DMA_INT_4_4_DONE)
            {
                break;
            }
            if (++u32Timeout >= I2C_MASTER_DMA_TIMEOUT_US)
            {
                rom_hw_dma_disable(pstDMA);
                pstI2C->I2C_MASTER_CMD = I2C_MASTER_CMD_NACK_MSK << I2C_MASTER_CMD_NACK_SHIFT;
                pstI2C->I2C_MASTER_CMD = I2C_MASTER_CMD_STOP_MSK << I2C_MASTER_CMD_STOP_SHIFT;
                return EN_I2C_MASTER_STAT_TIMEOUT;
            }
            rom_delay_us(1);
        }

        rom_hw_dma_clear_interrupt_flag(pstDMA, DMA_INT_MSK);
        rom_hw_dma_disable(pstDMA);

        u16RcvLen += u8CurLen;
        u8CurLen = u8NextLen;

        rom_delay_us(5);
    }

    pstI2C->I2C_MASTER_CMD = I2C_MASTER_CMD_NACK_MSK << I2C_MASTER_CMD_NACK_SHIFT;
    u32Timeout = 0;
    while ((pstI2C->I2C_MASTER_STATUS & 0x1F) != MST_NACK_STRETCH)
    {
        if (++u32Timeout >= I2C_MASTER_DMA_TIMEOUT_US)
        {
            return EN_I2C_MASTER_STAT_TIMEOUT;
        }
        rom_delay_us(1);
    }

    if (u8SendStop)
    {
        pstI2C->I2C_MASTER_CMD = I2C_MASTER_CMD_STOP_MSK << I2C_MASTER_CMD_STOP_SHIFT;
        u32Timeout = 0;
        while ((pstI2C->I2C_MASTER_STATUS & 0x1F) != MST_IDLE)
        {
            if (++u32Timeout >= I2C_MASTER_DMA_TIMEOUT_US)
            {
                return EN_I2C_MASTER_STAT_TIMEOUT;
            }
            rom_delay_us(1);
        }
    }

    rom_hw_i2c_clear_interrupt_flag(pstI2C, I2C_INT_MASK);
    return EN_I2C_MASTER_STAT_OK;
}

static EN_I2C_MASTER_STAT_T i2c_example_master_write_by_dma(stI2C_Handle_t *pstI2C, stDMA_Handle_t *pstDMA, uint8_t *pu8TxBuf, uint16_t u16Len, uint8_t u8SendStop)
{
    uint8_t u8DmaIntFlag;
    uint32_t u32Timeout;
    uint32_t u32DmaCfg;

    if (!(IS_VALID_I2C_HANDLE(pstI2C)) || (NULL == pstDMA) || (0 == u16Len) || (NULL == pu8TxBuf))
    {
        return EN_I2C_MASTER_STAT_PARA_ERR;
    }

    rom_hw_i2c_set_mode(pstI2C, I2C_MODE_MASTER);
    rom_hw_i2c_master_set_trx_mode(pstI2C, I2C_MASTER_MODE_WRITE);
    rom_hw_i2c_master_enable_stretch(pstI2C);

    pstI2C->I2C_MASTER_CMD = I2C_MASTER_CMD_CLR_STATE_MSK << I2C_MASTER_CMD_CLR_STATE_SHIFT;
    pstI2C->I2C_INT_CLR = I2C_INT_MASK;
    pstI2C->I2C_TXFIFO_CLR = I2C_CLR_TXFIFO_MSK << I2C_CLR_TXFIFO_SHIFT;
    pstI2C->I2C_RXFIFO_CLR = I2C_CLR_RXFIFO_MSK << I2C_CLR_RXFIFO_SHIFT;

    pstDMA->DMA_SRC_ADDR = (uint32_t)pu8TxBuf;
    pstDMA->DMA_DST_ADDR = (uint32_t)&pstI2C->I2C_TX_FIFO;
    u32DmaCfg = pstDMA->DMA_CFG;
    u32DmaCfg &= ~(DMA_LENGTH_VAL_MSK << DMA_LENGTH_VAL_SHIFT);
    u32DmaCfg |= (u16Len & DMA_LENGTH_VAL_MSK) << DMA_LENGTH_VAL_SHIFT;
    pstDMA->DMA_CFG = u32DmaCfg;

    rom_hw_dma_clear_interrupt_flag(pstDMA, DMA_INT_MSK);
    rom_hw_dma_enable_interrupt(pstDMA, DMA_INT_4_4_DONE);
    rom_hw_dma_enable(pstDMA);

    pstI2C->I2C_MASTER_CMD = I2C_MASTER_CMD_START_MSK << I2C_MASTER_CMD_START_SHIFT;
    u32Timeout = 0;
    while (((pstI2C->I2C_MASTER_STATUS & 0x1F) != MST_SNED_DATA) &&
           ((pstI2C->I2C_MASTER_STATUS & 0x1F) != MST_EMPTY_STRETCH) &&
           ((pstI2C->I2C_MASTER_STATUS & 0x1F) != MST_RCV_DATA_ACK))
    {
        if ((pstI2C->I2C_MASTER_STATUS & 0x1F) == MST_NACK_STRETCH)
        {
            rom_hw_dma_disable(pstDMA);
            return EN_I2C_MASTER_STAT_NACK_ON_TRANSMIT_ADDR;
        }
        if (++u32Timeout >= I2C_MASTER_DMA_TIMEOUT_US)
        {
            rom_hw_dma_disable(pstDMA);
            return EN_I2C_MASTER_STAT_TIMEOUT;
        }
        rom_delay_us(1);
    }

    u32Timeout = 0;
    while (1)
    {
        u8DmaIntFlag = 0;
        rom_hw_dma_get_interrupt_flag(pstDMA, &u8DmaIntFlag);
        if (u8DmaIntFlag & DMA_INT_4_4_DONE)
        {
            break;
        }
        if (++u32Timeout >= I2C_MASTER_DMA_TIMEOUT_US)
        {
            rom_hw_dma_disable(pstDMA);
            return EN_I2C_MASTER_STAT_TIMEOUT;
        }
        rom_delay_us(1);
    }
    rom_hw_dma_clear_interrupt_flag(pstDMA, DMA_INT_MSK);
    rom_hw_dma_disable(pstDMA);

    u32Timeout = 0;
    while (((pstI2C->I2C_MASTER_STATUS & 0x1F) != MST_EMPTY_STRETCH) &&
           ((pstI2C->I2C_MASTER_STATUS & 0x1F) != MST_NACK_STRETCH))
    {
        if (++u32Timeout >= I2C_MASTER_DMA_TIMEOUT_US)
        {
            return EN_I2C_MASTER_STAT_TIMEOUT;
        }
        rom_delay_us(1);
    }

    if ((pstI2C->I2C_MASTER_STATUS & 0x1F) == MST_NACK_STRETCH)
    {
        return EN_I2C_MASTER_STAT_NACK_ON_TRANSMIT_DATA;
    }

    if (u8SendStop)
    {
        pstI2C->I2C_MASTER_CMD = I2C_MASTER_CMD_STOP_MSK << I2C_MASTER_CMD_STOP_SHIFT;
        u32Timeout = 0;
        while ((pstI2C->I2C_MASTER_STATUS & 0x1F) != MST_IDLE)
        {
            if (++u32Timeout >= I2C_MASTER_DMA_TIMEOUT_US)
            {
                return EN_I2C_MASTER_STAT_TIMEOUT;
            }
            rom_delay_us(1);
        }
    }

    rom_hw_i2c_clear_interrupt_flag(pstI2C, I2C_INT_MASK);
    return EN_I2C_MASTER_STAT_OK;
}

static void i2c_example_master_block(void)
{
    EN_ERR_STA_T enRet;
    EN_I2C_MASTER_STAT_T enMasterSta;
    
    i2c_example_master_init();
    
    while(1)
    {
        rom_delay_ms(10);
        gpu8MasterSendData[0] = 0x0F;
			
        enMasterSta = patch_hw_i2c_master_write(I2C_HANDLE, gpu8MasterSendData, 1, 1);
        if (EN_I2C_MASTER_STAT_OK != enMasterSta)
        {
            PRINTF("Master Write Failed : %d\n", enMasterSta);
            continue;
        }
        
        enMasterSta = patch_hw_i2c_master_read(I2C_HANDLE, gpu8MasterRecvData, 3, 0);
        if (ERR_STA_OK != enMasterSta)
        {
            PRINTF("Master Read Failed : %d\n", enMasterSta);
            continue;
        }

        enRet = patch_hw_i2c_master_send_stop(I2C_HANDLE);
        if (ERR_STA_OK != enRet)
        {
            PRINTF("Master Send Stop Failed : %d\n", enRet);
            continue;
        }
        
        PRINTF("Master Read : ");
        for (int i = 0; i < sizeof(gpu8MasterRecvData); i++)
            PRINTF("0x%02X ", gpu8MasterRecvData[i]);
        PRINTF("\r\n");
        
        rom_delay_ms(10);
    }
}

/* This standalone capture target does not use an RTOS/SysTick interrupt.
 * Poll a free-running 24-bit core timer; call more often than one wrap
 * (~1.05 s at 16 MHz). Both the capture loop and error backoff meet this.
 * Timestamps mark host-register read starts, not hardware ADC trigger edges.
 */
static uint32_t capture_last_cycles;
static uint32_t capture_fraction_cycles;
static uint32_t capture_cycles_per_us;
static uint32_t capture_elapsed_us;

static int capture_clock_init(void)
{
    uint32_t hz = SystemCoreGetClock();
    if (hz < 1000000U || (hz % 1000000U) != 0U) return -1;
    capture_cycles_per_us = hz / 1000000U;
    capture_fraction_cycles = 0;
    capture_elapsed_us = 0;
    SysTick->CTRL = 0;
    SysTick->LOAD = 0x00FFFFFFU;
    SysTick->VAL = 0;
    SysTick->CTRL = SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_ENABLE_Msk;
    __DSB();
    __ISB();
    capture_last_cycles = SysTick->VAL;
    return 0;
}

static uint32_t capture_now_us(void)
{
    uint32_t current = SysTick->VAL;
    uint32_t cycles = ((capture_last_cycles - current) & 0x00FFFFFFU)
                    + capture_fraction_cycles;
    capture_last_cycles = current;
    capture_elapsed_us += cycles / capture_cycles_per_us;
    capture_fraction_cycles = cycles % capture_cycles_per_us;
    return capture_elapsed_us; /* Natural uint32 wrap; collector unwraps it. */
}

/* Report completed transmissions, not the configured sensor ODR. */
static uint32_t capture_fps_x10(uint32_t samples, uint32_t elapsed_us)
{
    if (elapsed_us == 0U) return 0U;
    return (uint32_t)(((uint64_t)samples * 10000000ULL + elapsed_us / 2U)
                      / elapsed_us);
}

static void i2c_example_master_dma(void)
{
    EN_ERR_STA_T enRet;
    EN_I2C_MASTER_STAT_T enMasterSta;

    i2c_example_master_init();
    
    rom_delay_ms(50);

    enRet = i2c_example_master_dma_init();
    if (ERR_STA_OK != enRet)
    {
        PRINTF("Master DMA Init Failed : %d\n", enRet);
        return;
    }


    lsm6ds3_init();
    if (!lsm6ds3_is_ready()) return;
    PRINTF("#FW,PINPON_C_FAST104_V2,%s,%s\r\n", __DATE__, __TIME__);
    PRINTF("#STREAM,104Hz,115200baud,IMU1,recording-only\r\n");
    if (capture_clock_init() != 0) {
        PRINTF("Capture clock init failed.\r\n");
        return;
    }

    int16_t gyro_x, gyro_y, gyro_z;
    int16_t accel_x, accel_y, accel_z;
#if LSM6DS3_EI_DEBUG_EVERY_N > 0
    int16_t raw[6];
    float ei_input[6];
#endif
    uint32_t sequence = 0;
    uint32_t last_sample_us = 0;
    uint32_t rate_since_us = capture_now_us();
    uint32_t sent_window = 0;
    uint32_t error_window = 0;

    while (1)
    {
        uint32_t timestamp_us = capture_now_us();
        uint32_t rate_elapsed_us = (uint32_t)(timestamp_us - rate_since_us);
        if (rate_elapsed_us >= 1000000U) {
            uint32_t fps_x10 = capture_fps_x10(sent_window, rate_elapsed_us);
            /* One short status line per second. The recorder keeps it in TXT,
             * but does not count it as a six-axis sample in CSV.
             */
            PRINTF("#RATE,%lu.%lu fps,err=%lu\r\n",
                (unsigned long)(fps_x10 / 10U),
                (unsigned long)(fps_x10 % 10U), (unsigned long)error_window);
            rate_since_us = timestamp_us;
            sent_window = 0;
            error_window = 0;
        }
        int ready = lsm6ds3_data_ready();
        if (ready < 0) {
            patch_hw_i2c_master_send_stop(I2C_HANDLE);
            if (++error_window == 1U) PRINTF("IMU data-ready read failed.\r\n");
            rom_delay_ms(5);
            continue;
        }
        if (ready == 0) {
            if ((uint32_t)(timestamp_us - last_sample_us) >= 1000000U) {
                PRINTF("IMU waiting for fresh accel/gyro data.\r\n");
                last_sample_us = timestamp_us;
            }
            rom_delay_us(50);
            continue;
        }

        timestamp_us = capture_now_us();
        last_sample_us = timestamp_us;
        uint32_t sample_sequence = sequence++;
        gpu8MasterSendData[0] = LSM6DS3_OUTX_L_G;

        enMasterSta = i2c_example_master_write_by_dma(I2C_HANDLE, I2C_TX_DMA_HANDLE, gpu8MasterSendData, 1, 0);
        
        if (EN_I2C_MASTER_STAT_OK != enMasterSta)
        {
            if (++error_window == 1U) PRINTF("DMA Write Failed : %d\n", enMasterSta);
            patch_hw_i2c_master_send_stop(I2C_HANDLE);
            rom_delay_ms(5);
            continue;
        }

        rom_delay_us(50);


        enMasterSta = i2c_example_master_read_by_dma(I2C_HANDLE, I2C_RX_DMA_HANDLE, gpu8MasterRecvData, 12, 0);
        
        if (EN_I2C_MASTER_STAT_OK != enMasterSta)
        {
            if (++error_window == 1U) PRINTF("DMA Read Failed : %d\n", enMasterSta);
            patch_hw_i2c_master_send_stop(I2C_HANDLE);
            rom_delay_ms(5);
            continue;
        }

        enRet = patch_hw_i2c_master_send_stop(I2C_HANDLE);
        if (ERR_STA_OK != enRet) {
            if (++error_window == 1U) PRINTF("DMA Stop Failed : %d\n", enRet);
            rom_delay_ms(5);
            continue;
        }
        
        /* Burst from 0x22: Gx_L,H; Gy_L,H; Gz_L,H; Ax_L,H; Ay_L,H; Az_L,H. */
        gyro_x = (int16_t)((gpu8MasterRecvData[1] << 8) | gpu8MasterRecvData[0]);
        gyro_y = (int16_t)((gpu8MasterRecvData[3] << 8) | gpu8MasterRecvData[2]);
        gyro_z = (int16_t)((gpu8MasterRecvData[5] << 8) | gpu8MasterRecvData[4]);

        accel_x = (int16_t)((gpu8MasterRecvData[7] << 8) | gpu8MasterRecvData[6]);
        accel_y = (int16_t)((gpu8MasterRecvData[9] << 8) | gpu8MasterRecvData[8]);
        accel_z = (int16_t)((gpu8MasterRecvData[11] << 8) | gpu8MasterRecvData[10]);

        /* Compact versioned frame: no floating-point printf on the MCU.
         * IMU1 fixes FS at +/-16 g and +/-2000 dps, raw Axyz then Gxyz.
         * The recorder applies 0.000488 g/LSB and 0.070 dps/LSB.
         * At 115200 8N1 even the longest frame uses <7 ms of a ~9.615 ms slot.
         */
        PRINTF("IMU1,%lu,%lu,%d,%d,%d,%d,%d,%d\r\n",
            (unsigned long)sample_sequence, (unsigned long)timestamp_us,
            (int)accel_x, (int)accel_y, (int)accel_z,
            (int)gyro_x, (int)gyro_y, (int)gyro_z);
        ++sent_window;

#if LSM6DS3_EI_DEBUG_EVERY_N > 0
        /* Optional old-model count preview; logs can introduce capture gaps. */
        raw[0] = accel_x; raw[1] = accel_y; raw[2] = accel_z;
        raw[3] = gyro_x;  raw[4] = gyro_y;  raw[5] = gyro_z;
        lsm6ds3_raw_to_ei(raw, ei_input);
        lsm6ds3_debug_ei(raw, ei_input);
#endif
        /* No 100 ms throttle: next read is gated by XLDA and GDA at 104 Hz. */
    }
}

static void i2c_example_slave_init(void)
{
    i2c_example_clk_and_gpio_init();
    
    rom_hw_i2c_slave_set_addr_mode(I2C_HANDLE, I2C_ADDR_MODE_7_BITS);
    rom_hw_i2c_set_addr(I2C_HANDLE, 0x6A);
    rom_hw_i2c_slave_enable(I2C_HANDLE);
    
    for (int i = 0; i < I2C_BUF_SIZE; i++)
    {
        gpu8SlaveSendData[i] = i;
    }
}

static EN_ERR_STA_T i2c_example_slave_dma_init(void)
{
    EN_ERR_STA_T enRet;
    EN_DMA_PERI_SEL_T enRxPeriID;
    EN_DMA_PERI_SEL_T enTxPeriID;
    
    if (I2C0 == I2C_HANDLE)
    {
        enRxPeriID = DMA_PERI_I2C0_RX;
        enTxPeriID = DMA_PERI_I2C0_TX;
    }
    else if (I2C1 == I2C_HANDLE)
    {
        enRxPeriID = DMA_PERI_I2C1_RX;
        enTxPeriID = DMA_PERI_I2C1_TX;
    }
    else
    {
        enRxPeriID = DMA_PERI_I2C2_RX;
        enTxPeriID = DMA_PERI_I2C2_TX;
    }
    
    enRet = rom_hw_crg_enable_clk_gate(CRG_DMA_CLK_GATE);
    ERR_RETURN_IF_ERROR(enRet);
    
    stDmaInit_t stDmaInit;
    stDmaInit.unPeriSel.stPeriSel.enPeriID = enRxPeriID;
    stDmaInit.u32TimeOut = 200;
    stDmaInit.u32SrcAddr = (uint32_t)&I2C_HANDLE->I2C_RX_FIFO;
    stDmaInit.unCfg.stDmaCfg.u8CircEn = DMA_NORM;
    stDmaInit.unCfg.stDmaCfg.u8Priority = DMA_PRIO_LEVEL_LOW;
    stDmaInit.unCfg.stDmaCfg.u8WorkMode = DMA_PERI_TO_MEM;
    stDmaInit.unCfg.stDmaCfg.u8DstSize = DMA_DATA_1BYTE;
    stDmaInit.unCfg.stDmaCfg.u8DstIncEN = DMA_ADDR_INC_ENABLE;
    stDmaInit.unCfg.stDmaCfg.u8SrcSize = DMA_DATA_1BYTE;
    stDmaInit.unCfg.stDmaCfg.u8SrcIncEN = DMA_ADDR_INC_DISABLE;
    stDmaInit.unCfg.stDmaCfg.u8StopCfg = 0;
    stDmaInit.unCfg.stDmaCfg.u8PauseEn = 0;
    stDmaInit.unCfg.stDmaCfg.u8Enable = DMA_DISABLE;
    enRet = rom_hw_dma_init(I2C_RX_DMA_HANDLE, &stDmaInit);
    ERR_RETURN_IF_ERROR(enRet);

    enRet = rom_hw_sys_ctrl_enable_peri_int(SYS_CTRL_MP, DMA_IRQ6);
    ERR_RETURN_IF_ERROR(enRet);
    
    NVIC_ClearPendingIRQ(DMA_IRQ6);
    NVIC_SetPriority(DMA_IRQ6, 0x03);
    NVIC_EnableIRQ(DMA_IRQ6);
    
    enRet = rom_hw_dma_set_interrupt_channel(I2C_RX_DMA_HANDLE, DMA_INT6);
    ERR_RETURN_IF_ERROR(enRet);
    
    stDmaInit.unPeriSel.stPeriSel.enPeriID = enTxPeriID;
    stDmaInit.u32DstAddr = (uint32_t)&I2C_HANDLE->I2C_TX_FIFO;
    stDmaInit.unCfg.stDmaCfg.u8WorkMode = DMA_MEM_TO_PERI;
    stDmaInit.unCfg.stDmaCfg.u8SrcIncEN = DMA_ADDR_INC_ENABLE;
    stDmaInit.unCfg.stDmaCfg.u8DstIncEN = DMA_ADDR_INC_DISABLE;
   
    enRet = rom_hw_dma_init(I2C_TX_DMA_HANDLE, &stDmaInit);
    ERR_RETURN_IF_ERROR(enRet);
    
    enRet = rom_hw_dma_set_interrupt_channel(I2C_TX_DMA_HANDLE, DMA_INT6);
    ERR_RETURN_IF_ERROR(enRet);
    
    return ERR_STA_OK;
}

static void i2c_example_slave_block(void)
{
    i2c_example_slave_init();
    
    IRQn_Type enIrqType;
    if (I2C0 == I2C_HANDLE)
        enIrqType = I2C0_IRQ;
    else if (I2C1 == I2C_HANDLE)
        enIrqType = I2C1_IRQ;
    else
        enIrqType = I2C2_IRQ;
    
    rom_hw_sys_ctrl_enable_peri_int(SYS_CTRL_MP, enIrqType);
    rom_hw_i2c_enable_interrupt(I2C_HANDLE, I2C_INT_RXFIFO_NOT_EMPTY);
    NVIC_ClearPendingIRQ(enIrqType);
    NVIC_SetPriority(enIrqType, 0x3);
    NVIC_EnableIRQ(enIrqType);
    
    while(1)
    {
        patch_hw_i2c_slave_write(I2C_HANDLE, gpu8SlaveSendData, sizeof(gpu8SlaveSendData));
    }
}

static void i2c_example_slave_dma(void)
{
    i2c_example_slave_init();
    i2c_example_slave_dma_init();
    
    i2c_example_slave_read_by_dma(I2C_HANDLE, I2C_RX_DMA_HANDLE, gpu8SlaveRecvData, sizeof(gpu8SlaveRecvData));
    i2c_example_slave_write_by_dma(I2C_HANDLE, I2C_TX_DMA_HANDLE, gpu8SlaveSendData, sizeof(gpu8SlaveSendData));
    
    for(;;){}
}

/**
 * @brief  I2C module example code.
 */
void i2c_example(void)
{
    switch(EN_I2C_EXAMPLE_MASTER_DMA)
    {
        case EN_I2C_EXAMPLE_MASTER_BLOCK:
            i2c_example_master_block();
            break;
        case EN_I2C_EXAMPLE_MASTER_DMA:
            i2c_example_master_dma();
            break;
        case EN_I2C_EXAMPLE_SLAVE_BLOCK:
            i2c_example_slave_block();
            break;
        case EN_I2C_EXAMPLE_SLAVE_DMA:
            i2c_example_slave_dma();
            break;
        default:
            break;
    }
}

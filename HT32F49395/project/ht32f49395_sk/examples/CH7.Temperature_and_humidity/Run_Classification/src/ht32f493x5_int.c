#include "ht32f493x5_int.h"
#include "i2c_application.h"
#include "hs300x.h"

extern i2c_handle_type hi2cx;

volatile uint32_t g_hs3003_tick_ms = 0U;

#define I2Cx_DMA_TX_IRQHandler DMA1_Channel6_IRQHandler
#define I2Cx_DMA_RX_IRQHandler DMA1_Channel7_IRQHandler
#define I2Cx_EVT_IRQHandler    I2C1_EVT_IRQHandler
#define I2Cx_ERR_IRQHandler    I2C1_ERR_IRQHandler

void NMI_Handler(void) {}
void HardFault_Handler(void) { while(1) {} }
void MemManage_Handler(void) { while(1) {} }
void BusFault_Handler(void) { while(1) {} }
void UsageFault_Handler(void) { while(1) {} }
void SVC_Handler(void) {}
void DebugMon_Handler(void) {}
void PendSV_Handler(void) {}

void SysTick_Handler(void)
{
  g_hs3003_tick_ms++;
}

uint32_t SysTick_GetTick(void)
{
  return g_hs3003_tick_ms;
}

void I2Cx_DMA_RX_IRQHandler(void)
{
  i2c_dma_rx_irq_handler(&hi2cx);
  hs3003_dma_rx_irq_notify();
}

void I2Cx_DMA_TX_IRQHandler(void)
{
  i2c_dma_tx_irq_handler(&hi2cx);
}

void I2Cx_EVT_IRQHandler(void)
{
  i2c_evt_irq_handler(&hi2cx);
}

void I2Cx_ERR_IRQHandler(void)
{
  i2c_err_irq_handler(&hi2cx);
  hs3003_i2c_error_irq_notify();
}

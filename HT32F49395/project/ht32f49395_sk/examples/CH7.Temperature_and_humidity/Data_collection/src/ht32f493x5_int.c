/*********************************************************************************************************//**
 * @file    ht32f493x5_int.c
 * @brief   HT32F49395 HS3003 DMA + Interrupt handlers
 ************************************************************************************************************/

#include "ht32f493x5_int.h"
#include "i2c_application.h"
#include "hs300x.h"


extern i2c_handle_type hi2cx;


/*
 * 1 ms system timebase.
 *
 * main.c configures SysTick with:
 *
 *   SysTick_Config(system_core_clock / 1000U);
 */
volatile uint32_t g_hs3003_tick_ms = 0U;


#define I2Cx_DMA_TX_IRQHandler           DMA1_Channel6_IRQHandler
#define I2Cx_DMA_RX_IRQHandler           DMA1_Channel7_IRQHandler
#define I2Cx_EVT_IRQHandler              I2C1_EVT_IRQHandler
#define I2Cx_ERR_IRQHandler              I2C1_ERR_IRQHandler


void NMI_Handler(void)
{
}


void HardFault_Handler(void)
{
  while(1)
  {
  }
}


void MemManage_Handler(void)
{
  while(1)
  {
  }
}


void BusFault_Handler(void)
{
  while(1)
  {
  }
}


void UsageFault_Handler(void)
{
  while(1)
  {
  }
}


void SVC_Handler(void)
{
}


void DebugMon_Handler(void)
{
}


void PendSV_Handler(void)
{
}


/* =========================================================================================
 * 1 ms Tick Interrupt
 * ========================================================================================= */

void SysTick_Handler(void)
{
  g_hs3003_tick_ms++;
}


/* =========================================================================================
 * I2C1 DMA RX Interrupt
 * ========================================================================================= */

void I2Cx_DMA_RX_IRQHandler(void)
{
  /*
   * First let Holtek i2c_application update its internal I2C/DMA state.
   */
  i2c_dma_rx_irq_handler(&hi2cx);

  /*
   * Then notify the sensor driver.
   */
  hs3003_dma_rx_irq_notify();
}


/* =========================================================================================
 * I2C1 DMA TX Interrupt
 * ========================================================================================= */

void I2Cx_DMA_TX_IRQHandler(void)
{
  i2c_dma_tx_irq_handler(&hi2cx);
}


/* =========================================================================================
 * I2C1 Event Interrupt
 * ========================================================================================= */

void I2Cx_EVT_IRQHandler(void)
{
  i2c_evt_irq_handler(&hi2cx);
}


/* =========================================================================================
 * I2C1 Error Interrupt
 * ========================================================================================= */

void I2Cx_ERR_IRQHandler(void)
{
  i2c_err_irq_handler(&hi2cx);

  hs3003_i2c_error_irq_notify();
}

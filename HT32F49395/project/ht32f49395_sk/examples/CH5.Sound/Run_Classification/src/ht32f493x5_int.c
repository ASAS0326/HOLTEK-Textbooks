/*********************************************************************************************************//**
 * @file    ht32f493x5_int.c
 * @brief   HT32F49395 interrupt handlers for microphone + Edge Impulse
 ************************************************************************************************************/

#include "ht32f493x5_int.h"
#include "ht32f493x5_board.h"


volatile uint32_t g_tick_ms = 0U;


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


void SysTick_Handler(void)
{
  g_tick_ms++;
}


uint32_t SysTick_GetTick(void)
{
  return g_tick_ms;
}


/*
 * NOTE:
 *
 * DMA1_Channel4_IRQHandler is already implemented inside the
 * existing SPH0645LM4H.c microphone driver.
 *
 * Do not create a second DMA1_Channel4_IRQHandler here.
 */

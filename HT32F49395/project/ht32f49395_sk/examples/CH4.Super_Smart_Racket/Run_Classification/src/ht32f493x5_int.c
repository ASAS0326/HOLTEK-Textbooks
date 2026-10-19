#include "ht32f493x5_int.h"
#include "ht32f493x5_board.h"
#include "ei_main.h"

__IO uint32_t uwTick = 0U;


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
  uwTick++;

  /* LSM6DS3 104 Hz sampling for Edge Impulse */
  ei_main_sample_tick();
}


uint32_t SysTick_GetTick(void)
{
  return uwTick;
}


/*
 * DMA1_Channel3_IRQHandler and DMA1_Channel4_IRQHandler
 * are implemented in LSM6DS3.c.
 *
 * ADC1_2_IRQHandler is intentionally omitted here because this
 * IMU + Edge Impulse project does not use vmor_flag_index.
 */

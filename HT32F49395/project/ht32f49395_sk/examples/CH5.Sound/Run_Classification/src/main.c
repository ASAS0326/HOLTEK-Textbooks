/*********************************************************************************************************//**
 * @file    main.c
 * @brief   HT32F49395 + ICS-43434 DMA/IRQ + Edge Impulse baby_cry validation
 ************************************************************************************************************/

#include "ht32f493x5_board.h"
#include "ht32f493x5_clock.h"

#include "ICS43434.h"
#include "ei_main.h"

#include <stdint.h>
#include <stdio.h>


extern volatile uint32_t g_tick_ms;


/* =========================================================================================
 * Main
 * ========================================================================================= */

int main(void)
{
  int result;


  nvic_priority_group_config(
      NVIC_PRIORITY_GROUP_4);


  system_clock_config();

  ht32_board_init();


  /*
   * UART only prints model results.
   * It no longer streams raw PCM continuously.
   */
  uart_print_init(
      115200);


  printf("\r\n");
  printf("========================================\r\n");
  printf("ICS-43434 + Edge Impulse baby_cry\r\n");
  printf("Mic capture : I2S2 + DMA + IRQ\r\n");
  printf("Model input : 8000 Hz / 1 second\r\n");
  printf("========================================\r\n");


  /*
   * Existing microphone driver:
   *
   *   I2S2 48 kHz stereo
   *   DMA1 CH4 circular
   *   half/full DMA interrupt
   *   driver output = 8 kHz mono PCM16
   */
  ICS43434_init();


  /*
   * Board schematic:
   *
   * U5 ICS-43434, LR=GND  -> LEFT
   * U6 ICS-43434, LR=3.3V -> RIGHT
   */
  ICS43434_set_channel(
      ICS43434_CHANNEL_RIGHT);


  ICS43434_start();


  /*
   * Permanent 1 ms timebase for Edge Impulse timing.
   *
   * Configure this only after peripheral initialization.
   */
  g_tick_ms = 0U;


  if(SysTick_Config(
         system_core_clock /
         1000U) != 0U)
  {
    printf("ERROR: SysTick_Config\r\n");

    while(1)
    {
    }
  }


  while(1)
  {
    /*
     * ei_main():
     *
     * 1. collect 8000 real microphone samples
     * 2. run Edge Impulse model
     * 3. print cry/noise probabilities
     */
    result =
        ei_main();


    if(result < 0)
    {
      printf(
          "EI ERROR=%d\r\n",
          result);
    }


    /*
     * DMA keeps running continuously.
     *
     * Start the next inference window immediately.
     */
  }
}

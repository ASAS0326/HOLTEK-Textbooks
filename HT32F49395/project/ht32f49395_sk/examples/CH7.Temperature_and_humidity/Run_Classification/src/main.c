#include "ht32f493x5_board.h"
#include "ht32f493x5_clock.h"
#include "hs300x.h"
#include "ei_main.h"

#include <stdint.h>
#include <stdio.h>

extern volatile uint32_t g_hs3003_tick_ms;

int main(void)
{
  nvic_priority_group_config(NVIC_PRIORITY_GROUP_4);
  system_clock_config();
  ht32_board_init();
  uart_print_init(115200);

  /* ??????? DMA */
  hs3003_init();

  /* ??? SysTick */
  g_hs3003_tick_ms = 0U;
  if(SysTick_Config(system_core_clock / 1000U) != 0U)
  {
    printf("ERROR: SysTick_Config\r\n");
    while(1) {}
  }

  /* ?? Edge Impulse ?????? (?? return) */
  (void)ei_main();

  while(1)
  {
  }
}
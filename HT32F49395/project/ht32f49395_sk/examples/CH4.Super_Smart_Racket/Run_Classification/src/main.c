#include "ht32f493x5_board.h"
#include "ht32f493x5_clock.h"

#include "LSM6DS3.h"
#include "ble_uart4.h"
#include "ei_main.h"

#include <stdint.h>
#include <stdio.h>

#define BLE_UART_BAUD 9600UL

/*
 * Advertised by the on-board BM67C593 BLE module. The receiver page
 * https://asas0326.github.io/holtek_Super_Smart_Racket/ only lists
 * devices whose name starts with "Super_Smart_Racket".
 */
#define BLE_DEVICE_NAME "Super_Smart_Racket"

extern __IO uint32_t uwTick;

int main(void)
{
  uint8_t i;
  uint8_t who;

  int result;

  system_clock_config();

  ht32_board_init();

  /*
   * Debug UART
   */
  uart_print_init(
      115200);

  /*
   * BLE UART
   *
   * PA0 = UART4_TX
   * PA1 = UART4_RX
   * 9600 8N1
   *
   * Carries only the binary V2 AI frames for
   * index.html; text goes to the debug UART.
   */
  ble_uart4_init(
      BLE_UART_BAUD);

  printf("\r\n");
  printf("========================================\r\n");
  printf("LSM6DS3 104 Hz + Edge Impulse\r\n");
  ei_main_print_model();
  printf("BLE UART4 PA0/PA1 9600 8N1\r\n");
  printf("Build: %s %s\r\n", __DATE__, __TIME__);
  printf("========================================\r\n");

  /*
   * BLE module name, written to the module only when it differs
   */
  (void)ble_uart4_set_name(
      BLE_DEVICE_NAME);

  /*
   * LSM6DS3 initialization
   */
  for(i = 0U;
      lsm6ds3trc_init() == 0U;
      i++)
  {
    printf(
        "LSM6DS3 init ERROR, WHO=0x%02X (try %u)\r\n",
        lsm6ds3trc_who_am_i(),
        (unsigned int)(i + 1U));

    if(i >= 4U)
    {
      while(1)
      {
      }
    }

    delay_ms(
        100U);
  }

  printf(
      "LSM6DS3 init PASS, WHO=0x%02X\r\n",
      lsm6ds3trc_who_am_i());

  /*
   * SPI polling verification
   */
  for(i = 0U;
      i < 10U;
      i++)
  {
    who =
        lsm6ds3trc_who_am_i();

    printf(
        "PRE-DMA WHO[%u]=0x%02X\r\n",
        (unsigned int)i,
        who);

    delay_ms(
        20U);
  }

  /*
   * DMA + DMA IRQ
   */
  nvic_priority_group_config(
      NVIC_PRIORITY_GROUP_4);

  lsm6ds3trc_dma_init();

  printf(
      "LSM6DS3 DMA INIT DONE\r\n");

  /*
   * Permanent 1 ms SysTick
   */
  uwTick = 0U;

  if(SysTick_Config(
         system_core_clock /
         1000U) != 0U)
  {
    printf(
        "SysTick Config ERROR\r\n");

    while(1)
    {
    }
  }

  while(1)
  {

    result =
        ei_main();

    if(result < 0)
    {
      printf(
          "EI ERROR=%d\r\n",
          result);
    }
  }
}
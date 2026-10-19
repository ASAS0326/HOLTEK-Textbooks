#include "ht32f493x5_board.h"
#include "ht32f493x5_clock.h"
#include "ICS43434.h"

#include <stdint.h>

#define EI_UART_BAUD 921600UL

static int16_t pcm_buffer[ICS43434_PCM_SAMPLES];

static void uart_send_byte(uint8_t data)
{
  while(usart_flag_get(
            PRINT_UART,
            USART_TDBE_FLAG) == RESET)
  {
  }

  usart_data_transmit(
      PRINT_UART,
      data);
}

static void uart_send_int16_line(int16_t value)
{
  char digits[6];
  uint16_t magnitude;
  uint8_t count = 0U;

  if(value < 0)
  {
    uart_send_byte((uint8_t)'-');
    magnitude = (uint16_t)(-(int32_t)value);
  }
  else
  {
    magnitude = (uint16_t)value;
  }

  if(magnitude == 0U)
  {
    uart_send_byte((uint8_t)'0');
  }
  else
  {
    while(magnitude != 0U)
    {
      digits[count++] =
          (char)('0' + (magnitude % 10U));

      magnitude /= 10U;
    }

    while(count != 0U)
    {
      count--;
      uart_send_byte((uint8_t)digits[count]);
    }
  }

  uart_send_byte((uint8_t)'\r');
  uart_send_byte((uint8_t)'\n');
}

int main(void)
{
  uint32_t samples;
  uint32_t i;

  nvic_priority_group_config(
      NVIC_PRIORITY_GROUP_4);

  system_clock_config();
  ht32_board_init();

  /*
   * IMPORTANT:
   * This UART must contain ONLY numeric PCM samples.
   * Do not use printf() on PRINT_UART in this firmware.
   */
  uart_print_init(EI_UART_BAUD);

  ICS43434_init();

  /*
   * U6 ICS-43434, LR=3.3 V -> RIGHT.
   * Use the same channel for both data collection and inference.
   */
  ICS43434_set_channel(
      ICS43434_CHANNEL_RIGHT);

  ICS43434_start();

  while(1)
  {
    samples =
        ICS43434_read_pcm16(
            pcm_buffer,
            ICS43434_PCM_SAMPLES);

    if(samples != 0U)
    {
      for(i = 0U; i < samples; i++)
      {
        /*
         * Edge Impulse Data Forwarder format:
         * one sensor sample per line.
         *
         * The signed PCM16 integer itself is preserved exactly.
         */
        uart_send_int16_line(
            pcm_buffer[i]);
      }
    }
    else
    {
      __WFI();
    }
  }
}

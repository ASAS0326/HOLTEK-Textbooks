#include "ble_uart4.h"

#include "ht32f493x5_board.h"

#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

void ble_uart4_init(
    uint32_t baudrate)
{
  gpio_init_type gpio_init_struct;

  /*
   * Peripheral clocks
   */
  crm_periph_clock_enable(
      CRM_UART4_PERIPH_CLOCK,
      TRUE);

  crm_periph_clock_enable(
      CRM_GPIOA_PERIPH_CLOCK,
      TRUE);

  crm_periph_clock_enable(
      CRM_IOMUX_PERIPH_CLOCK,
      TRUE);

  /*
   * UART4 GMUX = 0010
   *
   * PA0 = UART4_TX
   * PA1 = UART4_RX
   */
  gpio_pin_remap_config(
      UART4_GMUX_0010,
      TRUE);

  gpio_default_para_init(
      &gpio_init_struct);

  /*
   * PA0
   * UART4 TX
   */
  gpio_init_struct.gpio_drive_strength =
      GPIO_DRIVE_STRENGTH_STRONGER;

  gpio_init_struct.gpio_out_type =
      GPIO_OUTPUT_PUSH_PULL;

  gpio_init_struct.gpio_mode =
      GPIO_MODE_MUX;

  gpio_init_struct.gpio_pins =
      GPIO_PINS_0;

  gpio_init_struct.gpio_pull =
      GPIO_PULL_NONE;

  gpio_init(
      GPIOA,
      &gpio_init_struct);

  /*
   * PA1
   * UART4 RX
   */
  gpio_init_struct.gpio_mode =
      GPIO_MODE_INPUT;

  gpio_init_struct.gpio_pins =
      GPIO_PINS_1;

  gpio_init_struct.gpio_pull =
      GPIO_PULL_UP;

  gpio_init(
      GPIOA,
      &gpio_init_struct);

  /*
   * UART format:
   *
   * 9600
   * 8 data bits
   * no parity
   * 1 stop bit
   *
   * baudrate is passed from main.c.
   */
  usart_init(
      UART4,
      baudrate,
      USART_DATA_8BITS,
      USART_STOP_1_BIT);

  usart_parity_selection_config(
      UART4,
      USART_PARITY_NONE);

  usart_transmitter_enable(
      UART4,
      TRUE);

  usart_receiver_enable(
      UART4,
      TRUE);

  usart_enable(
      UART4,
      TRUE);
}

static void ble_uart4_send_byte(
    uint8_t data)
{
  /*
   * Wait until transmit data register
   * is empty.
   */
  while(usart_flag_get(
            UART4,
            USART_TDBE_FLAG) == RESET)
  {
  }

  usart_data_transmit(
      UART4,
      data);
}

void ble_uart4_send(
    const uint8_t *data,
    uint32_t length)
{
  uint32_t i;

  if((data == NULL) ||
     (length == 0U))
  {
    return;
  }

  for(i = 0U;
      i < length;
      i++)
  {
    ble_uart4_send_byte(
        data[i]);
  }

  /*
   * Wait until the final byte
   * completely leaves UART4.
   */
  while(usart_flag_get(
            UART4,
            USART_TDC_FLAG) == RESET)
  {
  }
}

void ble_uart4_send_string(
    const char *text)
{
  const char *p;

  if(text == NULL)
  {
    return;
  }

  p = text;

  while(*p != '\0')
  {
    ble_uart4_send_byte(
        (uint8_t)*p);

    p++;
  }

  /*
   * Wait for final byte.
   */
  while(usart_flag_get(
            UART4,
            USART_TDC_FLAG) == RESET)
  {
  }
}

/*
 * BM67C593 module on the ESK32-AE401
 *
 * UART4 PA0/PA1 is the module's UART, PD3 drives Q8 which pulls the
 * module's NRST low. While no central is connected the module answers
 * AT commands, e.g.
 *
 *   AT+NAME?  ->  +NAME:<name>\r\nOK\r\n   (+NAME:NOT_FOUND when unset)
 *
 * Everything below polls with delay_us(), so it works before
 * SysTick_Config().
 */

#define BLE_REPLY_SIZE        64U
#define BLE_REPLY_TIMEOUT_MS  1000U
#define BLE_BOOT_MS           1500U

static char g_ble_reply[BLE_REPLY_SIZE];

static void ble_module_reset(void)
{
  gpio_init_type gpio_init_struct;

  crm_periph_clock_enable(
      CRM_GPIOD_PERIPH_CLOCK,
      TRUE);

  /*
   * PD3 low = module running (same as the R79 pull-down default).
   */
  gpio_bits_reset(
      GPIOD,
      GPIO_PINS_3);

  gpio_default_para_init(
      &gpio_init_struct);

  gpio_init_struct.gpio_mode = GPIO_MODE_OUTPUT;
  gpio_init_struct.gpio_out_type = GPIO_OUTPUT_PUSH_PULL;
  gpio_init_struct.gpio_pull = GPIO_PULL_NONE;
  gpio_init_struct.gpio_drive_strength = GPIO_DRIVE_STRENGTH_STRONGER;
  gpio_init_struct.gpio_pins = GPIO_PINS_3;

  gpio_init(
      GPIOD,
      &gpio_init_struct);

  gpio_bits_set(
      GPIOD,
      GPIO_PINS_3);

  delay_ms(20U);

  gpio_bits_reset(
      GPIOD,
      GPIO_PINS_3);

  delay_ms(BLE_BOOT_MS);
}

static uint8_t ble_reply_ends_with(
    uint32_t length,
    const char *tail)
{
  uint32_t tail_length = (uint32_t)strlen(tail);

  return ((length >= tail_length) &&
          (memcmp(&g_ble_reply[length - tail_length],
                  tail,
                  tail_length) == 0)) ? 1U : 0U;
}

/*
 * Send an AT command and collect the reply into g_ble_reply until it
 * ends with OK or ERROR, or BLE_REPLY_TIMEOUT_MS passes.
 */
static void ble_command(
    const char *command)
{
  uint32_t length = 0U;
  uint32_t steps = BLE_REPLY_TIMEOUT_MS * 10U;
  char c;

  /*
   * Drop anything left over from before.
   */
  while(usart_flag_get(
            UART4,
            USART_RDBF_FLAG) != RESET)
  {
    (void)usart_data_receive(UART4);
  }

  ble_uart4_send(
      (const uint8_t *)command,
      (uint32_t)strlen(command));

  /*
   * One byte takes 1.04 ms at 9600 baud, polling every 100 us
   * never overruns.
   */
  while(steps-- > 0U)
  {
    while(usart_flag_get(
              UART4,
              USART_RDBF_FLAG) != RESET)
    {
      c = (char)usart_data_receive(UART4);

      if(length < (BLE_REPLY_SIZE - 1U))
      {
        g_ble_reply[length++] = c;
      }

      g_ble_reply[length] = '\0';

      if((ble_reply_ends_with(length, "OK\r\n") != 0U) ||
         (ble_reply_ends_with(length, "ERROR\r\n") != 0U))
      {
        return;
      }
    }

    delay_us(100U);
  }

  g_ble_reply[length] = '\0';
}

static void ble_print_reply(
    const char *command_name)
{
  const char *p;

  printf("[BLE] %s -> ", command_name);

  for(p = g_ble_reply; *p != '\0'; p++)
  {
    if(*p == '\n')
    {
      printf(" ");
    }
    else if(*p != '\r')
    {
      printf("%c", *p);
    }
  }

  printf("\r\n");
}

/*
 * AT+NAME? -> copy <name> of "+NAME:<name>" into out.
 * return 1 on "+NAME:...OK", else 0.
 */
static uint8_t ble_query_name(
    char *out,
    uint32_t size)
{
  const char *start;
  const char *end;
  uint32_t length;

  ble_command("AT+NAME?\r\n");

  ble_print_reply("AT+NAME?");

  start = strstr(g_ble_reply, "+NAME:");

  if((start == NULL) ||
     (strstr(g_ble_reply, "OK\r\n") == NULL))
  {
    return 0U;
  }

  start += 6;

  end = strstr(start, "\r\n");

  length = (end != NULL) ? (uint32_t)(end - start) : (uint32_t)strlen(start);

  if(length >= size)
  {
    length = size - 1U;
  }

  memcpy(out, start, length);
  out[length] = '\0';

  return 1U;
}

uint8_t ble_uart4_set_name(
    const char *name)
{
  char current[BLE_REPLY_SIZE];
  char command[BLE_REPLY_SIZE + 16U];
  uint32_t attempt = 0U;

  /*
   * After power-up the module may still be booting.
   */
  while(ble_query_name(current, sizeof(current)) == 0U)
  {
    if(++attempt >= 3U)
    {
      printf("[BLE] module did not answer AT+NAME? (connected to a central?)\r\n");

      return 0U;
    }
  }

  if(strcmp(current, name) == 0)
  {
    printf("[BLE] name is already \"%s\"\r\n", name);

    return 1U;
  }

  (void)snprintf(command, sizeof(command), "AT+NAME=%s\r\n", name);

  ble_command(command);

  ble_print_reply("AT+NAME=<name>");

  if(strstr(g_ble_reply, "OK\r\n") == NULL)
  {
    /*
     * Some AT firmwares want string values in quotes.
     */
    (void)snprintf(command, sizeof(command), "AT+NAME=\"%s\"\r\n", name);

    ble_command(command);

    ble_print_reply("AT+NAME=\"<name>\"");

    if(strstr(g_ble_reply, "OK\r\n") == NULL)
    {
      return 0U;
    }
  }

  /*
   * Restart advertising with the new name, then read it back.
   */
  ble_module_reset();

  if((ble_query_name(current, sizeof(current)) == 0U) ||
     (strcmp(current, name) != 0))
  {
    printf("[BLE] name was not stored as \"%s\"\r\n", name);

    return 0U;
  }

  printf("[BLE] name set to \"%s\"\r\n", name);

  return 1U;
}
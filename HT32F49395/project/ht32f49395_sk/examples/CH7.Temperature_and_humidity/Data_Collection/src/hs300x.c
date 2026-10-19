/*********************************************************************************************************//**
 * @file    hs300x.c
 * @brief   HT32F49395 + HS3003 non-blocking DMA/Interrupt driver
 *
 * Acquisition architecture:
 *
 *   HS3003 measurement request
 *          |
 *          v
 *   non-blocking 40 ms conversion wait
 *          |
 *          v
 *   I2C1 RX -> DMA1 Channel 7 -> RAM
 *          |
 *          v
 *   DMA RX interrupt
 *          |
 *          v
 *   result ready
 *
 * No i2c_wait_end().
 * No delay_ms(40).
 * No while() is used to wait for acquisition completion.
 ************************************************************************************************************/

#include "hs300x.h"

#include "ht32f493x5_board.h"
#include "ht32f493x5_clock.h"
#include "i2c_application.h"

#include <stdint.h>
#include <string.h>


/* =========================================================================================
 * Configuration
 * ========================================================================================= */

#define I2C_TIMEOUT                    0xFFFFUL

#define I2Cx_SPEED                     100000UL

/*
 * HS3003:
 *
 * 7-bit address = 0x44
 * Holtek i2c_application API uses shifted address = 0x88.
 */
#define HS3003_ADDRESS                 0x88

#define I2Cx_OWN_ADDRESS               0xA0


/* =========================================================================================
 * I2C1 / GPIO
 * ========================================================================================= */

#define I2Cx_PORT                      I2C1
#define I2Cx_CLK                       CRM_I2C1_PERIPH_CLOCK

#define I2Cx_SCL_PIN                   GPIO_PINS_8
#define I2Cx_SCL_GPIO_PORT             GPIOB
#define I2Cx_SCL_GPIO_CLK              CRM_GPIOB_PERIPH_CLOCK

#define I2Cx_SDA_PIN                   GPIO_PINS_9
#define I2Cx_SDA_GPIO_PORT             GPIOB
#define I2Cx_SDA_GPIO_CLK              CRM_GPIOB_PERIPH_CLOCK


/* =========================================================================================
 * DMA / Interrupt
 *
 * Same channel mapping as the HT32F493x5 I2C DMA example.
 * ========================================================================================= */

#define I2Cx_DMA_CLK                   CRM_DMA1_PERIPH_CLOCK

#define I2Cx_DMA_TX_CHANNEL            DMA1_CHANNEL6
#define I2Cx_DMA_TX_IRQn               DMA1_Channel6_IRQn

#define I2Cx_DMA_RX_CHANNEL            DMA1_CHANNEL7
#define I2Cx_DMA_RX_IRQn               DMA1_Channel7_IRQn

#define I2Cx_EVT_IRQn                  I2C1_EVT_IRQn
#define I2Cx_ERR_IRQn                  I2C1_ERR_IRQn


/* =========================================================================================
 * Timing
 * ========================================================================================= */

#define HS3003_CONVERSION_TIME_MS       40UL
#define HS3003_CONTROL_TIMEOUT_MS       20UL
#define HS3003_DMA_TIMEOUT_MS           20UL


/* =========================================================================================
 * Driver State
 * ========================================================================================= */

typedef enum
{
  HS3003_STATE_IDLE = 0,

  HS3003_STATE_REQ_WAIT_BUS_IDLE,
  HS3003_STATE_REQ_WAIT_START,
  HS3003_STATE_REQ_WAIT_ADDRESS,
  HS3003_STATE_REQ_WAIT_STOP,

  HS3003_STATE_WAIT_CONVERSION,

  HS3003_STATE_RX_DMA,
  HS3003_STATE_RX_WAIT_BUS_IDLE

} hs3003_state_type;


/*
 * IMPORTANT:
 *
 * This must be global, not static.
 * ht32f493x5_int.c uses:
 *
 *   extern i2c_handle_type hi2cx;
 */
i2c_handle_type hi2cx;


static uint8_t hs3003_data[4];

static volatile uint8_t hs3003_dma_rx_done = 0U;
static volatile uint8_t hs3003_i2c_error = 0U;

static volatile uint8_t hs3003_result_ready = 0U;

static hs3003_state_type hs3003_state = HS3003_STATE_IDLE;

static uint32_t hs3003_state_start_ms = 0U;
static uint32_t hs3003_conversion_deadline_ms = 0U;
static uint32_t hs3003_last_error = 0U;

static hs3003_result_type hs3003_latest_result;


/* =========================================================================================
 * Error Codes
 * ========================================================================================= */

#define HS3003_ERROR_NONE               0UL
#define HS3003_ERROR_REQUEST_TIMEOUT    1UL
#define HS3003_ERROR_NACK               2UL
#define HS3003_ERROR_DMA_START          3UL
#define HS3003_ERROR_DMA_TIMEOUT        4UL
#define HS3003_ERROR_I2C_IRQ            5UL


/* =========================================================================================
 * Internal Helpers
 * ========================================================================================= */

static void hs3003_set_state(hs3003_state_type state,
                             uint32_t now_ms)
{
  hs3003_state = state;
  hs3003_state_start_ms = now_ms;
}


static uint8_t hs3003_timeout_expired(uint32_t now_ms,
                                      uint32_t start_ms,
                                      uint32_t timeout_ms)
{
  if((uint32_t)(now_ms - start_ms) >= timeout_ms)
  {
    return 1U;
  }

  return 0U;
}


static void hs3003_fail(uint32_t error_code)
{
  hs3003_last_error = error_code;

  hs3003_dma_rx_done = 0U;
  hs3003_i2c_error = 0U;

  hs3003_state = HS3003_STATE_IDLE;
}


static void hs3003_decode_result(void)
{
  uint16_t raw_humidity;
  uint16_t raw_temperature;
  uint8_t status;


  hs3003_latest_result.raw_bytes[0] = hs3003_data[0];
  hs3003_latest_result.raw_bytes[1] = hs3003_data[1];
  hs3003_latest_result.raw_bytes[2] = hs3003_data[2];
  hs3003_latest_result.raw_bytes[3] = hs3003_data[3];


  status =
      (hs3003_data[0] >> 6) & 0x03U;


  raw_humidity =
      ((uint16_t)(hs3003_data[0] & 0x3FU) << 8)
      |
      (uint16_t)hs3003_data[1];


  raw_temperature =
      (
        ((uint16_t)hs3003_data[2] << 8)
        |
        (uint16_t)hs3003_data[3]
      )
      >> 2;


  hs3003_latest_result.status = status;
  hs3003_latest_result.raw_humidity = raw_humidity;
  hs3003_latest_result.raw_temperature = raw_temperature;


  hs3003_latest_result.humidity_x100 =
      ((uint32_t)raw_humidity * 10000UL)
      /
      16383UL;


  hs3003_latest_result.temperature_x100 =
      (
        ((int32_t)raw_temperature * 16500L)
        /
        16383L
      )
      -
      4000L;


  hs3003_result_ready = 1U;
}


/* =========================================================================================
 * HT32 I2C Low-Level Initialization
 *
 * This follows the supplied HT32F493x5 I2C DMA example:
 *
 *   DMA1 Channel 6 = TX
 *   DMA1 Channel 7 = RX
 *   DMA TX/RX IRQ enabled
 *   I2C EVT/ERR IRQ enabled
 * ========================================================================================= */

void i2c_lowlevel_init(i2c_handle_type *hi2c)
{
  gpio_init_type gpio_initstructure;


  if(hi2c->i2cx == I2Cx_PORT)
  {
    crm_periph_clock_enable(I2Cx_CLK, TRUE);
    crm_periph_clock_enable(I2Cx_SCL_GPIO_CLK, TRUE);
    crm_periph_clock_enable(I2Cx_SDA_GPIO_CLK, TRUE);
    crm_periph_clock_enable(CRM_IOMUX_PERIPH_CLOCK, TRUE);


    /*
     * I2C1_GMUX = 0001
     *
     * PB8 = I2C1_SCL
     * PB9 = I2C1_SDA
     */
    gpio_pin_remap_config(I2C1_GMUX_0001, TRUE);


    gpio_default_para_init(&gpio_initstructure);

    gpio_initstructure.gpio_out_type =
        GPIO_OUTPUT_OPEN_DRAIN;

    gpio_initstructure.gpio_pull =
        GPIO_PULL_UP;

    gpio_initstructure.gpio_mode =
        GPIO_MODE_MUX;

    gpio_initstructure.gpio_drive_strength =
        GPIO_DRIVE_STRENGTH_MODERATE;


    gpio_initstructure.gpio_pins =
        I2Cx_SCL_PIN;

    gpio_init(I2Cx_SCL_GPIO_PORT,
              &gpio_initstructure);


    gpio_initstructure.gpio_pins =
        I2Cx_SDA_PIN;

    gpio_init(I2Cx_SDA_GPIO_PORT,
              &gpio_initstructure);


    /* ---------------------------------------------------------------------
     * DMA + I2C Interrupt
     * --------------------------------------------------------------------- */

    nvic_irq_enable(I2Cx_DMA_TX_IRQn, 0, 0);
    nvic_irq_enable(I2Cx_DMA_RX_IRQn, 0, 0);

    nvic_irq_enable(I2Cx_EVT_IRQn, 0, 0);
    nvic_irq_enable(I2Cx_ERR_IRQn, 0, 0);


    /* ---------------------------------------------------------------------
     * DMA
     * --------------------------------------------------------------------- */

    crm_periph_clock_enable(I2Cx_DMA_CLK, TRUE);

    hi2c->dma_tx_channel =
        I2Cx_DMA_TX_CHANNEL;

    hi2c->dma_rx_channel =
        I2Cx_DMA_RX_CHANNEL;


    dma_reset(hi2c->dma_tx_channel);
    dma_reset(hi2c->dma_rx_channel);


    dma_default_para_init(
        &hi2c->dma_init_struct);


    hi2c->dma_init_struct.peripheral_inc_enable =
        FALSE;

    hi2c->dma_init_struct.memory_inc_enable =
        TRUE;

    hi2c->dma_init_struct.peripheral_data_width =
        DMA_PERIPHERAL_DATA_WIDTH_BYTE;

    hi2c->dma_init_struct.memory_data_width =
        DMA_MEMORY_DATA_WIDTH_BYTE;

    hi2c->dma_init_struct.loop_mode_enable =
        FALSE;

    hi2c->dma_init_struct.priority =
        DMA_PRIORITY_HIGH;

    /*
     * Keep the same initial direction used by the official example.
     * i2c_application configures the active DMA transfer as required.
     */
    hi2c->dma_init_struct.direction =
        DMA_DIR_MEMORY_TO_PERIPHERAL;


    dma_init(
        hi2c->dma_tx_channel,
        &hi2c->dma_init_struct);

    dma_init(
        hi2c->dma_rx_channel,
        &hi2c->dma_init_struct);


    /* ---------------------------------------------------------------------
     * I2C
     * --------------------------------------------------------------------- */

    i2c_init(
        hi2c->i2cx,
        I2C_FSMODE_DUTY_2_1,
        I2Cx_SPEED);


    i2c_own_address1_set(
        hi2c->i2cx,
        I2C_ADDRESS_MODE_7BIT,
        I2Cx_OWN_ADDRESS);
  }
}


/* =========================================================================================
 * Public API
 * ========================================================================================= */

void hs3003_init(void)
{
  memset(&hi2cx, 0, sizeof(hi2cx));
  memset(hs3003_data, 0, sizeof(hs3003_data));
  memset(&hs3003_latest_result, 0, sizeof(hs3003_latest_result));

  hs3003_dma_rx_done = 0U;
  hs3003_i2c_error = 0U;
  hs3003_result_ready = 0U;

  hs3003_last_error = HS3003_ERROR_NONE;
  hs3003_state = HS3003_STATE_IDLE;


  hi2cx.i2cx = I2Cx_PORT;

  i2c_config(&hi2cx);


  /*
   * This delay is used only once during boot before the asynchronous
   * acquisition loop starts.
   */
  delay_ms(100U);
}


uint8_t hs3003_start_async(uint32_t now_ms)
{
  if(hs3003_state != HS3003_STATE_IDLE)
  {
    return 0U;
  }


  hs3003_last_error = HS3003_ERROR_NONE;
  hs3003_dma_rx_done = 0U;
  hs3003_i2c_error = 0U;
  hs3003_result_ready = 0U;


  /*
   * Do not wait here.
   * hs3003_process() advances the request state one step at a time.
   */
  hs3003_set_state(
      HS3003_STATE_REQ_WAIT_BUS_IDLE,
      now_ms);


  return 1U;
}


void hs3003_process(uint32_t now_ms)
{
  i2c_status_type i2c_status;


  if(hs3003_i2c_error != 0U)
  {
    hs3003_fail(HS3003_ERROR_I2C_IRQ);
    return;
  }


  switch(hs3003_state)
  {
    /* ---------------------------------------------------------------------
     * IDLE
     * --------------------------------------------------------------------- */

    case HS3003_STATE_IDLE:
      break;


    /* ---------------------------------------------------------------------
     * Measurement Request
     *
     * START -> Address+WRITE -> ACK -> STOP
     *
     * This used to be several blocking while() loops.
     * It is now a non-blocking state machine.
     * --------------------------------------------------------------------- */

    case HS3003_STATE_REQ_WAIT_BUS_IDLE:

      if(i2c_flag_get(I2Cx_PORT,
                      I2C_BUSYF_FLAG) == RESET)
      {
        i2c_start_generate(I2Cx_PORT);

        hs3003_set_state(
            HS3003_STATE_REQ_WAIT_START,
            now_ms);
      }
      else if(hs3003_timeout_expired(
                  now_ms,
                  hs3003_state_start_ms,
                  HS3003_CONTROL_TIMEOUT_MS) != 0U)
      {
        hs3003_fail(
            HS3003_ERROR_REQUEST_TIMEOUT);
      }

      break;


    case HS3003_STATE_REQ_WAIT_START:

      if(i2c_flag_get(I2Cx_PORT,
                      I2C_STARTF_FLAG) != RESET)
      {
        i2c_7bit_address_send(
            I2Cx_PORT,
            HS3003_ADDRESS,
            I2C_DIRECTION_TRANSMIT);

        hs3003_set_state(
            HS3003_STATE_REQ_WAIT_ADDRESS,
            now_ms);
      }
      else if(hs3003_timeout_expired(
                  now_ms,
                  hs3003_state_start_ms,
                  HS3003_CONTROL_TIMEOUT_MS) != 0U)
      {
        hs3003_fail(
            HS3003_ERROR_REQUEST_TIMEOUT);
      }

      break;


    case HS3003_STATE_REQ_WAIT_ADDRESS:

      if(i2c_flag_get(I2Cx_PORT,
                      I2C_ACKFAIL_FLAG) != RESET)
      {
        i2c_flag_clear(
            I2Cx_PORT,
            I2C_ACKFAIL_FLAG);

        i2c_stop_generate(I2Cx_PORT);

        hs3003_fail(
            HS3003_ERROR_NACK);
      }
      else if(i2c_flag_get(I2Cx_PORT,
                           I2C_ADDR7F_FLAG) != RESET)
      {
        i2c_flag_clear(
            I2Cx_PORT,
            I2C_ADDR7F_FLAG);

        /*
         * HS3003 measurement request has no payload byte.
         */
        i2c_stop_generate(I2Cx_PORT);

        hs3003_set_state(
            HS3003_STATE_REQ_WAIT_STOP,
            now_ms);
      }
      else if(hs3003_timeout_expired(
                  now_ms,
                  hs3003_state_start_ms,
                  HS3003_CONTROL_TIMEOUT_MS) != 0U)
      {
        i2c_stop_generate(I2Cx_PORT);

        hs3003_fail(
            HS3003_ERROR_REQUEST_TIMEOUT);
      }

      break;


    case HS3003_STATE_REQ_WAIT_STOP:

      if(i2c_flag_get(I2Cx_PORT,
                      I2C_BUSYF_FLAG) == RESET)
      {
        /*
         * Sensor converts RH + temperature in the background.
         *
         * No delay_ms(40).
         * CPU can execute other work / sleep during these 40 ms.
         */
        hs3003_conversion_deadline_ms =
            now_ms +
            HS3003_CONVERSION_TIME_MS;

        hs3003_set_state(
            HS3003_STATE_WAIT_CONVERSION,
            now_ms);
      }
      else if(hs3003_timeout_expired(
                  now_ms,
                  hs3003_state_start_ms,
                  HS3003_CONTROL_TIMEOUT_MS) != 0U)
      {
        hs3003_fail(
            HS3003_ERROR_REQUEST_TIMEOUT);
      }

      break;


    /* ---------------------------------------------------------------------
     * Conversion Wait
     * --------------------------------------------------------------------- */

    case HS3003_STATE_WAIT_CONVERSION:

      if((int32_t)(
             now_ms -
             hs3003_conversion_deadline_ms) >= 0)
      {
        /*
         * Start DMA reception and return immediately.
         *
         * DO NOT call i2c_wait_end().
         */
        i2c_status =
            i2c_master_receive_dma(
                &hi2cx,
                HS3003_ADDRESS,
                hs3003_data,
                4U,
                I2C_TIMEOUT);


        if(i2c_status == I2C_OK)
        {
          hs3003_dma_rx_done = 0U;

          hs3003_set_state(
              HS3003_STATE_RX_DMA,
              now_ms);
        }
        else
        {
          hs3003_fail(
              HS3003_ERROR_DMA_START);
        }
      }

      break;


    /* ---------------------------------------------------------------------
     * DMA Transfer
     *
     * DMA1 Channel 7 IRQ sets hs3003_dma_rx_done.
     * --------------------------------------------------------------------- */

    case HS3003_STATE_RX_DMA:

      if(hs3003_dma_rx_done != 0U)
      {
        hs3003_dma_rx_done = 0U;

        hs3003_set_state(
            HS3003_STATE_RX_WAIT_BUS_IDLE,
            now_ms);
      }
      else if(hs3003_timeout_expired(
                  now_ms,
                  hs3003_state_start_ms,
                  HS3003_DMA_TIMEOUT_MS) != 0U)
      {
        hs3003_fail(
            HS3003_ERROR_DMA_TIMEOUT);
      }

      break;


    /* ---------------------------------------------------------------------
     * Wait only by state check; no blocking loop.
     *
     * The DMA data is already in RAM. This state allows the I2C event ISR
     * to finish STOP/bus cleanup before the result is published.
     * --------------------------------------------------------------------- */

    case HS3003_STATE_RX_WAIT_BUS_IDLE:

      if(i2c_flag_get(I2Cx_PORT,
                      I2C_BUSYF_FLAG) == RESET)
      {
        hs3003_decode_result();

        hs3003_state =
            HS3003_STATE_IDLE;
      }
      else if(hs3003_timeout_expired(
                  now_ms,
                  hs3003_state_start_ms,
                  HS3003_DMA_TIMEOUT_MS) != 0U)
      {
        hs3003_fail(
            HS3003_ERROR_DMA_TIMEOUT);
      }

      break;


    default:

      hs3003_fail(
          HS3003_ERROR_REQUEST_TIMEOUT);

      break;
  }
}


uint8_t hs3003_get_result(hs3003_result_type *result)
{
  if(result == 0)
  {
    return 0U;
  }


  if(hs3003_result_ready == 0U)
  {
    return 0U;
  }


  *result =
      hs3003_latest_result;


  hs3003_result_ready = 0U;


  return 1U;
}


uint8_t hs3003_is_busy(void)
{
  if(hs3003_state == HS3003_STATE_IDLE)
  {
    return 0U;
  }

  return 1U;
}


uint32_t hs3003_take_error(void)
{
  uint32_t error_code;


  error_code =
      hs3003_last_error;


  hs3003_last_error =
      HS3003_ERROR_NONE;


  return error_code;
}


/* =========================================================================================
 * ISR Hooks
 * ========================================================================================= */

void hs3003_dma_rx_irq_notify(void)
{
  hs3003_dma_rx_done = 1U;
}


void hs3003_i2c_error_irq_notify(void)
{
  hs3003_i2c_error = 1U;
}

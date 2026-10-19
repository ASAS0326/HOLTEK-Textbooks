#include "LSM6DS3.h"
#include "ht32f493x5_board.h"

#include <stdint.h>
#include <string.h>



static uint8_t g_dma_tx[LSM6DS3_DMA_SIZE];
static uint8_t g_dma_rx[LSM6DS3_DMA_SIZE];
static uint8_t g_last_raw[LSM6DS3_DMA_SIZE];

static volatile uint8_t g_dma_busy = 0U;
static volatile uint8_t g_dma_rx_done = 0U;
static volatile uint8_t g_dma_tx_done = 0U;
static volatile uint8_t g_dma_error = 0U;
static volatile uint8_t g_result_ready = 0U;

static volatile uint32_t g_dma_irq_count = 0U;
static volatile uint32_t g_dma_error_count = 0U;

static lsm6ds3trc_data_type g_latest_data;


/* =========================================================================================
 * GPIO
 *
 * This section is intentionally identical to the user's known-good
 * polling LSM6DS3.c.
 * ========================================================================================= */

static void lsm6ds3_gpio_config(void)
{
  gpio_init_type gpio_initstructure;

  crm_periph_clock_enable(CRM_GPIOC_PERIPH_CLOCK, TRUE);
  crm_periph_clock_enable(CRM_GPIOE_PERIPH_CLOCK, TRUE);
  crm_periph_clock_enable(CRM_IOMUX_PERIPH_CLOCK, TRUE);

  gpio_pin_remap_config(SPI3_GMUX_0001, TRUE);
  gpio_default_para_init(&gpio_initstructure);

  /* PC10 : SPI3 SCK */
  gpio_initstructure.gpio_mode = GPIO_MODE_MUX;
  gpio_initstructure.gpio_out_type = GPIO_OUTPUT_PUSH_PULL;
  gpio_initstructure.gpio_pull = GPIO_PULL_UP;
  gpio_initstructure.gpio_drive_strength = GPIO_DRIVE_STRENGTH_STRONGER;
  gpio_initstructure.gpio_pins = GPIO_PINS_10;
  gpio_init(GPIOC, &gpio_initstructure);

  /* PC11 : SPI3 MISO */
  gpio_initstructure.gpio_mode = GPIO_MODE_INPUT;
  gpio_initstructure.gpio_pull = GPIO_PULL_UP;
  gpio_initstructure.gpio_pins = GPIO_PINS_11;
  gpio_init(GPIOC, &gpio_initstructure);

  /* PC12 : SPI3 MOSI */
  gpio_initstructure.gpio_mode = GPIO_MODE_MUX;
  gpio_initstructure.gpio_out_type = GPIO_OUTPUT_PUSH_PULL;
  gpio_initstructure.gpio_pull = GPIO_PULL_UP;
  gpio_initstructure.gpio_drive_strength = GPIO_DRIVE_STRENGTH_STRONGER;
  gpio_initstructure.gpio_pins = GPIO_PINS_12;
  gpio_init(GPIOC, &gpio_initstructure);

  /* PE5 : CS */
  gpio_initstructure.gpio_mode = GPIO_MODE_OUTPUT;
  gpio_initstructure.gpio_out_type = GPIO_OUTPUT_PUSH_PULL;
  gpio_initstructure.gpio_pull = GPIO_PULL_UP;
  gpio_initstructure.gpio_drive_strength = GPIO_DRIVE_STRENGTH_STRONGER;
  gpio_initstructure.gpio_pins = GPIO_PINS_5;
  gpio_init(GPIOE, &gpio_initstructure);

  LSM6DS3_CS_HIGH();
}


/* =========================================================================================
 * SPI
 *
 * Also intentionally identical to the known-good polling version.
 * ========================================================================================= */

static void lsm6ds3_spi_config(void)
{
  spi_init_type spi_init_struct;

  crm_periph_clock_enable(CRM_SPI3_PERIPH_CLOCK, TRUE);
  spi_default_para_init(&spi_init_struct);

  spi_init_struct.transmission_mode = SPI_TRANSMIT_FULL_DUPLEX;
  spi_init_struct.master_slave_mode = SPI_MODE_MASTER;
  spi_init_struct.mclk_freq_division = SPI_MCLK_DIV_64;
  spi_init_struct.first_bit_transmission = SPI_FIRST_BIT_MSB;
  spi_init_struct.frame_bit_num = SPI_FRAME_8BIT;
  spi_init_struct.clock_polarity = SPI_CLOCK_POLARITY_HIGH;
  spi_init_struct.clock_phase = SPI_CLOCK_PHASE_2EDGE;
  spi_init_struct.cs_mode_selection = SPI_CS_SOFTWARE_MODE;

  spi_init(SPI3, &spi_init_struct);
  spi_enable(SPI3, TRUE);
}


/* =========================================================================================
 * Known-good polling access
 * ========================================================================================= */

static uint8_t spi3_transfer(uint8_t data)
{
  uint8_t rx_data;

  while(spi_i2s_flag_get(SPI3, SPI_I2S_TDBE_FLAG) == RESET)
  {
  }

  spi_i2s_data_transmit(SPI3, data);

  while(spi_i2s_flag_get(SPI3, SPI_I2S_RDBF_FLAG) == RESET)
  {
  }

  rx_data = (uint8_t)spi_i2s_data_receive(SPI3);

  return rx_data;
}


static uint8_t lsm6ds3_read_reg(uint8_t reg)
{
  uint8_t value;

  LSM6DS3_CS_LOW();

  spi3_transfer(reg | 0x80U);
  value = spi3_transfer(0x00U);

  while(spi_i2s_flag_get(SPI3, SPI_I2S_BF_FLAG) != RESET)
  {
  }

  LSM6DS3_CS_HIGH();

  return value;
}


static void lsm6ds3_write_reg(uint8_t reg,
                              uint8_t value)
{
  LSM6DS3_CS_LOW();

  spi3_transfer(reg & 0x7FU);
  spi3_transfer(value);

  while(spi_i2s_flag_get(SPI3, SPI_I2S_BF_FLAG) != RESET)
  {
  }

  LSM6DS3_CS_HIGH();
}


static void lsm6ds3_sensor_config(void)
{
  /* BDU=1, IF_INC=1 */
  lsm6ds3_write_reg(LSM6DS3_CTRL3_C, LSM6DS3_CTRL3_C_VALUE);

  /* Accelerometer: 104 Hz, +/-16 g */
  lsm6ds3_write_reg(LSM6DS3_CTRL1_XL, LSM6DS3_CTRL1_XL_VALUE);

  /* Gyroscope: 104 Hz, +/-2000 dps */
  lsm6ds3_write_reg(LSM6DS3_CTRL2_G, LSM6DS3_CTRL2_G_VALUE);

  delay_ms(20U);
}


/* =========================================================================================
 * Initialization
 *
 * IMPORTANT:
 * NO DMA call appears in this function.
 * ========================================================================================= */

uint8_t lsm6ds3trc_init(void)
{
  uint8_t who_am_i;

  lsm6ds3_gpio_config();
  lsm6ds3_spi_config();

  delay_ms(100U);

  who_am_i = lsm6ds3_read_reg(LSM6DS3_WHO_AM_I);

  if(who_am_i != LSM6DS3TRC_WHO_VALUE)
  {
    return 0U;
  }

  lsm6ds3_sensor_config();

  who_am_i = lsm6ds3_read_reg(LSM6DS3_WHO_AM_I);

  if(who_am_i != LSM6DS3TRC_WHO_VALUE)
  {
    return 0U;
  }

  return 1U;
}


uint8_t lsm6ds3trc_who_am_i(void)
{
  return lsm6ds3_read_reg(LSM6DS3_WHO_AM_I);
}


uint8_t lsm6ds3trc_read_register(uint8_t reg)
{
  return lsm6ds3_read_reg(reg);
}


uint8_t lsm6ds3trc_data_ready(void)
{
  if(g_dma_busy != 0U)
  {
    return 0U;
  }

  /* XLDA[0] and GDA[1] clear when the corresponding outputs are read. */
  return ((lsm6ds3_read_reg(LSM6DS3_STATUS_REG) & 0x03U) == 0x03U) ? 1U : 0U;
}


/* =========================================================================================
 * Known-good polling burst: one CS-low transaction from OUTX_L_G,
 * Gx_L,H; Gy_L,H; Gz_L,H; Ax_L,H; Ay_L,H; Az_L,H (IF_INC=1).
 * ========================================================================================= */

uint8_t lsm6ds3trc_read_6axis(lsm6ds3trc_data_type *data)
{
  uint8_t raw[LSM6DS3_DMA_SIZE];
  uint32_t i;

  if((data == 0) || (g_dma_busy != 0U))
  {
    return 0U;
  }

  LSM6DS3_CS_LOW();

  spi3_transfer(LSM6DS3_OUTX_L_G | 0x80U);

  for(i = 0U; i < LSM6DS3_DMA_SIZE; i++)
  {
    raw[i] = spi3_transfer(0x00U);
  }

  while(spi_i2s_flag_get(SPI3, SPI_I2S_BF_FLAG) != RESET)
  {
  }

  LSM6DS3_CS_HIGH();

  memcpy(g_last_raw, raw, LSM6DS3_DMA_SIZE);

  data->gx = (int16_t)(((uint16_t)raw[1] << 8) | raw[0]);
  data->gy = (int16_t)(((uint16_t)raw[3] << 8) | raw[2]);  
  data->gz = (int16_t)(((uint16_t)raw[5] << 8) | raw[4]);

  data->ax = (int16_t)(((uint16_t)raw[7] << 8) | raw[6]);
  data->ay = (int16_t)(((uint16_t)raw[9] << 8) | raw[8]);
  data->az = (int16_t)(((uint16_t)raw[11] << 8) | raw[10]);

  return 1U;
}


/* =========================================================================================
 * DMA Layer
 * ========================================================================================= */

static void lsm6ds3_dma_prepare(void)
{
  dma_init_type dma_init_struct;


  /* RX : SPI3 -> RAM */
  dma_reset(LSM6DS3_DMA_RX_CHANNEL);

  dma_default_para_init(&dma_init_struct);

  dma_init_struct.buffer_size = LSM6DS3_DMA_SIZE;
  dma_init_struct.direction = DMA_DIR_PERIPHERAL_TO_MEMORY;
  dma_init_struct.memory_base_addr = (uint32_t)g_dma_rx;
  dma_init_struct.memory_data_width = DMA_MEMORY_DATA_WIDTH_BYTE;
  dma_init_struct.memory_inc_enable = TRUE;
  dma_init_struct.peripheral_base_addr = (uint32_t)&(SPI3->dt);
  dma_init_struct.peripheral_data_width = DMA_PERIPHERAL_DATA_WIDTH_BYTE;
  dma_init_struct.peripheral_inc_enable = FALSE;
  dma_init_struct.priority = DMA_PRIORITY_HIGH;
  dma_init_struct.loop_mode_enable = FALSE;

  dma_init(LSM6DS3_DMA_RX_CHANNEL, &dma_init_struct);

  dma_flexible_config(
      DMA1,
      FLEX_CHANNEL3,
      DMA_FLEXIBLE_SPI3_RX);


  /* TX : RAM -> SPI3 */
  dma_reset(LSM6DS3_DMA_TX_CHANNEL);

  dma_default_para_init(&dma_init_struct);

  dma_init_struct.buffer_size = LSM6DS3_DMA_SIZE;
  dma_init_struct.direction = DMA_DIR_MEMORY_TO_PERIPHERAL;
  dma_init_struct.memory_base_addr = (uint32_t)g_dma_tx;
  dma_init_struct.memory_data_width = DMA_MEMORY_DATA_WIDTH_BYTE;
  dma_init_struct.memory_inc_enable = TRUE;
  dma_init_struct.peripheral_base_addr = (uint32_t)&(SPI3->dt);
  dma_init_struct.peripheral_data_width = DMA_PERIPHERAL_DATA_WIDTH_BYTE;
  dma_init_struct.peripheral_inc_enable = FALSE;
  dma_init_struct.priority = DMA_PRIORITY_HIGH;
  dma_init_struct.loop_mode_enable = FALSE;

  dma_init(LSM6DS3_DMA_TX_CHANNEL, &dma_init_struct);

  dma_flexible_config(
      DMA1,
      FLEX_CHANNEL4,
      DMA_FLEXIBLE_SPI3_TX);


  dma_interrupt_enable(
      LSM6DS3_DMA_RX_CHANNEL,
      DMA_FDT_INT,
      TRUE);

  dma_interrupt_enable(
      LSM6DS3_DMA_RX_CHANNEL,
      DMA_DTERR_INT,
      TRUE);

  dma_interrupt_enable(
      LSM6DS3_DMA_TX_CHANNEL,
      DMA_FDT_INT,
      TRUE);

  dma_interrupt_enable(
      LSM6DS3_DMA_TX_CHANNEL,
      DMA_DTERR_INT,
      TRUE);
}


void lsm6ds3trc_dma_init(void)
{
  memset(g_dma_tx, 0, sizeof(g_dma_tx));
  memset(g_dma_rx, 0, sizeof(g_dma_rx));
  memset(g_last_raw, 0, sizeof(g_last_raw));
  memset(&g_latest_data, 0, sizeof(g_latest_data));

  g_dma_busy = 0U;
  g_dma_rx_done = 0U;
  g_dma_tx_done = 0U;
  g_dma_error = 0U;
  g_result_ready = 0U;

  g_dma_irq_count = 0U;
  g_dma_error_count = 0U;

  crm_periph_clock_enable(
      CRM_DMA1_PERIPH_CLOCK,
      TRUE);

  nvic_irq_enable(
      LSM6DS3_DMA_RX_IRQn,
      0,
      0);

  nvic_irq_enable(
      LSM6DS3_DMA_TX_IRQn,
      0,
      0);

  /*
   * Keep SPI DMA requests disabled while idle.
   */
  spi_i2s_dma_receiver_enable(SPI3, FALSE);
  spi_i2s_dma_transmitter_enable(SPI3, FALSE);
}


uint8_t lsm6ds3trc_start_6axis_dma(void)
{
  uint32_t i;

  if(g_dma_busy != 0U)
  {
    return 0U;
  }

  lsm6ds3_dma_prepare();

  for(i = 0U; i < LSM6DS3_DMA_SIZE; i++)
  {
    g_dma_tx[i] = 0x00U;
    g_dma_rx[i] = 0x00U;
  }

  g_dma_busy = 1U;
  g_dma_rx_done = 0U;
  g_dma_tx_done = 0U;
  g_dma_error = 0U;

  dma_flag_clear(DMA1_FDT3_FLAG);
  dma_flag_clear(DMA1_DTERR3_FLAG);
  dma_flag_clear(DMA1_FDT4_FLAG);
  dma_flag_clear(DMA1_DTERR4_FLAG);

  /*
   * Command phase uses the exact same SPI transfer helper
   * as the known-good polling driver.
   */
  LSM6DS3_CS_LOW();

  (void)spi3_transfer(
      LSM6DS3_OUTX_L_G | 0x80U);

  /*
   * Only the twelve payload bytes use DMA.
   */
  spi_i2s_dma_receiver_enable(SPI3, TRUE);
  spi_i2s_dma_transmitter_enable(SPI3, TRUE);

  dma_channel_enable(
      LSM6DS3_DMA_RX_CHANNEL,
      TRUE);

  dma_channel_enable(
      LSM6DS3_DMA_TX_CHANNEL,
      TRUE);

  return 1U;
}


void lsm6ds3trc_process(void)
{
  const uint8_t *raw;

  if(g_dma_error != 0U)
  {
    g_dma_error = 0U;

    spi_i2s_dma_receiver_enable(SPI3, FALSE);
    spi_i2s_dma_transmitter_enable(SPI3, FALSE);

    LSM6DS3_CS_HIGH();

    g_dma_busy = 0U;

    return;
  }

  if((g_dma_rx_done != 0U) &&
     (g_dma_tx_done != 0U))
  {
    g_dma_rx_done = 0U;
    g_dma_tx_done = 0U;

    spi_i2s_dma_receiver_enable(SPI3, FALSE);
    spi_i2s_dma_transmitter_enable(SPI3, FALSE);

    LSM6DS3_CS_HIGH();

    memcpy(g_last_raw, g_dma_rx, LSM6DS3_DMA_SIZE);

    raw = g_dma_rx;

    g_latest_data.gx =
        (int16_t)(((uint16_t)raw[1] << 8) | raw[0]);

    g_latest_data.gy =
        (int16_t)(((uint16_t)raw[3] << 8) | raw[2]);

    g_latest_data.gz =
        (int16_t)(((uint16_t)raw[5] << 8) | raw[4]);

    g_latest_data.ax =
        (int16_t)(((uint16_t)raw[7] << 8) | raw[6]);

    g_latest_data.ay =
        (int16_t)(((uint16_t)raw[9] << 8) | raw[8]);

    g_latest_data.az =
        (int16_t)(((uint16_t)raw[11] << 8) | raw[10]);

    g_result_ready = 1U;
    g_dma_busy = 0U;
  }
}


uint8_t lsm6ds3trc_get_6axis(
    lsm6ds3trc_data_type *data)
{
  if(data == 0)
  {
    return 0U;
  }

  if(g_result_ready == 0U)
  {
    return 0U;
  }

  *data = g_latest_data;

  g_result_ready = 0U;

  return 1U;
}


uint8_t lsm6ds3trc_is_busy(void)
{
  return g_dma_busy;
}


void lsm6ds3trc_get_last_raw(uint8_t raw[12])
{
  if(raw == 0)
  {
    return;
  }

  memcpy(raw, g_last_raw, LSM6DS3_DMA_SIZE);
}


/* =========================================================================================
 * DMA IRQ
 * ========================================================================================= */

void lsm6ds3trc_dma_rx_irq_handler(void)
{
  if(dma_flag_get(DMA1_FDT3_FLAG) != RESET)
  {
    dma_flag_clear(DMA1_FDT3_FLAG);

    dma_channel_enable(
        LSM6DS3_DMA_RX_CHANNEL,
        FALSE);

    g_dma_rx_done = 1U;
    g_dma_irq_count++;
  }

  if(dma_flag_get(DMA1_DTERR3_FLAG) != RESET)
  {
    dma_flag_clear(DMA1_DTERR3_FLAG);

    dma_channel_enable(
        LSM6DS3_DMA_RX_CHANNEL,
        FALSE);

    g_dma_error = 1U;
    g_dma_error_count++;
  }
}


void lsm6ds3trc_dma_tx_irq_handler(void)
{
  if(dma_flag_get(DMA1_FDT4_FLAG) != RESET)
  {
    dma_flag_clear(DMA1_FDT4_FLAG);

    dma_channel_enable(
        LSM6DS3_DMA_TX_CHANNEL,
        FALSE);

    g_dma_tx_done = 1U;
    g_dma_irq_count++;
  }

  if(dma_flag_get(DMA1_DTERR4_FLAG) != RESET)
  {
    dma_flag_clear(DMA1_DTERR4_FLAG);

    dma_channel_enable(
        LSM6DS3_DMA_TX_CHANNEL,
        FALSE);

    g_dma_error = 1U;
    g_dma_error_count++;
  }
}


void DMA1_Channel3_IRQHandler(void)
{
  lsm6ds3trc_dma_rx_irq_handler();
}


void DMA1_Channel4_IRQHandler(void)
{
  lsm6ds3trc_dma_tx_irq_handler();
}


/* =========================================================================================
 * Counters
 * ========================================================================================= */

uint32_t lsm6ds3trc_get_dma_irq_count(void)
{
  return g_dma_irq_count;
}


uint32_t lsm6ds3trc_get_dma_error_count(void)
{
  return g_dma_error_count;
}

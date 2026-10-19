#include "ICS43434.h"
#include "ht32f493x5_board.h"
#include "ht32f493x5_clock.h"
#include <stdint.h>

#define MIC_DMA_HALFWORDS          4096U
#define MIC_DMA_HALF_SIZE          (MIC_DMA_HALFWORDS / 2U)
#define MIC_DMA_CHANNEL            DMA1_CHANNEL4
#define MIC_DMA_IRQn               DMA1_Channel4_IRQn
#define MIC_DECIMATION             6U
#define MIC_DC_SHIFT               8U

static uint16_t g_i2s_dma_buffer[MIC_DMA_HALFWORDS];
static volatile uint8_t g_half0_ready = 0U;
static volatile uint8_t g_half1_ready = 0U;
static volatile uint32_t g_dma_irq_count = 0U;
static volatile uint32_t g_dma_overrun_count = 0U;
static volatile uint32_t g_dma_error_count = 0U;

static uint8_t g_next_half = 0U;
static uint8_t g_running = 0U;
static ICS43434_channel_type g_channel = ICS43434_CHANNEL_RIGHT;

static int32_t g_dc = 0;
static int32_t g_decimation_sum = 0;
static uint8_t g_decimation_count = 0U;

static void mic_gpio_config(void)
{
  gpio_init_type gpio;

  crm_periph_clock_enable(CRM_GPIOB_PERIPH_CLOCK, TRUE);
  crm_periph_clock_enable(CRM_IOMUX_PERIPH_CLOCK, TRUE);
  gpio_default_para_init(&gpio);

  gpio.gpio_out_type = GPIO_OUTPUT_PUSH_PULL;
  gpio.gpio_pull = GPIO_PULL_UP;
  gpio.gpio_mode = GPIO_MODE_MUX;
  gpio.gpio_drive_strength = GPIO_DRIVE_STRENGTH_STRONGER;
  gpio.gpio_pins = GPIO_PINS_12;
  gpio_init(GPIOB, &gpio);

  gpio.gpio_out_type = GPIO_OUTPUT_PUSH_PULL;
  gpio.gpio_pull = GPIO_PULL_DOWN;
  gpio.gpio_mode = GPIO_MODE_MUX;
  gpio.gpio_drive_strength = GPIO_DRIVE_STRENGTH_STRONGER;
  gpio.gpio_pins = GPIO_PINS_13;
  gpio_init(GPIOB, &gpio);

  gpio.gpio_mode = GPIO_MODE_INPUT;
  gpio.gpio_pull = GPIO_PULL_NONE;
  gpio.gpio_pins = GPIO_PINS_15;
  gpio_init(GPIOB, &gpio);
}

static void mic_i2s_config(void)
{
  i2s_init_type cfg;

  crm_periph_clock_enable(CRM_SPI2_PERIPH_CLOCK, TRUE);
  spi_i2s_reset(SPI2);
  i2s_default_para_init(&cfg);

  cfg.audio_protocol = I2S_AUDIO_PROTOCOL_PHILLIPS;
  cfg.data_channel_format = I2S_DATA_24BIT_CHANNEL_32BIT;
  cfg.mclk_output_enable = FALSE;
  cfg.audio_sampling_freq = I2S_AUDIO_FREQUENCY_48K;
  cfg.clock_polarity = I2S_CLOCK_POLARITY_LOW;
  cfg.operation_mode = I2S_MODE_MASTER_RX;

  i2s_init(SPI2, &cfg);
  spi_i2s_dma_receiver_enable(SPI2, TRUE);
}

static void mic_dma_config(void)
{
  dma_init_type dma;

  crm_periph_clock_enable(CRM_DMA1_PERIPH_CLOCK, TRUE);
  dma_reset(MIC_DMA_CHANNEL);
  dma_default_para_init(&dma);

  dma.buffer_size = MIC_DMA_HALFWORDS;
  dma.direction = DMA_DIR_PERIPHERAL_TO_MEMORY;
  dma.memory_base_addr = (uint32_t)g_i2s_dma_buffer;
  dma.memory_data_width = DMA_MEMORY_DATA_WIDTH_HALFWORD;
  dma.memory_inc_enable = TRUE;
  dma.peripheral_base_addr = (uint32_t)&(SPI2->dt);
  dma.peripheral_data_width = DMA_PERIPHERAL_DATA_WIDTH_HALFWORD;
  dma.peripheral_inc_enable = FALSE;
  dma.priority = DMA_PRIORITY_HIGH;
  dma.loop_mode_enable = TRUE;

  dma_init(MIC_DMA_CHANNEL, &dma);

  dma_flexible_config(
      DMA1,
      FLEX_CHANNEL4,
      DMA_FLEXIBLE_SPI2_RX);

  dma_interrupt_enable(MIC_DMA_CHANNEL, DMA_HDT_INT, TRUE);
  dma_interrupt_enable(MIC_DMA_CHANNEL, DMA_FDT_INT, TRUE);
  dma_interrupt_enable(MIC_DMA_CHANNEL, DMA_DTERR_INT, TRUE);

  dma_flag_clear(DMA1_HDT4_FLAG);
  dma_flag_clear(DMA1_FDT4_FLAG);
  dma_flag_clear(DMA1_DTERR4_FLAG);

  nvic_irq_enable(MIC_DMA_IRQn, 0, 0);
}

static int32_t mic_24bit_to_s32(uint16_t msb, uint16_t lsb)
{
  uint32_t raw;

  raw = ((uint32_t)msb << 8) | ((uint32_t)lsb >> 8);

  if((raw & 0x00800000UL) != 0U)
  {
    raw |= 0xFF000000UL;
  }

  return (int32_t)raw;
}

static int16_t clip_i16(int32_t value)
{
  if(value > 32767)
  {
    return 32767;
  }

  if(value < -32768)
  {
    return -32768;
  }

  return (int16_t)value;
}

static uint8_t get_ready_dma_half(
    const uint16_t **buffer,
    uint32_t *halfwords)
{
  if((buffer == 0) || (halfwords == 0))
  {
    return 0U;
  }

  if(g_next_half == 0U)
  {
    if(g_half0_ready != 0U)
    {
      g_half0_ready = 0U;
      *buffer = &g_i2s_dma_buffer[0];
      *halfwords = MIC_DMA_HALF_SIZE;
      g_next_half = 1U;
      return 1U;
    }

    if(g_half1_ready != 0U)
    {
      g_half1_ready = 0U;
      *buffer = &g_i2s_dma_buffer[MIC_DMA_HALF_SIZE];
      *halfwords = MIC_DMA_HALF_SIZE;
      g_next_half = 0U;
      return 1U;
    }
  }
  else
  {
    if(g_half1_ready != 0U)
    {
      g_half1_ready = 0U;
      *buffer = &g_i2s_dma_buffer[MIC_DMA_HALF_SIZE];
      *halfwords = MIC_DMA_HALF_SIZE;
      g_next_half = 0U;
      return 1U;
    }

    if(g_half0_ready != 0U)
    {
      g_half0_ready = 0U;
      *buffer = &g_i2s_dma_buffer[0];
      *halfwords = MIC_DMA_HALF_SIZE;
      g_next_half = 1U;
      return 1U;
    }
  }

  return 0U;
}

void ICS43434_init(void)
{
  g_half0_ready = 0U;
  g_half1_ready = 0U;
  g_dma_irq_count = 0U;
  g_dma_overrun_count = 0U;
  g_dma_error_count = 0U;
  g_next_half = 0U;
  g_running = 0U;
  g_channel = ICS43434_CHANNEL_RIGHT;
  g_dc = 0;
  g_decimation_sum = 0;
  g_decimation_count = 0U;

  mic_gpio_config();
  mic_i2s_config();
  mic_dma_config();
}

void ICS43434_start(void)
{
  if(g_running != 0U)
  {
    return;
  }

  g_half0_ready = 0U;
  g_half1_ready = 0U;
  g_next_half = 0U;
  g_dc = 0;
  g_decimation_sum = 0;
  g_decimation_count = 0U;

  dma_flag_clear(DMA1_HDT4_FLAG);
  dma_flag_clear(DMA1_FDT4_FLAG);
  dma_flag_clear(DMA1_DTERR4_FLAG);

  dma_channel_enable(MIC_DMA_CHANNEL, TRUE);
  i2s_enable(SPI2, TRUE);
  g_running = 1U;
}

void ICS43434_stop(void)
{
  i2s_enable(SPI2, FALSE);
  dma_channel_enable(MIC_DMA_CHANNEL, FALSE);
  g_running = 0U;
}

void ICS43434_set_channel(ICS43434_channel_type channel)
{
  g_channel = channel;
  g_dc = 0;
  g_decimation_sum = 0;
  g_decimation_count = 0U;
}

uint32_t ICS43434_read_pcm16(
    int16_t *pcm_buffer,
    uint32_t max_samples)
{
  const uint16_t *raw_buffer;
  uint32_t raw_halfwords;
  uint32_t channel_offset;
  uint32_t frame;
  uint32_t out_count = 0U;
  int32_t sample24;
  int32_t sample16;

  if((pcm_buffer == 0) || (max_samples == 0U))
  {
    return 0U;
  }

  if(get_ready_dma_half(&raw_buffer, &raw_halfwords) == 0U)
  {
    return 0U;
  }

  channel_offset =
      (g_channel == ICS43434_CHANNEL_LEFT) ? 0U : 2U;

  /*
   * Process every input frame.
   *
   * The 6-sample accumulator persists across DMA half-buffer boundaries,
   * so no periodic input frames are discarded.
   */
  for(frame = 0U;
      (frame + channel_offset + 1U) < raw_halfwords;
      frame += 4U)
  {
    sample24 =
        mic_24bit_to_s32(
            raw_buffer[frame + channel_offset],
            raw_buffer[frame + channel_offset + 1U]);

    sample16 = sample24 >> 8;

    g_decimation_sum += sample16;
    g_decimation_count++;

    if(g_decimation_count == MIC_DECIMATION)
    {
      sample16 =
          g_decimation_sum /
          (int32_t)MIC_DECIMATION;

      g_decimation_sum = 0;
      g_decimation_count = 0U;

      g_dc +=
          (sample16 - g_dc) >>
          MIC_DC_SHIFT;

      sample16 -= g_dc;

      if(out_count < max_samples)
      {
        pcm_buffer[out_count] =
            clip_i16(sample16);

        out_count++;
      }
    }
  }

  return out_count;
}

void ICS43434_dma_irq_handler(void)
{
  if(dma_flag_get(DMA1_HDT4_FLAG) != RESET)
  {
    dma_flag_clear(DMA1_HDT4_FLAG);

    if(g_half0_ready != 0U)
    {
      g_dma_overrun_count++;
    }

    g_half0_ready = 1U;
    g_dma_irq_count++;
  }

  if(dma_flag_get(DMA1_FDT4_FLAG) != RESET)
  {
    dma_flag_clear(DMA1_FDT4_FLAG);

    if(g_half1_ready != 0U)
    {
      g_dma_overrun_count++;
    }

    g_half1_ready = 1U;
    g_dma_irq_count++;
  }

  if(dma_flag_get(DMA1_DTERR4_FLAG) != RESET)
  {
    dma_flag_clear(DMA1_DTERR4_FLAG);
    g_dma_error_count++;
  }
}

void DMA1_Channel4_IRQHandler(void)
{
  ICS43434_dma_irq_handler();
}

uint32_t ICS43434_get_dma_irq_count(void)
{
  return g_dma_irq_count;
}

uint32_t ICS43434_get_overrun_count(void)
{
  return g_dma_overrun_count;
}

uint32_t ICS43434_get_dma_error_count(void)
{
  return g_dma_error_count;
}

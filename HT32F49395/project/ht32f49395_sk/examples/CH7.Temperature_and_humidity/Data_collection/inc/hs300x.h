#ifndef __HS3003_H
#define __HS3003_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define HS3003_STATUS_VALID    0U
#define HS3003_STATUS_STALE    1U

typedef struct
{
  uint8_t raw_bytes[4];

  uint8_t  status;
  uint16_t raw_humidity;
  uint16_t raw_temperature;

  uint32_t humidity_x100;
  int32_t  temperature_x100;

} hs3003_result_type;

/*
 * Initialize:
 *   I2C1
 *   PB8 = SCL
 *   PB9 = SDA
 *   DMA1 CH6 = I2C1 TX
 *   DMA1 CH7 = I2C1 RX
 *   I2C EVT / ERR interrupt
 *   DMA TX / RX interrupt
 */
void hs3003_init(void);

/*
 * Start one measurement without waiting for completion.
 *
 * now_ms:
 *   current 1 ms system tick.
 *
 * return:
 *   1 = request accepted
 *   0 = driver busy
 */
uint8_t hs3003_start_async(uint32_t now_ms);

/*
 * Non-blocking service function.
 *
 * Call repeatedly from main/task.
 * It never waits in a while-loop.
 */
void hs3003_process(uint32_t now_ms);

/*
 * Read one completed result.
 *
 * return:
 *   1 = new result copied to *result
 *   0 = no new result
 */
uint8_t hs3003_get_result(hs3003_result_type *result);

/* 1 = acquisition in progress */
uint8_t hs3003_is_busy(void);

/*
 * Return and clear the latest driver error.
 *
 * 0 = no error.
 */
uint32_t hs3003_take_error(void);

/*
 * ISR notification hooks.
 *
 * Call these AFTER the Holtek i2c_application IRQ handler.
 */
void hs3003_dma_rx_irq_notify(void);
void hs3003_i2c_error_irq_notify(void);

#ifdef __cplusplus
}
#endif

#endif

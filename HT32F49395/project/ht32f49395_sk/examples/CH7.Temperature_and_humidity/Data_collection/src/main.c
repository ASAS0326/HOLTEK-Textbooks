/*********************************************************************************************************//**
 * @file    main.c
 * @brief   HT32F49395 + HS3003 DMA/Interrupt non-blocking acquisition test
 ************************************************************************************************************/

#include "ht32f493x5_board.h"
#include "ht32f493x5_clock.h"
#include "hs300x.h"

#include <stdio.h>
#include <stdint.h>


/*
 * Sampling interval:
 *
 * 5000 ms = 5 seconds
 */
#define SAMPLE_INTERVAL_MS       (5000UL)


extern volatile uint32_t g_hs3003_tick_ms;


/* =========================================================================================
 * Time Helper
 * ========================================================================================= */

static uint8_t time_reached(uint32_t now_ms,
                            uint32_t target_ms)
{
  if((int32_t)(now_ms - target_ms) >= 0)
  {
    return 1U;
  }

  return 0U;
}


/* =========================================================================================
 * Main
 * ========================================================================================= */

int main(void)
{
  hs3003_result_type hs3003;

  uint32_t now_ms;
  uint32_t next_sample_ms;
  uint32_t error_code;

  /*
   * Same as HT32F67595 DATA counter.
   */
  uint32_t sample_count = 0U;


  nvic_priority_group_config(
      NVIC_PRIORITY_GROUP_4);


  system_clock_config();

  ht32_board_init();


  uart_print_init(115200);


  /*
   * Start message.
   *
   * Keep this similar to the 67595 project.
   */
  printf("HS300x Data Logger Start\r\n");


  /*
   * Initialize:
   *
   * I2C1
   * PB8 = SCL
   * PB9 = SDA
   *
   * DMA1 CH6 = TX
   * DMA1 CH7 = RX
   *
   * I2C EVT / ERR interrupt
   * DMA TX / RX interrupt
   */
  hs3003_init();


  /*
   * ht32_board_init()/hs3003_init() may use the original
   * blocking delay_ms().
   *
   * Configure the permanent 1 ms SysTick only after
   * initialization.
   *
   * Do not call delay_ms() after this point.
   */
  g_hs3003_tick_ms = 0U;


  if(SysTick_Config(
         system_core_clock /
         1000U) != 0U)
  {
    printf("ERROR: SysTick_Config\r\n");

    while(1)
    {
    }
  }


  /*
   * First sample starts immediately.
   */
  next_sample_ms =
      g_hs3003_tick_ms;


  while(1)
  {
    now_ms =
        g_hs3003_tick_ms;


    /*
     * Advance non-blocking HS3003 state machine.
     */
    hs3003_process(now_ms);


    /*
     * Start a new measurement when:
     *
     * 1. HS3003 is idle
     * 2. Sample interval has arrived
     */
    if((hs3003_is_busy() == 0U) &&
       (time_reached(
            now_ms,
            next_sample_ms) != 0U))
    {
      if(hs3003_start_async(
             now_ms) != 0U)
      {
        next_sample_ms =
            now_ms +
            SAMPLE_INTERVAL_MS;
      }
    }


    /*
     * Read completed DMA result.
     */
    if(hs3003_get_result(
           &hs3003) != 0U)
    {
      if(hs3003.status ==
         HS3003_STATUS_VALID)
      {
        int32_t temperature;
        uint32_t humidity;

        uint32_t temp_integer;
        uint32_t temp_decimal;

        uint32_t humidity_integer;
        uint32_t humidity_decimal;

        uint8_t temperature_negative;


        /*
         * Raw values are x100:
         *
         * temperature_x100 = 2542
         * -> 25.42 C
         *
         * humidity_x100 = 6015
         * -> 60.15 %
         */
        temperature =
            hs3003.temperature_x100;

        humidity =
            hs3003.humidity_x100;


        /*
         * Handle negative temperature.
         */
        if(temperature < 0)
        {
          temperature_negative = 1U;

          temperature =
              -temperature;
        }
        else
        {
          temperature_negative = 0U;
        }


        /*
         * Split temperature x100.
         */
        temp_integer =
            (uint32_t)temperature /
            100U;

        temp_decimal =
            (uint32_t)temperature %
            100U;


        /*
         * Split humidity x100.
         */
        humidity_integer =
            humidity /
            100U;

        humidity_decimal =
            humidity %
            100U;


        /*
         * Same sample counter behaviour as HT32F67595.
         */
        sample_count++;


        /*
         * ====================================================
         * Output format compatible with HT32F67595
         * ====================================================
         *
         * DATA,sample,T,RH
         *
         * Example:
         *
         * DATA,1,25.42,60.15
         * DATA,2,25.43,60.20
         *
         * This allows the same Python data_logger.py
         * to receive data from both boards.
         */

        if(temperature_negative != 0U)
        {
          printf(
              "DATA,%lu,-%lu.%02lu,%lu.%02lu\r\n",
              (unsigned long)sample_count,
              (unsigned long)temp_integer,
              (unsigned long)temp_decimal,
              (unsigned long)humidity_integer,
              (unsigned long)humidity_decimal
          );
        }
        else
        {
          printf(
              "DATA,%lu,%lu.%02lu,%lu.%02lu\r\n",
              (unsigned long)sample_count,
              (unsigned long)temp_integer,
              (unsigned long)temp_decimal,
              (unsigned long)humidity_integer,
              (unsigned long)humidity_decimal
          );
        }
      }
      else
      {
        printf(
            "ERROR,HS3003_STATUS,%u\r\n",
            (unsigned int)hs3003.status
        );
      }
    }


    /*
     * Check driver error.
     */
    error_code =
        hs3003_take_error();


    if(error_code != 0U)
    {
      printf(
          "ERROR,I2C,%lu\r\n",
          (unsigned long)error_code
      );
    }


    /*
     * CPU sleeps instead of polling.
     *
     * Wake sources:
     *
     * - SysTick
     * - DMA RX/TX IRQ
     * - I2C EVT/ERR IRQ
     */
    __WFI();
  }
}
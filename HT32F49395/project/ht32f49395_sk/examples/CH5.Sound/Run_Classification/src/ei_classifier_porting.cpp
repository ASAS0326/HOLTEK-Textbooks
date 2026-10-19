/*
 * Copyright (c) 2023 EdgeImpulse Inc.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include "edge-impulse-sdk/porting/ei_classifier_porting.h"

#include "ht32f493x5_board.h"
#include "ht32f493x5_clock.h"
#include "ht32f493x5_int.h"

#include <math.h>
#include <stdarg.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


extern "C" uint32_t SysTick_GetTick(void);


typedef enum
{
  HT_OK = 0,
  HT_ERROR = 1,
  HT_TIMEOUT = 3

} HT_StatusTypeDef;


HT_StatusTypeDef HT_UART_Transmit(const uint8_t *pData,
                                 uint16_t Size,
                                 uint32_t Timeout)
{
  uint32_t tickstart;


  if((pData == NULL) ||
     (Size == 0U))
  {
    return HT_ERROR;
  }


  tickstart =
      SysTick_GetTick();


  while(Size != 0U)
  {
    while(usart_flag_get(
              PRINT_UART,
              USART_TDBE_FLAG) == RESET)
    {
      if((uint32_t)(
           SysTick_GetTick() -
           tickstart) >= Timeout)
      {
        return HT_TIMEOUT;
      }
    }


    usart_data_transmit(
        PRINT_UART,
        *pData);

    pData++;
    Size--;
  }


  tickstart =
      SysTick_GetTick();


  while(usart_flag_get(
            PRINT_UART,
            USART_TDC_FLAG) == RESET)
  {
    if((uint32_t)(
         SysTick_GetTick() -
         tickstart) >= Timeout)
    {
      return HT_TIMEOUT;
    }
  }


  return HT_OK;
}


__attribute__((weak))
EI_IMPULSE_ERROR
ei_run_impulse_check_canceled()
{
  return EI_IMPULSE_OK;
}


__attribute__((weak))
EI_IMPULSE_ERROR
ei_sleep(int32_t time_ms)
{
  uint32_t start_ms;


  if(time_ms <= 0)
  {
    return EI_IMPULSE_OK;
  }


  start_ms =
      SysTick_GetTick();


  while((uint32_t)(
          SysTick_GetTick() -
          start_ms) <
        (uint32_t)time_ms)
  {
    __WFI();
  }


  return EI_IMPULSE_OK;
}


uint64_t ei_read_timer_ms()
{
  return
      (uint64_t)SysTick_GetTick();
}


uint64_t ei_read_timer_us()
{
  return
      (uint64_t)SysTick_GetTick() *
      1000ULL;
}


__attribute__((weak))
void ei_printf(const char *format, ...)
{
  char buffer[1024] = {0};

  int length;

  va_list args;


  va_start(
      args,
      format);


  length =
      vsnprintf(
          buffer,
          sizeof(buffer),
          format,
          args);


  va_end(
      args);


  if(length > 0)
  {
    if(length >
       (int)sizeof(buffer))
    {
      length =
          (int)sizeof(buffer);
    }


    HT_UART_Transmit(
        (const uint8_t *)buffer,
        (uint16_t)length,
        5000U);
  }
}


__attribute__((weak))
void ei_printf_float(float f)
{
  char buffer[32];


  snprintf(
      buffer,
      sizeof(buffer),
      "%.5f",
      f);


  ei_printf(
      "%s",
      buffer);
}


__attribute__((weak))
void *ei_malloc(size_t size)
{
  return malloc(
      size);
}


__attribute__((weak))
void *ei_calloc(size_t nitems,
                size_t size)
{
  return calloc(
      nitems,
      size);
}


__attribute__((weak))
void ei_free(void *ptr)
{
  free(
      ptr);
}


#if defined(__cplusplus) && EI_C_LINKAGE == 1
extern "C"
#endif
__attribute__((weak))
void DebugLog(const char *s)
{
  ei_printf(
      "%s",
      s);
}

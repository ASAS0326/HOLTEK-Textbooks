/**
  *************************************************************************************************************
  * @file     main.c
  * @version $Rev:: 36          $
  * @date    $Date:: 2023-04-25 #$
  * @brief    main program
  *************************************************************************************************************
  *
  * Firmware Disclaimer Information
  *
  * 1. The customer hereby acknowledges and agrees that the program technical documentation, including the
  *    code, which is supplied by Holtek Semiconductor Inc., (hereinafter referred to as "HOLTEK") is the
  *    proprietary and confidential intellectual property of HOLTEK, and is protected by copyright law and
  *    other intellectual property laws.
  *
  * 2. The customer hereby acknowledges and agrees that the program technical documentation, including the
  *    code, is confidential information belonging to HOLTEK, and must not be disclosed to any third parties
  *    other than HOLTEK and the customer.
  *
  * 3. The program technical documentation, including the code, is provided "as is" and for customer reference
  *    only. After delivery by HOLTEK, the customer shall use the program technical documentation, including
  *    the code, at their own risk. HOLTEK disclaims any expressed, implied or statutory warranties, including
  *    the warranties of merchantability, satisfactory quality and fitness for a particular purpose.
  *
  * <h2><center>Copyright (C) Holtek Semiconductor Inc. All rights reserved</center></h2>
  ************************************************************************************************************
  */

#include "ht32f493x5_board.h"
#include "ht32f493x5_clock.h"
#include "FreeRTOS.h"
#include "task.h"

/** @addtogroup UTILITIES_examples
  * @{
  */

/** @addtogroup FreeRTOS_demo
  * @{
  */
TaskHandle_t led2_handler;
TaskHandle_t led3_handler;

/* led2 task */
void led2_task_function(void *pvParameters);
/* led3 task */
void led3_task_function(void *pvParameters);

/**
  * @brief  main function.
  * @param  none
  * @retval none
  */
int main(void)
{
  nvic_priority_group_config(NVIC_PRIORITY_GROUP_4);

  system_clock_config();

  /* init led2 and led3 */
  ht32_led_init(LED2);
  ht32_led_init(LED3);

  /* init usart1 */
  uart_print_init(115200);

  /* enter critical */
  taskENTER_CRITICAL();

  /* create led2 task */
  if(xTaskCreate((TaskFunction_t )led2_task_function,
                 (const char*    )"LED2_task",
                 (uint16_t       )512,
                 (void*          )NULL,
                 (UBaseType_t    )2,
                 (TaskHandle_t*  )&led2_handler) != pdPASS)
  {
    printf("LED2 task could not be created as there was insufficient heap memory remaining.\r\n");
  }
  else
  {
    printf("LED2 task was created successfully.\r\n");
  }
  /* create led3 task */
  if(xTaskCreate((TaskFunction_t )led3_task_function,
                 (const char*    )"LED3_task",
                 (uint16_t       )512,
                 (void*          )NULL,
                 (UBaseType_t    )2,
                 (TaskHandle_t*  )&led3_handler) != pdPASS)
  {
    printf("LED3 task could not be created as there was insufficient heap memory remaining.\r\n");
  }
  else
  {
    printf("LED3 task was created successfully.\r\n");
  }

  /* exit critical */
  taskEXIT_CRITICAL();

  /* start scheduler */
  vTaskStartScheduler();
}

/* led2 task function */
void led2_task_function(void *pvParameters)
{
  while(1)
  {
    ht32_led_toggle(LED2);
    vTaskDelay(1000);
  }
}

/* led3 task function */
void led3_task_function(void *pvParameters)
{
  while(1)
  {
    ht32_led_toggle(LED3);
    vTaskDelay(500);
  }
}

/**
  * @}
  */

/**
  * @}
  */

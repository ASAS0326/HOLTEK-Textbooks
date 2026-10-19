/**
  *************************************************************************************************************
  * @file     include_port.c
  * @version $Rev:: 4           $
  * @date    $Date:: 2023-01-17 #$
  * @brief    include_port program
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

/** @addtogroup UTILITIES_examples
  * @{
  */

/** @addtogroup FreeRTOS_demo
  * @{
  */

/* support ac5 and ac6 compiler */
#if (__ARMCC_VERSION > 6000000)

#include "..\..\..\middlewares\freertos\source\portable\GCC\ARM_CM4F\port.c"

#else

#include "..\..\..\middlewares\freertos\source\portable\rvds\ARM_CM4F\port.c"

#endif

/**
  * @}
  */

/**
  * @}
  */

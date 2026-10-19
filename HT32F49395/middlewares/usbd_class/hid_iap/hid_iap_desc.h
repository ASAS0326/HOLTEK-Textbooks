/**
  *************************************************************************************************************
  * @file     hid_iap_desc.h
  * @version $Rev:: 3           $
  * @date    $Date:: 2023-01-17 #$
  * @brief    usb hid descriptor header file
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

/* define to prevent recursive inclusion -------------------------------------*/
#ifndef __HID_IAP_DESC_H
#define __HID_IAP_DESC_H

#ifdef __cplusplus
extern "C" {
#endif

#include "hid_iap_class.h"
#include "usbd_core.h"

/** @addtogroup HT32F493x5_middlewares_usbd_class
  * @{
  */

/** @addtogroup USB_hid_iap_desc
  * @{
  */

/** @defgroup USB_hid_iap_desc_definition
  * @{
  */


#define HIDIAP_BCD_NUM                   0x0110

#define USBD_HIDIAP_VENDOR_ID            0x04D9
#define USBD_HIDIAP_PRODUCT_ID           0x9008

#define USBD_HIDIAP_CONFIG_DESC_SIZE     41
#define USBD_HIDIAP_SIZ_REPORT_DESC      32
#define USBD_HIDIAP_SIZ_STRING_LANGID    4
#define USBD_HIDIAP_SIZ_STRING_SERIAL    0x1A

#define USBD_HIDIAP_DESC_MANUFACTURER_STRING    "Holtek"
#define USBD_HIDIAP_DESC_PRODUCT_STRING         "HID IAP"
#define USBD_HIDIAP_DESC_CONFIGURATION_STRING   "HID IAP Config"
#define USBD_HIDIAP_DESC_INTERFACE_STRING       "HID IAP Interface"

#define HIDIAP_BINTERVAL_TIME                0x01

#define         MCU_ID1                   (0x1FFFF7E8)
#define         MCU_ID2                   (0x1FFFF7EC)
#define         MCU_ID3                   (0x1FFFF7F0)
extern uint8_t g_usbd_hidiap_report[USBD_HIDIAP_SIZ_REPORT_DESC];
extern uint8_t g_hidiap_usb_desc[9];

extern usbd_desc_handler hid_iap_desc_handler;


/**
  * @}
  */

/**
  * @}
  */


/**
  * @}
  */
#ifdef __cplusplus
}
#endif

#endif


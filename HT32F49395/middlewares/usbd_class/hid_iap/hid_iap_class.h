/**
  *************************************************************************************************************
  * @file     hid_iap_class.h
  * @version $Rev:: 3           $
  * @date    $Date:: 2023-01-17 #$
  * @brief    usb hid iap header file
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
#ifndef __HID_IAP_CLASS_H
#define __HID_IAP_CLASS_H

#ifdef __cplusplus
extern "C" {
#endif

#include "usb_std.h"
#include "usbd_core.h"


/** @addtogroup HT32F493x5_middlewares_usbd_class
  * @{
  */

/** @addtogroup USB_hid_iap_class
  * @{
  */

/** @defgroup USB_hid_iap_class_definition
  * @{
  */


#define USBD_HIDIAP_IN_EPT                  0x81
#define USBD_HIDIAP_OUT_EPT                 0x01

#define USBD_HIDIAP_IN_MAXPACKET_SIZE       0x40
#define USBD_HIDIAP_OUT_MAXPACKET_SIZE      0x40

#define FLASH_SIZE_REG()                 ((*(uint32_t *)0x1FFFF7E0) & 0xFFFF) /*Get Flash size*/
#define KB_TO_B(kb)                      ((kb) << 10)

#define SECTOR_SIZE_1K                   0x400
#define SECTOR_SIZE_2K                   0x800
#define SECTOR_SIZE_4K                   0x1000

/**
  * @brief iap command
  */
#define IAP_CMD_IDLE                     0x5AA0
#define IAP_CMD_START                    0x5AA1
#define IAP_CMD_ADDR                     0x5AA2
#define IAP_CMD_DATA                     0x5AA3
#define IAP_CMD_FINISH                   0x5AA4
#define IAP_CMD_CRC                      0x5AA5
#define IAP_CMD_JMP                      0x5AA6
#define IAP_CMD_GET                      0x5AA7

#define HID_IAP_BUFFER_LEN               1024
#define IAP_UPGRADE_COMPLETE_FLAG        0x41544B38
#define CONVERT_ENDIAN(dwValue)          ((dwValue >> 24) | ((dwValue >> 8) & 0xFF00) | \
                                         ((dwValue << 8) & 0xFF0000) | (dwValue << 24) )

#define IAP_ACK                          0xFF00
#define IAP_NACK                         0x00FF

typedef enum
{
  IAP_SUCCESS,
  IAP_WAIT,
  IAP_FAILED
}iap_result_type;

typedef enum
{
  IAP_STS_IDLE,
  IAP_STS_START,
  IAP_STS_ADDR,
  IAP_STS_DATA,
  IAP_STS_FINISH,
  IAP_STS_CRC,
  IAP_STS_JMP_WAIT,
  IAP_STS_JMP,
}iap_machine_state_type;

typedef struct
{

  uint8_t iap_fifo[HID_IAP_BUFFER_LEN];
  uint8_t iap_rx[USBD_HIDIAP_OUT_MAXPACKET_SIZE];
  uint8_t iap_tx[USBD_HIDIAP_IN_MAXPACKET_SIZE];

  uint32_t fifo_length;
  uint32_t tx_length;

  uint32_t app_address;
  uint32_t iap_address;
  uint32_t flag_address;

  uint32_t flash_start_address;
  uint32_t flash_end_address;

  uint32_t sector_size;
  uint32_t flash_size;

  uint32_t respond_flag;

  uint8_t g_rxhid_buff[USBD_HIDIAP_OUT_MAXPACKET_SIZE];
  uint32_t hid_protocol;
  uint32_t hid_set_idle;
  uint32_t alt_setting;
  uint32_t hid_state;
  uint8_t hid_set_report[64];

  iap_machine_state_type state;
}iap_info_type;

extern usbd_class_handler hid_iap_class_handler;
extern iap_info_type iap_info;
usb_sts_type usb_iap_class_send_report(void *udev, uint8_t *report, uint16_t len);
iap_result_type usbd_hid_iap_process(void *udev, uint8_t *report, uint16_t len);
void usbd_hid_iap_in_complete(void *udev);

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



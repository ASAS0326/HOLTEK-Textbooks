#ifndef __BLE_TRX_SERVICE_H__
#define __BLE_TRX_SERVICE_H__

#include <stdint.h>
#include <stdbool.h>
#include <string.h>

#include "err_def.h"
#include "stack_def.h"
#include "gatt_service_api.h"
#include "patch_gatt_service_api.h"
#include "type_def.h"

#define TRX_SERVICE_UUID   0xFFF0
#define TRX_CHAR_TX_UUID   0xFFF1

uint32_t ble_trx_service_init(void);
uint32_t ble_trx_send_uart_data(uint16_t conn, uint8_t *data, uint16_t len);
uint16_t ble_trx_notify_payload_size(uint16_t conn);
uint16_t ble_trx_get_current_connection(void);
bool ble_trx_notifications_enabled(uint16_t conn);
uint32_t ble_trx_notification_generation(void);

#endif /* __BLE_TRX_SERVICE_H__ */

#ifndef __BLE_UART4_H
#define __BLE_UART4_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/*
 * HT32F49395 UART4
 *
 * PA0 = UART4_TX
 * PA1 = UART4_RX
 *
 * Current BLE configuration:
 *
 * 9600 baud
 * 8 data bits
 * no parity
 * 1 stop bit
 */
void ble_uart4_init(
    uint32_t baudrate);

void ble_uart4_send(
    const uint8_t *data,
    uint32_t length);

void ble_uart4_send_string(
    const char *text);

/*
 * Make the on-board BM67C593 BLE module advertise as `name`.
 *
 * Queries AT+NAME?, and only when it differs writes AT+NAME=<name>,
 * resets the module (PD3) and reads the name back. Progress goes to
 * the debug UART. Call after ble_uart4_init() and before
 * SysTick_Config() (it times itself with delay_us()), while no
 * central is connected.
 *
 * return 1 when the module reports `name`, else 0.
 */
uint8_t ble_uart4_set_name(
    const char *name);

#ifdef __cplusplus
}
#endif

#endif
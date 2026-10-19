#ifndef _EI_MAIN_H_
#define _EI_MAIN_H_

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Stream LSM6DS3 at 104 Hz until one swing is
 * detected, then classify its peak-aligned window
 * with the Edge Impulse pinpon2 V1 model.
 *
 * Blocks until a swing arrives. Samples are
 * buffered by ei_main_sample_tick() (0.6 s FIFO),
 * so call it again within that time.
 *
 * return:
 *
 *   >= 0
 *     index of class with highest confidence
 *
 *   -1
 *     sampling error
 *
 *   -2
 *     Edge Impulse inference error
 */
int ei_main(void);

/*
 * Print the compiled-in Edge Impulse model (name, deploy version,
 * input shape) on the debug UART.
 */
void ei_main_print_model(void);

/*
 * IMU sampler, call from SysTick_Handler (1 ms).
 * Idle until the first ei_main() call.
 */
void ei_main_sample_tick(void);

#ifdef __cplusplus
}
#endif

#endif
#ifndef _EI_MAIN_H_
#define _EI_MAIN_H_

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif
int ei_main(void);
/*
 * Run the T/H regression model once.
 *
 * target_type:
 *   0 = predict temperature
 *   1 = predict humidity
 *
 * temperature_c : current temperature in degC
 * humidity_rh   : current humidity in %RH
 * prediction    : model output
 *
 * return:
 *   0  = success
 *  -1  = invalid argument / input size mismatch
 *  <0  = Edge Impulse inference error
 */
int ei_predict_th(float temperature_c,
                  float humidity_rh,
                  uint8_t target_type,
                  float *prediction);

/*
 * Run the same model twice:
 *   target_type = 0 -> predicted temperature
 *   target_type = 1 -> predicted humidity
 */
int ei_predict_both(float temperature_c,
                    float humidity_rh,
                    float *pred_temperature_c,
                    float *pred_humidity_rh);

#ifdef __cplusplus
}
#endif

#endif
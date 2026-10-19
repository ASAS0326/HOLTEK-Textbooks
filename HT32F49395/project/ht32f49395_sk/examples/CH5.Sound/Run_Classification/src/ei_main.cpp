#include "ei_main.h"

/* HT32 */
#include "ht32f493x5.h"
#include "ht32f493x5_board.h"
#include "ht32f493x5_clock.h"

/* Edge Impulse */
#include "ei_run_classifier.h"
#include "edge-impulse-sdk/porting/ei_classifier_porting.h"

#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>


extern "C" {
#include "ICS43434.h"
}


/*
 * Current board:
 *
 *   U5/U6 = ICS-43434
 *
 * Existing driver file name is still ICS43434.c/.h only for
 * project compatibility.
 *
 * Driver output:
 *   8000 Hz
 *   mono
 *   PCM16
 *
 * Edge Impulse baby_cry model:
 *   8000 Hz
 *   8000 samples
 *   1 second window
 *   labels = cry / noise
 */


#if EI_CLASSIFIER_RAW_SAMPLES_PER_FRAME != 1
#error "baby_cry model must use one audio axis."
#endif


#if EI_CLASSIFIER_FREQUENCY != 8000
#error "This code expects an 8000 Hz Edge Impulse audio model."
#endif


static float features[
    EI_CLASSIFIER_DSP_INPUT_FRAME_SIZE];


static int16_t pcm_buffer[
    ICS43434_PCM_SAMPLES];


/* =========================================================================================
 * Edge Impulse signal callback
 * ========================================================================================= */

static int raw_feature_get_data(size_t offset,
                                size_t length,
                                float *out_ptr)
{
  memcpy(
      out_ptr,
      features + offset,
      length * sizeof(float));

  return 0;
}


/* =========================================================================================
 * Collect one real microphone window
 * ========================================================================================= */

static int collect_audio_window(void)
{
  size_t feature_index = 0U;

  uint32_t samples;
  uint32_t copy_count;
  uint32_t i;


  while(feature_index <
        EI_CLASSIFIER_DSP_INPUT_FRAME_SIZE)
  {
    /*
     * Non-blocking driver call.
     *
     * Returns PCM data only when one DMA half-buffer is ready.
     */
    samples =
        ICS43434_read_pcm16(
            pcm_buffer,
            ICS43434_PCM_SAMPLES);


    if(samples == 0U)
    {
      /*
       * Do not busy-wait.
       *
       * DMA half/full interrupt wakes the CPU.
       */
      __WFI();

      continue;
    }


    copy_count =
        samples;


    if((feature_index +
        copy_count) >
       EI_CLASSIFIER_DSP_INPUT_FRAME_SIZE)
    {
      copy_count =
          (uint32_t)(
              EI_CLASSIFIER_DSP_INPUT_FRAME_SIZE -
              feature_index);
    }


    /*
     * IMPORTANT:
     *
     * Edge Impulse audio input expects raw PCM amplitude as float.
     * Do not divide by 32768.
     */
    for(i = 0U;
        i < copy_count;
        i++)
    {
      features[feature_index] =
          (float)pcm_buffer[i];

      feature_index++;
    }
  }


  return 0;
}


/* =========================================================================================
 * Run one inference window
 * ========================================================================================= */

extern "C"
int ei_main(void)
{
  ei_impulse_result_t result = {0};

  signal_t signal;

  EI_IMPULSE_ERROR res;

  int best_index = -1;
  float best_value = -1.0f;

  size_t i;


  printf("\r\n");
  printf("----------------------------------------\r\n");
  printf("Sampling 1 second microphone window...\r\n");


  if(collect_audio_window() != 0)
  {
    printf(
        "ERROR: microphone capture failed\r\n");

    return -1;
  }


  printf(
      "Sampling complete: %u samples\r\n",
      (unsigned int)
      EI_CLASSIFIER_DSP_INPUT_FRAME_SIZE);


  signal.total_length =
      EI_CLASSIFIER_DSP_INPUT_FRAME_SIZE;

  signal.get_data =
      &raw_feature_get_data;


  res =
      run_classifier(
          &signal,
          &result,
          false);


  if(res != EI_IMPULSE_OK)
  {
    printf(
        "run_classifier ERROR=%d\r\n",
        (int)res);

    return -2;
  }


  printf("Predictions:\r\n");


  for(i = 0U;
      i < EI_CLASSIFIER_LABEL_COUNT;
      i++)
  {
    printf(
        "  %s = ",
        result.classification[i].label);


    ei_printf_float(
        result.classification[i].value);


    printf("\r\n");


    if(result.classification[i].value >
       best_value)
    {
      best_value =
          result.classification[i].value;

      best_index =
          (int)i;
    }
  }


#if EI_CLASSIFIER_HAS_ANOMALY == 1
  printf(
      "  anomaly = ");

  ei_printf_float(
      result.anomaly);

  printf("\r\n");
#endif


  printf("Result = ");


  if(best_index >= 0)
  {
    printf(
        "%s (",
        result.classification[
            best_index].label);

    ei_printf_float(
        best_value);

    printf(")\r\n");
  }
  else
  {
    printf("UNKNOWN\r\n");
  }


  if((best_index >= 0) &&
     (best_value >=
      EI_CLASSIFIER_THRESHOLD))
  {
    printf(
        "Decision = %s\r\n",
        result.classification[
            best_index].label);
  }
  else
  {
    printf(
        "Decision = UNCERTAIN\r\n");
  }


  printf(
      "DSP=%d ms, NN=%d ms\r\n",
      result.timing.dsp,
      result.timing.classification);


  return best_index;
}

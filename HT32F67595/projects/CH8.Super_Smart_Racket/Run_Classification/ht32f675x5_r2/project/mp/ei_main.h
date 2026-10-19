#ifndef _EI_MAIN_H_
#define _EI_MAIN_H_

/* Peak-triggered inference. These values must match the "firmware" block of
 * the collector's session JSON (Data_collection/.../collect_training_data.py):
 * the model is trained on 104 Hz windows whose gyro-magnitude peak sits at
 * SWING_PEAK_INDEX, found by the same detector.
 *
 * A swing starts when |gyro| rises through SWING_THRESHOLD_DPS. Its peak is
 * the largest |gyro| until (window - SWING_PEAK_INDEX - 1) samples bring no
 * larger value; the window [peak - SWING_PEAK_INDEX, peak + 20] is then
 * classified once. Latency after the peak is 20 samples (~192 ms) + inference.
 */
#define SWING_THRESHOLD_DPS          250.0f
#define SWING_PEAK_INDEX             31U

/* After a REPORTED stroke, no new swing may start within this many samples
 * of its peak (0.45 s at 104 Hz). After a NONE result there is no pause, so a
 * backswing that crosses the threshold cannot hide the stroke that follows.
 * Longer values lost real strokes in simulation on the recorded streams.
 */
#define SWING_REFRACTORY_SAMPLES     47U

/* Publish a swing only when a stroke class (not NONE) wins with at least
 * this probability. In simulation on the recorded streams, 0.70 instead of
 * 0.50 cut false reports by ~15% for one missed stroke out of 381.
 */
#define SWING_MIN_CONFIDENCE         0.70f

#define AI_NONE_CLASS_INDEX          6U

/* One UART line per classified swing with all seven scores; 0 disables. */
#ifndef EI_SWING_LOG
#define EI_SWING_LOG                 1
#endif

#ifdef __cplusplus
extern "C" {
#endif
int ei_main(void);
#ifdef __cplusplus
}
#endif
#endif

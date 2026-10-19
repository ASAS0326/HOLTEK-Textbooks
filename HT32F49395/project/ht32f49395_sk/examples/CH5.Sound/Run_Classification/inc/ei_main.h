#ifndef _EI_MAIN_H_
#define _EI_MAIN_H_

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Collect one complete microphone window and run one inference.
 *
 * return:
 *   >= 0 : winning label index
 *   < 0  : capture / inference error
 */
int ei_main(void);

#ifdef __cplusplus
}
#endif

#endif

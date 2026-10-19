#ifndef _SHARED_MEMORY_H_
#define _SHARED_MEMORY_H_

#include <stdint.h>
#include <stdbool.h>


#ifdef __cplusplus
extern "C" {
#endif


#define SHARED_MEM_ADDR       0x20015C00UL
#define SHARED_MEM_MAGIC      0x53485244UL
#define SHARED_DATA_SIZE      4000U

/* Existing fixed AI mailbox: 24-byte top-2 payload, followed by a seqlock.
 * Ring-buffer API is retained, but must not be used concurrently with this mailbox.
 */
typedef struct {
    char label0[8];
    float value0;
    char label1[8];
    float value1;
} shared_ai_result_t;
#define SHARED_AI_RESULT_ADDR (SHARED_MEM_ADDR + 0x10U)
#define SHARED_AI_SEQUENCE \
    (*(volatile uint32_t *)(SHARED_AI_RESULT_ADDR + sizeof(shared_ai_result_t)))

/* V2 wire-format metadata. Written under the SAME sequence as the existing
 * top-2 payload; +0x40 leaves the payload, sequence and diagnostics in place.
 * Scores are the representative window's seven probabilities, not votes.
 */
#define SHARED_AI_CLASS_COUNT 7U
typedef struct {
    float scores[SHARED_AI_CLASS_COUNT];
    uint32_t tick_us;
    uint32_t latency_ms;
} shared_ai_details_t;
#define SHARED_AI_DETAILS_ADDR (SHARED_MEM_ADDR + 0x40U)


/* Independent diagnostic counters (MP writer, CP reader).
 * All diagnostic fields remain below +0x40; no overlap with AI details.
 */
#define SHARED_AI_STATE   (*(volatile uint32_t *)(SHARED_MEM_ADDR + 0x2CU))
#define SHARED_AI_SAMPLES (*(volatile uint32_t *)(SHARED_MEM_ADDR + 0x30U))
#define SHARED_AI_WINDOWS (*(volatile uint32_t *)(SHARED_MEM_ADDR + 0x34U))
#define SHARED_AI_ERROR   (*(volatile int32_t  *)(SHARED_MEM_ADDR + 0x38U))
#define SHARED_AI_FIFO    (*(volatile uint32_t *)(SHARED_MEM_ADDR + 0x3CU))
enum {
    AI_STATE_BOOT = 0, AI_STATE_SENSOR_INIT = 1, AI_STATE_COLLECTING = 2,
    AI_STATE_CLASSIFYING = 3, AI_STATE_RESULT_READY = 4, AI_STATE_ERROR = 5,
    AI_STATE_WAITING_SWING = 6, AI_STATE_SWING_ACTIVE = 7, AI_STATE_SWING_LOCKED = 8
};

typedef struct
{
    volatile uint32_t magic;
    volatile uint32_t write_index;
    volatile uint32_t read_index;
    volatile uint32_t data_count;

    volatile uint8_t data[SHARED_DATA_SIZE];

} mp_cp_shared_mem_t;


#define SHARED_MEM \
    ((volatile mp_cp_shared_mem_t *)SHARED_MEM_ADDR)


void shared_memory_init(void);

void shared_memory_clear(void);

bool shared_memory_write(const uint8_t *data,
                         uint32_t len);

uint32_t shared_memory_read(uint8_t *data,
                            uint32_t max_len);

uint32_t shared_memory_available(void);

uint32_t shared_memory_free(void);


#ifdef __cplusplus
}
#endif


#endif

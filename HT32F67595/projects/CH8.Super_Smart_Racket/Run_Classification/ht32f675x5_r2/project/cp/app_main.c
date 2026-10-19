/*************************************************************************************************************
 * @file    app_main.c
 * @version V1.0
 * @date    2022-02-13
 * @brief   ble_peripheral cp app main file
 *************************************************************************************************************
 * @attention
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
 ************************************************************************************************************/


#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdbool.h>

#include "RegHT32F675x5.h"
#include "err_def.h"
#include "hw_crg.h"
#include "hw_gpio.h"
#include "hw_pmu.h"
#include "hw_uart.h"
#include "hw_sys_ctrl.h"
#include "hw_trng.h"
#include "hal_pmu.h"
#include "hal_rf.h"

#include "ble_init.h"
#include "ble_event.h"
#include "ble_gap_service.h"
#include "ble_dis.h"

#include "app_cfg.h"
#include "boards.h"

#include "rand.h"
#include "utility.h"
#include "lpwr_ctrl.h"
#include "app_timer.h"

#include "cmsis_os2.h"
#include "rtx_lib.h"

#include "rom_callback.h"
#include "err_debug.h"
#include "app_debug.h"
#include "mlog.h"
#include "mlog_transport_uart.h"

#include "ble_init.h"
#include "ble_peripheral.h"

/**
 *  new 
 */

#include "gatt_service_api.h"
#include "ble_trx_service_integrated.h"
#include "shared_memory.h"
/**
 *  new end.
 */
 
/**
 * @brief  LOCAL VARIABLES
 */
#if APP_DEBUG_ENABLED
static uint8_t      m_u8DebugBuf[4096] __attribute__((aligned(4)));
static stDebugBuf_t m_stDebugBuf __attribute__((aligned(4)));
#endif

/**
 *  new 
 */
static osRtxThread_t m_ble_send_taskMainCB __attribute__((aligned(4), section(".bss.os.thread.cb")));
static uint64_t      m_u64ble_send_taskStack[128];
/**
 *  new end.
 */



/**
 * @brief  Extern functions.
 */
extern void idle_task_init(void);

/**
 * @brief  System clock init, Control clock gate.
 */
static void system_clock_init(void)
{
    rom_hw_crg_enable_clk_gate(CRG_AHB4_CLK_GATE);
    rom_hw_crg_enable_clk_gate(CRG_FD_CLK_GATE);
    rom_hw_crg_enable_clk_gate(CRG_LO_CLK_GATE);
    rom_hw_crg_enable_clk_gate(CRG_SDM_CLK_GATE);
    rom_hw_crg_enable_clk_gate(CRG_MDM_CLK_GATE);
    rom_hw_crg_enable_clk_gate(CRG_LLC_HCLK_GATE);
    rom_hw_crg_enable_clk_gate(CRG_LLC_LCLK_GATE);
    rom_hw_crg_enable_clk_gate(CRG_CPTO0_CLK_GATE);
    rom_hw_crg_enable_clk_gate(CRG_CPTO1_CLK_GATE);
    rom_hw_crg_enable_clk_gate(CRG_CALI_CLK_GATE);
    rom_hw_crg_enable_clk_gate(CRG_TRNG_CLK_GATE);
}

/**
 * @brief  All peripheral related please init here
 */
static void peripheral_init(void)
{
    /* Disable CP all Peripheral interrupt. */
    rom_hw_sys_ctrl_peri_int_ctrl(SYS_CTRL_CP, 0, 0);

    // Rand init
    rom_rand_init(rom_hw_trng_gen_32bit());

    // App timer init
    app_timer_init();

#if APP_DEBUG_ENABLED
    m_stDebugBuf.pu8buf    = m_u8DebugBuf;
    m_stDebugBuf.u16MaxLen = sizeof(m_u8DebugBuf);
    app_debug_init(GPIO_PORT_CP_APP_DEBUG_TX, GPIO_PIN_CP_APP_DEBUG_TX, UART_HANDLE_CP_APP_DEBUG, UART_BPS_CP_APP_DEBUG,
                   &m_stDebugBuf);
    PRINTF("[%s T %s]ble peripheral project(cp) start to work.\n", __DATE__, __TIME__);
#endif

#if MLOG_DEBUG_ENABLED
    mlog_transport_uart_init(UART_HANDLE_CP_MLOG, GPIO_PORT_CP_MLOG_TX, GPIO_PIN_CP_MLOG_TX, UART_BPS_CP_MLOG);

    MLOG0D(0x80c0, "MLOG0D test");
    MLOGI(0x80c1, "MLOGI test : 0x%04x", 0x1234);
    MLOG32I(0x80c2, "MLOG32I test : 0x%08x", 0x12345678);
    MLOG88W(0x80c3, "MLOG88W test : 0x%02x : 0x%02x", 0x12, 0x34);
    MLOG1616W(0x80c4, "MLOG1616W test : 0x%04x : 0x%04x", 0x1234, 0x5678);
    MLOG3216W(0x80c5, "MLOG3216W test : 0x%08x : 0x%04x", 0x12345678, 0x4321);
    MLOG3232W(0x80c6, "MLOG3232W test : 0x%08x : 0x%08x", 0x12345678, 0x87654321);
    MLOG1688E(0x80c7, "MLOG1688E test : 0x%04x : 0x%02x : 0x%02x", 0x1234, 0x56, 0x78);
    MLOG161616E(0x80c8, "MLOG161616E test : 0x%04x : 0x%04x : 0x%04x", 0x1234, 0x5678, 0xabcd);
    MLOG3288E(0x80c9, "MLOG3288E test : 0x%08x : 0x%02x : 0x%02x", 0x12345678, 0xab, 0xcd);
    MLOG321616E(0x80ca, "MLOG321616E test : 0x%08x : 0x%04x : 0x%04x", 0x12345678, 0xaabb, 0xccdd);

    uint8_t pu8Data[] = {0x12, 0x34, 0x56, 0x78, 0x90};
    MLOGXD(0x80cb, "MLOGXD test:", pu8Data, sizeof(pu8Data));
#endif

    err_debug_init();
}


/**
 * @brief  ble service init.
 */
static void ble_profile_init(void )
{
    ble_gap_service_init((uint8_t *)BLE_ADV_NAME_STRING, strlen(BLE_ADV_NAME_STRING), 0);
    ble_dis_init();
	  ble_trx_service_init();  //new

}

/**
 * @brief  Check if the system can get into sleep
 * @return false(0) - System can not get into sleep.
 * @return true(1)  - System can get into sleep.
 */
static bool lpwr_before_sleep(void)
{
    /* This firmware has a periodic AI sender. The legacy sleep path disables
     * SysTick without accounting elapsed time in RTX; osDelay/status deadlines
     * can stall even though radio interrupts still keep the BLE link alive.
     * Keep RTOS time running for the complete connected session.
     */
    if (ble_trx_get_current_connection() != 0U) {
        return false;
    }

    // Check ble.
    if (!ble_init_is_system_sleep_allowed())
    {
        return false;
    }

// Check app debug(uart).
#if APP_DEBUG_ENABLED
    if (!app_debug_print_complete())
    {
        return false;
    }

    // Set uart pin to impedance
    app_debug_deinit();
#endif

// Check mlog(uart).
#if MLOG_DEBUG_ENABLED
    /* Set uart pin to impedance */
    mlog_transport_uart_deinit();
#endif

    OS_Tick_Disable();

    return true;
}

/**
 * @brief  CPU after wakeup from sleep func
 */
static void lpwr_after_wakeup(void)
{
#if APP_DEBUG_ENABLED
    app_debug_reinit();
    // PRINTF("A");
#endif

#if MLOG_DEBUG_ENABLED
    // Re-init mlog
    mlog_transport_uart_reinit();
#endif

    OS_Tick_Enable();
}

/**
 * @brief  PMU IRQ Handler.
 */
void PMU_IRQ_Handler(void)
{
    uint32_t u32IntFlag;

    rom_hw_pmu_get_interrupt_flag(&u32IntFlag);
    rom_hw_pmu_clear_interrupt_flag(u32IntFlag);

    if (u32IntFlag & (1 << LUT_INDEX_CP_LLC))
    {
        ble_init_on_system_wakeup_by_llc();
    }
}

/**
 * @brief  Low power init
 * @param  enMode: System work mode, @ref EN_LPWR_MODE_SEL_T.
 */
static void system_lpwr_init(EN_LPWR_MODE_SEL_T enMode)
{
    // Enable pmu interrupt. 
    rom_hw_sys_ctrl_enable_peri_int(SYS_CTRL_CP, PMU_IRQ);
    NVIC_ClearPendingIRQ(PMU_IRQ);
    NVIC_SetPriority(PMU_IRQ, 0);
    NVIC_EnableIRQ(PMU_IRQ);

    // Low power init.
    lpwr_ctrl_init(enMode, lpwr_before_sleep, lpwr_after_wakeup);
}


/////====================================================================================

#define SHARED_RESULT_ADDR   SHARED_AI_RESULT_ADDR
#define SHARED_RESULT_SIZE   sizeof(shared_ai_result_t)

/*
 * Exact V2 ei_ai_frame_t wire layout (all multi-byte fields little-endian).
 * The seven scores come from MP's representative window, not top-2 or votes.
 *
 *   [0]     SYNC0    = 0xAA
 *   [1]     SYNC1    = 0x55
 *   [2]     VERSION  = 0x01
 *   [3]     TYPE_AI  = 0x02
 *   [4..7]  seq      (uint32, little-endian)
 *   [8..11] tick_us  (representative window's sample timestamp)
 *   [12]    labelIndex (pinpon 5.0.0: 0=BC, 1=BP, 2=BS, 3=FC, 4=FP, 5=FS, 6=NONE)
 *   [13]    confidence (0..255)
 *   [14..27] score[7] (uint16 each, 0..10000): BC,BP,BS,FC,FP,FS,NONE
 *   [28..29] latency_ms (representative window's run_classifier wall time)
 *   [30..31] checksum = sum(bytes[0..29]) & 0xFFFF, little-endian
 */
#define AI_FRAME_SIZE   32U
#define AI_SYNC0        0xAAU
#define AI_SYNC1        0x55U
#define AI_VERSION      0x01U
#define AI_TYPE_AI      0x02U

/*
 * pinpon 5.0.0 label order, matching
 * edgeimpulse/model-parameters/model_variables.h exactly
 * (Edge Impulse sorts categories alphabetically, NOT by
 * myTrainSet folder number).
 */
static const char *const PINPON_LABELS[] =
    { "BC", "BP", "BS", "FC", "FP", "FS", "NONE" };

#define PINPON_LABEL_COUNT \
    (sizeof(PINPON_LABELS) / sizeof(PINPON_LABELS[0]))

/*
 * MP writes the top-1 label as a string (shared_ai_result_t.label0).
 * Look up its numeric class index so the BLE frame carries the real
 * predicted class instead of a re-derived value.
 */
static uint8_t pinpon_label_to_index(const char *label)
{
    uint8_t i;

    for (i = 0U; i < PINPON_LABEL_COUNT; i++)
    {
        if (strcmp(label, PINPON_LABELS[i]) == 0)
        {
            return i;
        }
    }

    /* Do not misreport an incompatible model as NONE. */
    return 0xFFU;
}


static uint8_t float_to_u8_255(float v)
{
    float scaled = v * 255.0f;

    if (scaled < 0.0f)   scaled = 0.0f;
    if (scaled > 255.0f) scaled = 255.0f;

    return (uint8_t)(scaled + 0.5f);
}

static uint16_t float_to_u16_10000(float v)
{
    float scaled = v * 10000.0f;

    if (scaled < 0.0f)     scaled = 0.0f;
    if (scaled > 10000.0f) scaled = 10000.0f;

    return (uint16_t)(scaled + 0.5f);
}

static uint16_t ai_frame_checksum(const uint8_t *frame)
{
    uint16_t sum = 0;
    uint32_t i;

    for (i = 0U; i < 30U; i++)
    {
        sum = (uint16_t)(sum + frame[i]);
    }

    return sum;
}

/* MP commits one prediction per swing. CP preserves its original scores
 * and forwards each completed mailbox result without another threshold.
 */
static void ai_frame_u32(uint8_t *dst, uint32_t value)
{
    dst[0] = (uint8_t)value;
    dst[1] = (uint8_t)(value >> 8);
    dst[2] = (uint8_t)(value >> 16);
    dst[3] = (uint8_t)(value >> 24);
}

static void ai_frame_begin(uint8_t *frame, uint8_t type, uint32_t sequence)
{
    memset(frame, 0, AI_FRAME_SIZE);
    frame[0] = AI_SYNC0;
    frame[1] = AI_SYNC1;
    frame[2] = AI_VERSION;
    frame[3] = type;
    ai_frame_u32(frame + 4, sequence);
}

static void ai_frame_finish(uint8_t *frame)
{
    uint16_t sum = ai_frame_checksum(frame);
    frame[30] = (uint8_t)sum;
    frame[31] = (uint8_t)(sum >> 8);
}

/* Return zero until a fresh, complete, valid mailbox result exists. */
static uint32_t ai_build_result_frame(uint8_t *frame, uint32_t sequence,
                                     uint32_t last_result_sequence)
{
    shared_ai_result_t result;
    shared_ai_details_t details;
    uint32_t current;
    uint8_t label0, label1;
    volatile const uint8_t *src = (volatile const uint8_t *)SHARED_AI_RESULT_ADDR;
    uint8_t *dst = (uint8_t *)&result;
    if (SHARED_MEM->magic != SHARED_MEM_MAGIC) return 0U;
    current = SHARED_AI_SEQUENCE;
    if (current == 0U || (current & 1U) || current == last_result_sequence) return 0U;
    __DMB();
    for (uint32_t i = 0; i < sizeof(result); ++i) dst[i] = src[i];
    src = (volatile const uint8_t *)SHARED_AI_DETAILS_ADDR;
    dst = (uint8_t *)&details;
    for (uint32_t i = 0; i < sizeof(details); ++i) dst[i] = src[i];
    __DMB();
    if (current != SHARED_AI_SEQUENCE) return 0U;
    result.label0[7] = '\0';
    result.label1[7] = '\0';
    label0 = pinpon_label_to_index(result.label0);
    label1 = pinpon_label_to_index(result.label1);
    if (label0 >= PINPON_LABEL_COUNT || label1 >= PINPON_LABEL_COUNT ||
        !(result.value0 >= 0.0f && result.value0 <= 1.0f) ||
        !(result.value1 >= 0.0f && result.value1 <= 1.0f)) return 0U;
    for (uint32_t i = 0; i < SHARED_AI_CLASS_COUNT; ++i)
        if (!(details.scores[i] >= 0.0f && details.scores[i] <= 1.0f)) return 0U;
    /* A mixed old-MP/new-CP image has no full-score extension. Reject it,
     * rather than transmitting fabricated zero scores as a V2 frame.
     */
    if (details.scores[label0] != result.value0 ||
        details.scores[label1] != result.value1 || details.latency_ms > 65535U) return 0U;
    ai_frame_begin(frame, AI_TYPE_AI, sequence);
    ai_frame_u32(frame + 8, details.tick_us);
    frame[12] = label0;
    frame[13] = float_to_u8_255(result.value0);
    for (uint32_t i = 0; i < SHARED_AI_CLASS_COUNT; ++i) {
        const uint16_t score = float_to_u16_10000(details.scores[i]);
        frame[14U + i * 2U] = (uint8_t)score;
        frame[15U + i * 2U] = (uint8_t)(score >> 8);
    }
    frame[28] = (uint8_t)details.latency_ms;
    frame[29] = (uint8_t)(details.latency_ms >> 8);
    ai_frame_finish(frame);
    return current;
}

/* Advance only after the stack accepts a chunk. On a busy/error return, retry
 * exactly the same bytes; never resend an already accepted fragment.
 */
static uint32_t ai_send_frame_chunk(uint16_t conn, uint8_t *frame, uint16_t *offset)
{
    uint16_t length = AI_FRAME_SIZE - *offset;
    uint32_t result;
    const uint16_t payload_size = ble_trx_notify_payload_size(conn);
    if (length > payload_size) length = payload_size;
    if (length == 0U) return ERR_STA_OK;
    result = ble_trx_send_uart_data(conn, frame + *offset, length);
    if (result == ERR_STA_OK) *offset += length;
    return result;
}

void ble_send_task(void *argument)
{
    uint32_t sequence = 0, last_result_sequence = 0, pending_result = 0;
    uint32_t subscription = 0, failures = 0, last_error_tick = 0;
    const uint32_t log_period = osKernelGetTickFreq();
    uint16_t previous_conn = 0, offset = 0;
    uint8_t frame[AI_FRAME_SIZE];
    bool pending = false;
    (void)argument;
    PRINTF("CP pinpon v5 swing r10: V2 one packet per event\r\n");
    for (;;) {
        uint16_t conn = ble_trx_get_current_connection();
        uint32_t generation = ble_trx_notification_generation();
        uint32_t now = osKernelGetTickCount();
        if (conn != previous_conn || generation != subscription) {
            previous_conn = conn;
            subscription = generation;
            pending = false;
            offset = 0;
            /* A new subscription starts with future swings, not a stale
             * mailbox result from before connection. Odd writes are ignored
             * until their completed even sequence is published.
             */
            last_result_sequence = SHARED_AI_SEQUENCE;
        }
        if (!ble_trx_notifications_enabled(conn)) {
            pending = false;
            offset = 0;
            osDelay(10);
            continue;
        }
        if (SHARED_AI_SEQUENCE == 0U) last_result_sequence = 0U;
        if (!pending) {
            pending_result = ai_build_result_frame(frame, sequence, last_result_sequence);
            pending = pending_result != 0U;
            offset = 0;
            /* MP commits one mailbox sequence per accepted V2 swing event.
             * Deduplicate that sequence, never its class: two independent FP
             * swings must both be sent. Idle/window updates do not commit one.
             * Consume hidden NONE results once; do not send them as activity.
             * Accepted swings remain pending until every BLE fragment succeeds.
             */
            if (pending && frame[12] == PINPON_LABEL_COUNT - 1U) {
                last_result_sequence = pending_result;
                pending = false;
            }
        }
        if (pending) {
            uint32_t result = ai_send_frame_chunk(conn, frame, &offset);
            if (result != ERR_STA_OK) {
                ++failures;
                if (failures == 1U || (uint32_t)(now - last_error_tick) >= log_period) {
                    PRINTF("BLE notify failed=%lu conn=%u offset=%u; retry\r\n",
                           (unsigned long)result, conn, offset);
                    last_error_tick = now;
                }
                osDelay(10);
                continue;
            }
            if (offset == AI_FRAME_SIZE) {
                if (pending_result != 0U) last_result_sequence = pending_result;
                ++sequence;
                pending = false;
            }
        }
        osDelay(2);
    }
}


/////====================================================================================




/**
 * @brief  cp app main task.
 * @param  argument
 */
void app_main(void *argument)
{
    system_clock_init();
    peripheral_init();

    ble_init();
    ble_event_init();
    ble_peripheral_init();
    ble_profile_init();

    idle_task_init();
		system_lpwr_init(LPWR_MODE_SLEEP); 
  	osDelay(200); //new

		const osThreadAttr_t ble_send_attr = {
      "ble_send_task",
      osThreadDetached,
			&m_ble_send_taskMainCB,
		  sizeof(m_ble_send_taskMainCB),
		  &m_u64ble_send_taskStack[0],
			sizeof(m_u64ble_send_taskStack),
			osPriorityNormal,
       1,
    }; //new
	
		osThreadNew(ble_send_task, NULL, &ble_send_attr);//new

		osThreadTerminate(osThreadGetId());
}

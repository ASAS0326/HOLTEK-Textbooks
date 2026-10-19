#include "hs300x.h"

#include "i2c.h"

typedef enum
{
    HS300X_STATE_IDLE = 0,
    HS300X_STATE_WAIT_REQUEST_TX,
    HS300X_STATE_WAIT_CONVERSION,
    HS300X_STATE_WAIT_RX
} HS300X_STATE_T;

float g_hs300x_humidity = 0.0f;
float g_hs300x_temperature = 0.0f;

static HS300X_STATE_T s_state = HS300X_STATE_IDLE;
static HS300X_STATUS_T s_last_status = HS300X_STATUS_OK;
static bool s_data_ready = false;
static uint32_t s_conversion_start_ms = 0U;

static uint8_t s_measurement_request = HS300X_WRITE_ADDR;
static uint8_t s_rx_data[4];

static void hs300x_decode_data(void);

void HS300X_Init(void)
{
    g_hs300x_humidity = 0.0f;
    g_hs300x_temperature = 0.0f;

    s_state = HS300X_STATE_IDLE;
    s_last_status = HS300X_STATUS_OK;
    s_data_ready = false;
    s_conversion_start_ms = 0U;
}

HS300X_STATUS_T HS300X_StartMeasurement(void)
{
    I2C_HAL_STATUS_T hal_status;

    if ((s_state != HS300X_STATE_IDLE) || I2C_HAL_IsBusy())
    {
        return HS300X_STATUS_BUSY;
    }

    s_data_ready = false;
    s_last_status = HS300X_STATUS_OK;

    /* Preserve the measurement-request byte used by the original project. */
    s_measurement_request = HS300X_WRITE_ADDR;

    hal_status = I2C_HAL_MasterWriteDMA(&s_measurement_request, 1U, true);
    if (hal_status != I2C_HAL_STATUS_OK)
    {
        s_last_status = HS300X_STATUS_I2C_ERROR;
        return s_last_status;
    }

    s_state = HS300X_STATE_WAIT_REQUEST_TX;
    return HS300X_STATUS_OK;
}

void HS300X_Process(void)
{
    I2C_HAL_EVENT_T event;

    event = I2C_HAL_TakeEvent();

    if (event == I2C_HAL_EVENT_ERROR)
    {
        s_state = HS300X_STATE_IDLE;
        s_last_status = HS300X_STATUS_I2C_ERROR;
        s_data_ready = false;
        return;
    }

    switch (s_state)
    {
        case HS300X_STATE_WAIT_REQUEST_TX:
            if (event == I2C_HAL_EVENT_TX_DONE)
            {
                s_conversion_start_ms = I2C_HAL_GetTickMs();
                s_state = HS300X_STATE_WAIT_CONVERSION;
            }
            break;

        case HS300X_STATE_WAIT_CONVERSION:
            if ((uint32_t)(I2C_HAL_GetTickMs() - s_conversion_start_ms) >= HS300X_CONVERSION_TIME_MS)
            {
                if (I2C_HAL_MasterReadDMA(s_rx_data, sizeof(s_rx_data), true) == I2C_HAL_STATUS_OK)
                {
                    s_state = HS300X_STATE_WAIT_RX;
                }
                else
                {
                    s_state = HS300X_STATE_IDLE;
                    s_last_status = HS300X_STATUS_I2C_ERROR;
                }
            }
            break;

        case HS300X_STATE_WAIT_RX:
            if (event == I2C_HAL_EVENT_RX_DONE)
            {
                hs300x_decode_data();
                s_state = HS300X_STATE_IDLE;
            }
            break;

        case HS300X_STATE_IDLE:
        default:
            break;
    }
}

static void hs300x_decode_data(void)
{
    uint16_t raw_humidity;
    uint16_t raw_temperature;
    uint8_t status_bits;

    status_bits = (uint8_t)(s_rx_data[0] & 0xC0U);

    if (status_bits == 0x40U)
    {
        s_last_status = HS300X_STATUS_STALE_DATA;
        s_data_ready = false;
        return;
    }

    raw_humidity = ((uint16_t)(s_rx_data[0] & 0x3FU) << 8) |
                   (uint16_t)s_rx_data[1];

    raw_temperature = (((uint16_t)s_rx_data[2] << 8) |
                       (uint16_t)s_rx_data[3]) >> 2;

    g_hs300x_humidity = ((float)raw_humidity / 16383.0f) * 100.0f;
    g_hs300x_temperature = ((float)raw_temperature / 16383.0f) * 165.0f - 40.0f;

    s_last_status = HS300X_STATUS_OK;
    s_data_ready = true;
}

bool HS300X_IsBusy(void)
{
    return (s_state != HS300X_STATE_IDLE);
}

bool HS300X_DataReady(void)
{
    return s_data_ready;
}

void HS300X_ClearDataReady(void)
{
    s_data_ready = false;
}

HS300X_STATUS_T HS300X_GetLastStatus(void)
{
    return s_last_status;
}

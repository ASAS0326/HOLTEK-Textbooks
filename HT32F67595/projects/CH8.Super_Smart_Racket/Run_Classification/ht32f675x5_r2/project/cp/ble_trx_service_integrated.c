#include "ble_trx_service_integrated.h"
#include "ble_event.h"
#include "gap_api.h"

// GATT buffer
static uint8_t profileBuf[2048];
static gatts_serv_info_st servInfoBuf[16];

static uint16_t trx_hdl_tx, trx_hdl_cccd_tx;
static volatile uint8_t  trx_notify_enabled = 0;
static volatile uint16_t trx_notify_conn = 0;
static volatile uint32_t trx_notify_generation = 0;

static uint16_t trx_get_attrlen_cb(uint16_t conn, uint16_t attHdl);
static uint16_t trx_read_attr_cb(uint16_t conn, uint16_t attHdl,uint16_t offset, uint8_t *buf, uint16_t bufLen);
static uint32_t trx_write_attr_cb(uint16_t conn, uint16_t attHdl,uint16_t mode, uint16_t offset,uint8_t *buf, uint16_t len);

static gatt_serviceCBs_t trx_cbs = {
    trx_get_attrlen_cb,
    trx_read_attr_cb,
    trx_write_attr_cb
};

uint32_t ble_trx_service_init(void) {
    uint16_t hdl;

    // init GATT
    patch_gatts_api_init(profileBuf , sizeof(profileBuf),servInfoBuf, sizeof(servInfoBuf)/sizeof(servInfoBuf[0]));

    // service
    hdl = patch_gatts_api_add_service_start(false, TRX_SERVICE_UUID, NULL, &trx_cbs);
    if (!hdl) return ERR_STA_ERROR;


    hdl = patch_gatts_api_add_char(false, TRX_CHAR_TX_UUID, NULL,ATT_PROPERTY_NOTIFY | ATT_PROPERTY_DYNAMIC,NULL, 0);
    if (!hdl) return ERR_STA_ERROR;
    
		trx_hdl_tx = hdl;
    trx_hdl_cccd_tx = rom_gatts_api_add_char_descrip_client_config();
    if (!trx_hdl_cccd_tx) return ERR_STA_ERROR;
		
		patch_gatts_api_add_service_end();
		
    return ERR_STA_OK;
}

uint32_t ble_trx_send_uart_data(uint16_t conn, uint8_t *data, uint16_t len)
{
    if (conn == 0 || data == NULL || len == 0) {
        return ERR_STA_ERROR;
    }

    if (!ble_trx_notifications_enabled(conn) || len > ble_trx_notify_payload_size(conn)) {
        return ERR_STA_ERROR;
    }

    uint32_t result = rom_gatts_api_send_notify(conn, trx_hdl_tx, data, len);
    return result;
}

/* Send a complete V2 frame when MTU >= 35; default-MTU peers use fragments. */
uint16_t ble_trx_notify_payload_size(uint16_t conn)
{
    const uint16_t mtu = rom_gap_api_get_mtu(conn);
    return mtu >= 23U ? (uint16_t)(mtu - 3U) : 20U;
}

bool ble_trx_notifications_enabled(uint16_t conn)
{
    return conn != 0U && conn == ble_event_get_conn_handle() &&
           conn == trx_notify_conn && (trx_notify_enabled & 1U) != 0U;
}

uint32_t ble_trx_notification_generation(void)
{
    return trx_notify_generation;
}

uint16_t ble_trx_get_current_connection(void)
{
    return ble_event_get_conn_handle();
}

static uint16_t trx_get_attrlen_cb(uint16_t conn, uint16_t attHdl)
{
    (void)conn;

    if (attHdl == trx_hdl_cccd_tx)
        return 2;

    return 0;
}

static uint16_t trx_read_attr_cb(uint16_t conn, uint16_t attHdl,uint16_t offset, uint8_t *buf,uint16_t bufLen)
{
    (void)conn;
    (void)offset;

    if (attHdl == trx_hdl_cccd_tx && buf != NULL && bufLen >= 2)
    {
        buf[0] = trx_notify_enabled;
        buf[1] = 0;
        return 2;
    }

    return 0;
}

static uint32_t trx_write_attr_cb(uint16_t conn, uint16_t attHdl,uint16_t mode, uint16_t offset,uint8_t *buf, uint16_t len)
{
    (void)conn;
    (void)mode;
    (void)offset;

    if (attHdl == trx_hdl_cccd_tx && buf != NULL && offset == 0U && len == 2U)
    {
        trx_notify_conn = conn;
        trx_notify_enabled = buf[0] & 1U;
        ++trx_notify_generation;
    }

    return ERR_STA_OK;
}



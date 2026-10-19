#ifndef HS300X_H
#define HS300X_H

#include <stdbool.h>
#include <stdint.h>

#define HS300X_I2C_ADDR_7BIT          (0x44U)
#define HS300X_WRITE_ADDR             (0x88U)
#define HS300X_READ_ADDR              (0x89U)

#define HS300X_CMD_ENTER_PROG         (0xA0U)
#define HS300X_CMD_EXIT_PROG          (0x80U)
#define HS300X_CMD_DUMMY_DATA         (0x00U)

#define HS300X_REG_RH_RES_READ        (0x06U)
#define HS300X_REG_RH_RES_WRITE       (0x46U)
#define HS300X_REG_TEMP_RES_READ      (0x11U)
#define HS300X_REG_TEMP_RES_WRITE     (0x51U)
#define HS300X_REG_READ_ID_UPPER      (0x1EU)
#define HS300X_REG_READ_ID_LOWER      (0x1FU)

#define HS300X_CONVERSION_TIME_MS     (40U)

typedef enum
{
    HS300X_STATUS_OK = 0,
    HS300X_STATUS_BUSY,
    HS300X_STATUS_NOT_READY,
    HS300X_STATUS_I2C_ERROR,
    HS300X_STATUS_STALE_DATA
} HS300X_STATUS_T;

extern float g_hs300x_humidity;
extern float g_hs300x_temperature;

void HS300X_Init(void);
HS300X_STATUS_T HS300X_StartMeasurement(void);
void HS300X_Process(void);

bool HS300X_IsBusy(void);
bool HS300X_DataReady(void);
void HS300X_ClearDataReady(void);
HS300X_STATUS_T HS300X_GetLastStatus(void);

#endif /* HS300X_H */

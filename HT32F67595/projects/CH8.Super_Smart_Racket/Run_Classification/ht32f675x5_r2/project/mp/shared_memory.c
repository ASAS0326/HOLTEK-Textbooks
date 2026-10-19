#include "shared_memory.h"

#include <stddef.h>
#include "cmsis_compiler.h"


/* =========================================================
 * Get available data size
 * ========================================================= */
uint32_t shared_memory_available(void)
{
    uint32_t write_index = SHARED_MEM->write_index;
    uint32_t read_index  = SHARED_MEM->read_index;

    if (write_index >= read_index)
    {
        return write_index - read_index;
    }
    else
    {
        return SHARED_DATA_SIZE - read_index + write_index;
    }
}


/* =========================================================
 * Get free space
 * Ring buffer reserves 1 byte to distinguish FULL / EMPTY
 * ========================================================= */
uint32_t shared_memory_free(void)
{
    return (SHARED_DATA_SIZE - 1U) - shared_memory_available();
}


/* =========================================================
 * Initialize shared memory
 *
 * Only MP should call this function.
 * CP must NOT initialize shared memory.
 * ========================================================= */
void shared_memory_init(void)
{
    uint32_t i;

    /*
     * ?? magic ??
     * ?? CP ????????????????
     */
    SHARED_MEM->magic = 0U;

    SHARED_MEM->write_index = 0U;
    SHARED_MEM->read_index  = 0U;
    SHARED_MEM->data_count  = 0U;

    for (i = 0U; i < SHARED_DATA_SIZE; i++)
    {
        SHARED_MEM->data[i] = 0U;
    }

    /*
     * ??????????
     */
    __DMB();

    /*
     * magic ???
     * CP ???? magic ?,????????
     */
    SHARED_MEM->magic = SHARED_MEM_MAGIC;

    __DMB();
}


/* =========================================================
 * Clear ring buffer
 *
 * ???? MP ????
 * ========================================================= */
void shared_memory_clear(void)
{
    SHARED_MEM->write_index = 0U;
    SHARED_MEM->read_index  = 0U;
    SHARED_MEM->data_count  = 0U;

    __DMB();
}


/* =========================================================
 * Write data
 *
 * Mainly used by MP.
 * ========================================================= */
bool shared_memory_write(const uint8_t *data, uint32_t len)
{
    uint32_t write_index;
    uint32_t i;

    if ((data == NULL) || (len == 0U))
    {
        return false;
    }

    /*
     * Shared memory ?????
     */
    if (SHARED_MEM->magic != SHARED_MEM_MAGIC)
    {
        return false;
    }

    /*
     * ????
     */
    if (len > shared_memory_free())
    {
        return false;
    }

    write_index = SHARED_MEM->write_index;

    /*
     * ????
     */
    for (i = 0U; i < len; i++)
    {
        SHARED_MEM->data[write_index] = data[i];

        write_index++;

        if (write_index >= SHARED_DATA_SIZE)
        {
            write_index = 0U;
        }
    }

    /*
     * ?? data[] ????
     * ??? write_index
     */
    __DMB();

    SHARED_MEM->write_index = write_index;

    /*
     * data_count ??????? / ????
     */
    SHARED_MEM->data_count = shared_memory_available();

    __DMB();

    return true;
}


/* =========================================================
 * Read data
 *
 * Mainly used by CP.
 * ========================================================= */
uint32_t shared_memory_read(uint8_t *data, uint32_t max_len)
{
    uint32_t available;
    uint32_t read_len;
    uint32_t read_index;
    uint32_t i;

    if ((data == NULL) || (max_len == 0U))
    {
        return 0U;
    }

    /*
     * MP ???????
     */
    if (SHARED_MEM->magic != SHARED_MEM_MAGIC)
    {
        return 0U;
    }

    available = shared_memory_available();

    if (available == 0U)
    {
        return 0U;
    }

    /*
     * ???????
     */
    if (available > max_len)
    {
        read_len = max_len;
    }
    else
    {
        read_len = available;
    }

    read_index = SHARED_MEM->read_index;

    /*
     * ????
     */
    for (i = 0U; i < read_len; i++)
    {
        data[i] = SHARED_MEM->data[read_index];

        read_index++;

        if (read_index >= SHARED_DATA_SIZE)
        {
            read_index = 0U;
        }
    }

    /*
     * ???????
     * ??? read_index
     */
    __DMB();

    SHARED_MEM->read_index = read_index;

    SHARED_MEM->data_count = shared_memory_available();

    __DMB();

    return read_len;
}
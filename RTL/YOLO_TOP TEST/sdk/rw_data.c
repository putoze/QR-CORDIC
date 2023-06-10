#include "ff.h"
#include "xaxidma.h"
#include "xparameters.h"
#include "xil_exception.h"
#include "xdebug.h"
#include "math.h"
#include "rw_data.h"

static FIL fil_file;
static FATFS fatfs;

// file names
// const static char file_input[32] = "dect_img1.dat";
// const static char file_input[32] = "dect_img1_2.dat";
const static char file_input[32] = "matrix_ori_sd.dat";
const static char file_out[32] = "matrix_exp_sd.dat";
// const static char file_input[32] = "dect_img3.dat";
// const static char file_input[32] = "dect_img3_2.dat";
// const static char file_input[32] = "dect_img4.dat";

// convert function
long str_to_long(char *temp2)
{
    long cal = 0, pow = 1, digit = 0;
    for (int j = 0; j < 8; j++)
    {
        // xil_printf("ori = %c\n", temp2[7-j]);
        if (temp2[7 - j] >= '0' && temp2[7 - j] <= '9') // 0~9
            digit = temp2[7 - j] - '0';
        else // a~f
            digit = temp2[7 - j] - 'a' + 10;
        // xil_printf("digit = %x\n", digit);
        cal += digit * pow;
        // xil_printf("cal = %x\n", cal);
        pow = pow * 16;
    }
    // xil_printf("CAL_NUM = %x  ",cal);
    // xil_printf("temp2 = %x  ",temp2);
    return cal;
}

// read data function
int READ_u64(int size, char **file_name, u64 *out)
{
    FRESULT Res;
    UINT NumBytesRead;

    u8 temp[18];
    char temp1[9];
    char temp2[9];
    long temp3;
    long temp4;
    u64 temp5;
    u64 temp6;

    Res = f_open(&fil_file, file_name, FA_READ);
    if (Res)
    {
        xil_printf("-- Failed at stage 2 --\r\n");
        return XST_FAILURE;
    }

    // Set pointer to beginning of file.
    Res = f_lseek(&fil_file, 0);
    if (Res)
    {
        xil_printf("-- Failed at stage 3 --\r\n");
        return XST_FAILURE;
    }

    // Read data from file.
    for (int i = 0; i < size; i++)
    {
        // 16 character each time(because dat file save in hex form)
        Res = f_read(&fil_file, (void *)temp, 16, &NumBytesRead);
        if (Res)
        {
            xil_printf("-- Failed at stage 4 --\r\n");
            return XST_FAILURE;
        }
        temp1[8] = '\0';
        temp2[8] = '\0';

        for (int j = 0; j < 8; j++)
        {
            temp1[j] = temp[j];
        }
        for (int j = 0; j < 8; j++)
        {
            temp2[j] = temp[j + 8];
        }

        temp3 = str_to_long(temp1);
        temp4 = str_to_long(temp2);
        temp5 = temp3 & 0x00000000FFFFFFFF;
        temp6 = temp4 & 0x00000000FFFFFFFF;

        // 64 bits unsigned int
        out[i] = (temp5 << 32) + temp6;
    }

    // Close file.
    Res = f_close(&fil_file);
    if (Res)
    {
        xil_printf("-- Failed at stage 5 --\r\n");
        return XST_FAILURE;
    }

    xil_printf("--- read data done ---\n");
}

int READ_DATA0()
{
    xil_printf("SD Card Reading...\n");

    FRESULT Res;
    UINT NumBytesRead;
    // indicates the root directory of the SD card
    TCHAR *Path = "0:/";

    // Mount the SD card to the file system
    Res = f_mount(&fatfs, Path, 0);
    if (Res != FR_OK)
    {
        xil_printf("-- Failed at stage 1 --\r\n");
        return XST_FAILURE;
    }

    // Read input data
    Res = READ_u64(IFMAP_SIZE, &file_input, (u64)&ifmap0);

    for (int i = 0; i < OFMAP_SIZE; i++)
    {
        data_out[i] = 0;
    }

    xil_printf("SD Card Reading Done!\n");
    return XST_SUCCESS;
}

int WRITE_DATA0()
{
    xil_printf("SD Card writing...\n");

    FRESULT Res;
    UINT NumBytesWrite;
    // indicates the root directory of the SD card
    TCHAR *Path = "0:/";

    // Mount the SD card to the file system
    Res = f_mount(&fatfs, Path, 0);
    if (Res != FR_OK)
    {
        xil_printf("-- Failed at stage 1 --\r\n");
        return XST_FAILURE;
    }

    // Read input data
    Res = WRITE_u64(OFMAP_SIZE, &file_out, (u64)&data_out);

    xil_printf("SD Card writing Done!\n");
    return XST_SUCCESS;
}

// read data function
int WRITE_u64(int size, char **file_name, u64 *out)
{
    FRESULT Res;
    UINT NumBytesWrite;

    Res = f_open(&fil_file, file_name, FA_WRITE);
    if (Res)
    {
        xil_printf("-- Failed at stage 2 --\r\n");
        return XST_FAILURE;
    }

    // Set pointer to beginning of file.
    Res = f_lseek(&fil_file, 0);
    if (Res)
    {
        xil_printf("-- Failed at stage 3 --\r\n");
        return XST_FAILURE;
    }

    // write 8*OFMAP byte number of data to sd card
    Res = f_write(&fil_file, (void *)out, 8 * size, &NumBytesWrite);

    if (Res)
    {
        xil_printf("-- Failed at stage 4 --\r\n");
        return XST_FAILURE;
    }

    // Close file.
    Res = f_close(&fil_file);
    if (Res)
    {
        xil_printf("-- Failed at stage 5 --\r\n");
        return XST_FAILURE;
    }

    xil_printf("--- write data done ---\n");
}

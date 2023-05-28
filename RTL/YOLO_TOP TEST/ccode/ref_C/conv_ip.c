#include "xaxidma.h"
#include "xparameters.h"
#include "xil_exception.h"
#include "xdebug.h"
/***************************** Include Files *********************************/
#include "xaxidma.h"
#include "xparameters.h"
#include "xil_exception.h"
#include "xdebug.h"
#include "xstatus.h"
#include "xscugic.h"
#include "conv_ip.h"
#include "axi_dma.h"
#include "sleep.h"

#include "read_data.h"
#include "xtime_l.h"

void TX_DATA(int size, u64* fmap){
    AXI_DMA_TxDone=0;
    AXI_DMA_RxDone=0;
    Xil_DCacheFlushRange((UINTPTR)(fmap), size*8);

    AXI_DMA_Transfer((UINTPTR)(fmap), size*8, XAXIDMA_DMA_TO_DEVICE);
    while (!AXI_DMA_TxDone) { }
    xil_printf("\n--- TX ifmap done ---");
}

void RX_DATA(int size, u64* fmap){
    AXI_DMA_TxDone=0;
    AXI_DMA_RxDone=0;
    Xil_DCacheFlushRange((UINTPTR)(fmap), size*8);

    AXI_DMA_Transfer((UINTPTR)(fmap), size*8, XAXIDMA_DEVICE_TO_DMA);
    while (!AXI_DMA_RxDone) { }
    xil_printf("\n--- RX ofmap done ---");
}

/***************************** Main Function *********************************/
void CONV_IP0(int layer){
    XTime start, end;
    u32 time_used;
    XTime_GetTime(&start);

    xil_printf("\nStart convolution...");
    TX_DATA(IFMAP_SIZE,(u64) &ifmap0);

    RX_DATA(OFMAP_SIZE,(u64) &data_out);
    xil_printf("\nConvolution done!", layer);

    XTime_GetTime(&end);
    time_used = ((end-start)*1000000)/(COUNTS_PER_SECOND);
    xil_printf("\nTime used: %d us\r\n", time_used);
}

#include <stdint.h>
#include <stddef.h>


#define PATTERN_SIZE 8

typedef uint8_t u8;
typedef uint64_t u64;
typedef uint32_t u32;


u64 SD_Transfer_Data [PATTERN_SIZE];
u64 SD_Receive_Data  [PATTERN_SIZE];
u64 DMA_Transfer_gold [PATTERN_SIZE/2];





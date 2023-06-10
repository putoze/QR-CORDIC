#ifndef SRC_RW_DATA_H_
#define SRC_RW_DATA_H_

//data size define
#define IFMAP_SIZE 8
#define OFMAP_SIZE 8

//store data
u64 *ifmap;
u64 ifmap0[IFMAP_SIZE];

u64 *ofmap;
u64 data_out[OFMAP_SIZE];

int READ_DATA0();
int WRITE_DATA0();

#endif /* SRC_RW_DATA_H_ */
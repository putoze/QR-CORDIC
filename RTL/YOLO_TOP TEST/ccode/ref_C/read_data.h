#ifndef SRC_READ_DATA_H_
#define SRC_READ_DATA_H_

//data size define
#define IFMAP_SIZE 24649
#define OFMAP_SIZE 4

//store data
u64 *ifmap;
u64 ifmap0[IFMAP_SIZE];

u64 *ofmap;
u64 data_out[OFMAP_SIZE];

int READ_DATA0();

#endif /* SRC_READ_DATA_H_ */

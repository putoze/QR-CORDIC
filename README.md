# CORDIC
## Design in RTL file
1. [Yolo Top works on FPGA](##Yolo-Top)

2. Test work on cellbase

3. matlab for TESBED and caculate delta

## Yolo Top

- 系統架構圖

![image](https://user-images.githubusercontent.com/97605863/202997122-d862c743-5413-4490-8203-e70f6ae453db.png)

- Top module輸入輸出介面

- Block Design

![image](https://user-images.githubusercontent.com/97605863/202997602-5382c8e9-5f31-44d7-be32-c88013301338.png)

- SDK Result

## Test

- 系統架構圖

![image](https://user-images.githubusercontent.com/97605863/202998033-fd78c170-3ba8-49e4-8a14-2e1fd9ac8acf.png)

- QR_CORDIC輸入輸出介面

Signal Name	I/O	Width	Simple Description
Clk	I	1	Clock Signal(posedge trigger)
Rst_n	I	1	Negedge reset
valid	I	1	valid為high，in資料開始輸入
out_valid	0	1	out_valid為high，out資料開始輸出
in	I	52	為第i列資料，4筆13bits資料組成輸入
out	0	52	為第i列資料，4筆13bits資料組成輸出


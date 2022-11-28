# **QR_CORDIC**
1. [Introduction](#Introduction)

2. [Yolo Top works on FPGA](#Yolo-Top)

3. [Test work on cellbase](#Test)

4. [Simulation outcome](#OUTCOME)

## Introduction
QR 分解是數值線性代數中具備多種用途的計算工具，主要應用於線性方程、最小平方法和特徵值問題。常見的 QR 分解的計算方法包括 Householder 變換、Givens rotation以及 Gram-Schmidt 正交法。本文使用given rotation搭配CORDIC Alogorithms。
<br/>
<br/>
此文實作採用 8×4 矩陣，每個數字大小定義在 ±0.25~±1 ，預期得到一組 8×4 的上三角矩陣R。實驗流程為先使用MATLAB估算預期使用定點數(fixed point)的長度(浮點數與定點數的誤差需足夠小)以及iteration的次數，再將MATLAB生成的隨機 8×4 矩陣以定點數格式匯入verilog，並將verilog算出答案與matlab算出答案做比較，最後使用FPGA做驗證。
<br/>
<br/>
CORDIC請參考 https://blog.csdn.net/Pieces_thinking/article/details/83512820

## Yolo Top

- 系統架構圖

![image](https://user-images.githubusercontent.com/97605863/203002404-6f9a46bf-ec7d-46d7-9278-560228de8797.png)

- Top module輸入輸出介面

- Block Design

![block diagram](https://user-images.githubusercontent.com/97605863/203002318-5a55a1a1-4547-4a3c-8c74-57fa3d79c694.png)

- SDK Result

## Test

- 系統架構圖

![image](https://user-images.githubusercontent.com/97605863/202998033-fd78c170-3ba8-49e4-8a14-2e1fd9ac8acf.png)

- QR_CORDIC輸入輸出介面

![image](https://user-images.githubusercontent.com/97605863/202998493-d49406dd-ebb4-478b-bdf6-68d5cbc55f0e.png)

- GG輸入輸出介面

![image](https://user-images.githubusercontent.com/97605863/202998558-9fd3c953-89b2-47f3-a619-225506bb0475.png)

- GR輸入輸出介面

![image](https://user-images.githubusercontent.com/97605863/202998649-0052eb1f-a649-4654-bbd5-95946cf3bd71.png)

## OUTCOME

- TESBED Simulation outcome

![TB_1](https://user-images.githubusercontent.com/97605863/202999296-115a79e7-dfbe-4f2e-9d79-21bca3ce2f8f.png)

![TB_2](https://user-images.githubusercontent.com/97605863/202999330-3444e699-a78d-4273-9a20-3687abd16421.png)

![TB_3](https://user-images.githubusercontent.com/97605863/203001987-94437228-0246-4b28-928e-02c5bea20b6b.png)

- Timing Report

![timing_1](https://user-images.githubusercontent.com/97605863/202999517-63f1e51a-c865-4728-9c8e-c2ab6d4a2777.png)

![timing_2](https://user-images.githubusercontent.com/97605863/202999543-3af719b7-35f5-44eb-805b-75ccbaa7aa19.png)

- Area

![area](https://user-images.githubusercontent.com/97605863/202999610-06c480d1-27ba-4b91-b5e2-dd8fd6f65399.png)




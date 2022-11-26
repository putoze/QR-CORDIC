# How to use my TESTBED

1.input value will enter while valid is high

2.input value will pass one column of data in a clk and the first data is column 8, for example 
8*4 matrix is 
[
$[X_{11} X_{12} X_{13} X_{14}]$
<br />
.
.
.
$[X_{81} X_{82} X_{83} X_{84}]$
]
the first input data will be
$[X_{81} X_{82} X_{83} X_{84}]$ at clk one, 
next data in will be $[X_{71} X_{72} X_{73} X_{74}]$ at clk two, 
and so on

3.output value only can pass while out_valid is high, and TESTBED will check your out data in successive 8 clk, simularly start from column 8, for example, whlle out_valid is hign, the first cycle will check your first out data equal to $[X_{81} X_{82} X_{83} X_{84}]$ or not, if fail, it will show fail task. After 8 clk, your out_valid should pull down.


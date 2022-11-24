# Some note you may want to know
1. When you are doing vector mode or rotation mode, you need to return it into fixed point, or you may get the differnt fixed point numberd

2. When you use fixed function, you should add "Floor" function to trancate number, or you may get differnet result with your verilog code(you can write your rounding code in verilog to met the same result with matlab code either).

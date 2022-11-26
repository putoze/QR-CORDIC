function alpha = angle_lut(i)
%%% Lookup table of the angle arctan(2^(-i)) decided by the ith iteration
%%% i  α(i)  tan(α(i))
%%% 0  45.0°  2^(-0)
%%% 1  26.6°  2^(-1)
%%% 2  14.0°  2^(-2)
%%% 3   7.1°  2^(-3)
%%% 4   3.6°  2^(-4)
%%% 5   1.8°  2^(-5)
%%% 6   0.9°  2^(-6)
%%% 7   0.4°  2^(-7)
%%% 8   0.2°  2^(-8)
%%% 9   0.1°  2^(-9)

switch i
    case 0
        alpha = 45;
    case 1
        alpha = 26.6;
    case 2
        alpha = 14;
    case 3
        alpha = 7.1;
    case 4
        alpha = 3.6;
    case 5
        alpha = 1.8;
    case 6
        alpha = 0.9;
    case 7
        alpha = 0.4;
    case 8
        alpha = 0.2;
    case 9
        alpha = 0.1;
    otherwise
        alpha = 0;
end
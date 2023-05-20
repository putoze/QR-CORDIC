function [X, Y, do] = vector_mode(x, y, iter_num, xy_len, xy_frac, F)

% Initialize X, Y
X = x;
Y = y;
do = zeros(iter_num,1);
for iter = 0 : iter_num
    d = -sign(X*Y);
    do(iter+1) = d;
    % store x(i) and y(i)
    X_temp = X;
    Y_temp = Y;
    X = X - d * bitsra(Y_temp, iter);
    % truncate X to fixed point each iteration
    X = fi(X, 1, xy_len, xy_frac,F);
    %display(X.dec);
    Y = Y + d * bitsra(X_temp, iter);
    % truncate Y to fixed point each iteration
    Y = fi(Y, 1, xy_len, xy_frac,F);
end

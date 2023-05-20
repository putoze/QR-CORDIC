function [X, Y] = rotation_mode(x, y, iter_num, xy_len, xy_frac, di,F)

% Initialize X, Y
X = x;
Y = y;
for iter = 0 : iter_num
    d = di(iter+1);
    % store x(i) and y(i)
    X_temp = X;
    Y_temp = Y;
    % cal X
    X = X - d * bitsra(Y_temp, iter);
    % truncate X to fixed point each iteration
    X = fi(X, 1, xy_len, xy_frac,F);
    % cal Y
    Y = Y + d * bitsra(X_temp, iter);
    % truncate Y to fixed point each iteration
    Y = fi(Y, 1, xy_len, xy_frac,F);
end

function [X, Y, Z, K] = vectoring_mode(x, y, z, iter_num, xy_len, xy_frac, k_len, k_frac, z_len, z_frac)

% Initialize X, Y, Z, K
X = x;
Y = y;
Z = z;
K = 1;
F = fimath('RoundingMethod','Floor');
%display(Y.dec);
% Iterate iter_num times
for iter = 0:iter_num
    % decide the rotation direction
    % +1 means counterclockwise, -1 means clockwise
    d = -sign(X * Y);
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
    %display(Y.dec);
    alpha = angle_lut(iter);
    % truncate alpha to fixed point each iteration
    alpha_fix = fi(alpha, 1, z_len, z_frac);
    Z = Z - d * alpha_fix;
    % truncate Z to fixed point each iteration
    Z = fi(Z, 1, z_len, z_frac);
    K = K * cosd(alpha);
    % truncate K to fixed point each iteration
    K = fi(K, 1, k_len, k_frac);
end

% Multiply K by X at the final stage
X = X * K;
% Truncate X to fixed point the same as input
X = fi(X, 1, xy_len, xy_frac,F);
%display(X.dec);
% Multiply K by Y at the final stage
Y = Y * K;
% Truncate Y to fixed point the same as input
Y = fi(Y, 1, xy_len, xy_frac,F);
%display(Y.dec);
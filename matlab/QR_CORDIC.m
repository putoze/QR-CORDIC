function [delta,R,R_CORDIC] = QR_CORDIC(A, row, col)
% Q1 : determine the word length of matrix R using trigonometric functions
% Q2 : replace the trigonometric functions with the CORDIC scheme and determine the required iteration number
% Q3 : determine the word length of the scaling factor K
%%%% ask : please use MatLab to generate at least 10 random matrices of size 84 and with a
%%%  full column rank (4) and the specification δ < 0.01

%%% Phase 1
% create a row by row identity matrix
Q_inv = eye(row);
% A = QR, Q_inv*A = R
R = A;
% Eliminate A(q+1,p) by A(q,p)
for p = 1:col % eliminate from left to right
    for q = (row-1):(-1):p % eliminate from bottom to top
        Q_inv_single = eye(row);
        rot_angle = atan2(R(q+1,p), R(q,p));
        Q_inv_single(q  ,q  ) =  cos(rot_angle);
        Q_inv_single(q  ,q+1) =  sin(rot_angle);
        Q_inv_single(q+1,q  ) = -sin(rot_angle);
        Q_inv_single(q+1,q+1) =  cos(rot_angle);
        % inverse of Q matrix
        Q_inv = Q_inv_single * Q_inv;
        % A matrix after one rotation
        R = Q_inv_single * R;
    end
end
% Q matrix
% Q = inv(Q_inv);
% check if Q is unitary (Q*Q'=I)
% Q_check = Q * Q';


%%% Phase 2
% step 1 : initailize variable
iter_num = 7;
xy_dec = 2;
xy_frac = 10;
xy_len = 1 + xy_dec + xy_frac;
K = 1;
k_dec = 0;
k_frac = 10;
k_len = 1 + k_dec + k_frac;
% rounding skill
F = fimath('RoundingMethod','Floor');
% cal K
for iter = 0 : iter_num
    %angle = 90/(2^(iter+1));
    angle = angle_lut(iter);
    K = K * cosd(angle);
    % truncate K to fixed point each iteration
    K = fi(K, 1, k_len, k_frac);
end
%display(K);

%turn into fixed point
R_CORDIC = fi(A, 1, xy_len, xy_frac,F);
%display(R_CORDIC);
for p = 1:col % eliminate from left to right
    for q = (row-1):(-1):p
        % eliminate from bottom to top
        if R_CORDIC(q,p) < 0
            for rev = p:col
                R_CORDIC(q  ,rev) = -R_CORDIC(q  ,rev);
                R_CORDIC(q+1,rev) = -R_CORDIC(q+1,rev);
            end
        end
        %%% vector_mode
        x_v = R_CORDIC(q,p);
        y_v = R_CORDIC(q+1,p);
        [X_v, Y_v, do] = vector_mode(x_v, y_v, iter_num, xy_len, xy_frac, F);
        % passing 8 sign bits
        di = do;
        % X_v
        X_v = X_v*K;
        R_CORDIC(q,p) = fi(X_v, 1, xy_len, xy_frac,F);
        % Y_v
        Y_v = Y_v*K;
        R_CORDIC(q+1,p) = fi(Y_v, 1, xy_len, xy_frac,F);
        %%% rotation_mode
        for rot_col = (p+1) : col
            [X_r, Y_r] = rotation_mode(R_CORDIC(q,rot_col), R_CORDIC(q+1,rot_col), iter_num, xy_len, xy_frac, di,F);
            % X_r
            X_r = X_r*K;
            R_CORDIC(q,rot_col) = fi(X_r, 1, xy_len, xy_frac,F);
            % Y_r
            Y_r = Y_r*K;
            R_CORDIC(q+1,rot_col) = fi(Y_r, 1, xy_len, xy_frac,F);
        end
    end
end
display(R);
display(R_CORDIC);

% cal delta
delta = quantization_error(R, R_CORDIC);
display(delta);
function delta = quantization_error(R, R_hat)
%%% Calculate the quantization error value of R matrices between floating
%%% point calculation R and fixed point calculation R_hat.
%%%           ____________________
%%%         \/ Σ(r_ij-r_hat_ij)^2      r_ij: floating point
%%% δ = ____________________________   r_hat_ij: fixed point
%%%                ___________          ith row, jth column
%%%              \/ Σ(r_ij)^2

% Get the row and column number of R matrix
[row, col] = size(R);

% Initialize Σ(r_ij-r_hat_ij)^2 and Σ(r_ij)^2
r_diff_sqr_sum = 0;
r_sqr_sum = 0;

% Calculate (r_ij-r_hat_ij)^2 and (r_ij)^2 for each nonzero element in R 
% and R_hat. Accumulate them after each calculation.
for i = 1:col
    for j = i:col
        r_diff_sqr = (abs(R(i,j))-abs(R_hat(i,j)))^2;
        r_diff_sqr_sum = r_diff_sqr_sum + r_diff_sqr;
        r_sqr = (R(i,j))^2;
        r_sqr_sum = r_sqr_sum + r_sqr;
    end
end

% Calculate the quantization error value δ
delta = sqrt(r_diff_sqr_sum) / sqrt(r_sqr_sum);
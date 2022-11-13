function A = random_matrix(m, n)
%%% Generate a 8-bit wide random mxn matrix A. All magnitudes of all matrix 
%%% elements should be confined to a range of (min_val~max_val) and can be 
%%% either positive or negative.

% Generate a 8-bit wide random mxn matrix A_abs with magnitudes of all 
% elements ranging from +1/4 to +1.
% In binary: 0.0100000 ~ 1.0000000
A_abs = randi([32,128], m, n) ./ 128;

% Use randi function to generate +1, -1
sign_A = randi([0,1], m, n);
for i = 1:(m*n)
    if(sign_A(i) == 0)  
        sign_A(i) = -1;
    end
end

% Multiply A_abs by -1 with 50% probability
A = sign_A .* A_abs;
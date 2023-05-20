% Step 1
row = 8; % row number of A matrix
col = 4; % column number of A matrix
times = 10; % total times of testbed
% Call self-defined function 
delta_sum = 0;
tic
for idx = 0 : times
    A = random_matrix(row, col);
    [delta,R,R_CORDIC] = QR_CORDIC(A, row, col);
    delta_sum = delta_sum + delta;
end
timeElapsed = toc;
disp(timeElapsed);
delta_mean = delta_sum/10;
display(delta_mean);
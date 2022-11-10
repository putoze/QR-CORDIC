row = 8;
col = 4;
A1 = random_matrix(row, col);
while 1
    if rank(A1) == min(row,col)
        break
    else
        A1 = random_matrix(row, col);
    end
end

A1 = fi(A1, 1, 8, 6);
fid = fopen('matrix_1.txt','wt');
fprintf(fid,'%g\n',A1);
fclose(fid);
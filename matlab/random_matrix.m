%%% All magnitudes of all matrix elements should be confined to a range of (1~1/4)
%%% and can be either positive or negative
function A1 =  random_matrix(row,col)
    A1 = zeros(row,col);
    while 1
        for i = 1:row
            for j = 1:col
                A1(i,j) = rand(1,'double')*0.75 + 0.25;
            end
        end
        %Check if A has full column rank 4
        if rank(A1) == min(row,col)
            break
        end
    end
end

function [new_max,new_min,set,nonset] = get_matrix_min_max(A,n)
% A is the matrix
% n is the dimension of the matrix

set = [];nonset = [];
new_max = zeros(n);
new_min = zeros(n);
% for each entry
% element wise min-max for 2 by 2 matrix
for m1 = 1:n
    for m2 = 1:n
        new_max(m1,m2) = max(A(m1,m2,:));
        new_min(m1,m2) = min(A(m1,m2,:)); 
        if new_max(m1,m2) ==new_min(m1,m2)
            set = [set;m1,m2];
        else
            nonset = [nonset;m1,m2];
        end
    end
end
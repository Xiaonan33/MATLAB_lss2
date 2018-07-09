function B = generate_matrix_from_min_max(min,max,n,set,nonset)


% mn represents the number of set element in the matrix
[~,mn] = size(set);

B = zeros(n,n,2^(4-mn));

for n = 1:2^(4-mn)
    s = isempty(set);
    if s == 0
    for m4 = 1:mn
        m1 = set(m4,1);
        m2 = set(m4,2);
        B(m1,m2,n) = max(m1,m2);
    end
    end
    
    for m3 = 1:4-mn
        m1 = nonset(m3,1);
        m2 = nonset(m3,2);
        
        if mod(n,2^(m3)) >=2^(m3-1)
            B(m1,m2,n) = max(m1,m2);
        else
            B(m1,m2,n) = min(m1,m2);
        end
    end
end
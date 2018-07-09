clear all

A_cl{1}(:,:,1) =[1.0000    0.1000; -4.2285   -0.1470];
A_cl{1}(:,:,2) =[1.0000    0.1000; -4.1885   -0.1470];
A_cl{1}(:,:,3) =[1.0000    0.1000; -6.2427   -0.7124];
A_cl{1}(:,:,4) =[1.0000    0.1000; -6.2827   -0.7124];
A_cl{1}(:,:,5) =[1.0000    0.1000; -6.2427   -0.7204];
A_cl{1}(:,:,6) =[1.0000    0.1000; -6.2827   -0.7204];
A_cl{1}(:,:,7) =[1.0000    0.1000; -4.1885   -0.1550];
A_cl{1}(:,:,8) =[1.0000    0.1000; -4.2285   -0.1550];
n = 2;
t = zeros(10,4);
%% A_cl
[~,~,p] = size(A_cl{1});
[A_cl_smallg{1},A_cl_bigg{1},setg{1},nonsetg{1}] = get_matrix_min_max(A_cl{1},n);
NewAg{1} = generate_matrix_from_min_max(A_cl_smallg{1},A_cl_bigg{1},n,setg{1},nonsetg{1});
NewAg2{1} = NewAg{1};

A_clv{1} = A_cl{1};
% A_cl_general

for N = 2:8
    % Full computation
    tic
    for i1 = 1:p
        for i2 = 1:p^(N-1)
        A_cl{N}(:,:,p*(i2-1)+i1) = A_cl{N-1}(:,:,i2)*A_cl{1}(:,:,i1);
        end
    end
    [A_cl_big{N},A_cl_small{N},set{N},nonset{N}] = get_matrix_min_max(A_cl{N},n);
    NewA{N} = generate_matrix_from_min_max(A_cl_small{N},A_cl_big{N},n,set{N},nonset{N});

    [~,~,p2] = size(NewAg{N-1});
    t(N,1) = toc;

    % Reduced model
    for i1 = 1:p2
        for i2 = 1:p
        A_clg{N}(:,:,(i2-1)*p2+i1)= NewAg{N-1}(:,:,i1)*A_cl{1}(:,:,i2);
        end
    end

    [A_cl_bigg{N},A_cl_smallg{N},setg{N},nonsetg{N}] = get_matrix_min_max(A_clg{N},n);
    NewAg{N} = generate_matrix_from_min_max(A_cl_smallg{N},A_cl_bigg{N},n,setg{N},nonsetg{N});
    
    t(N,2) = toc;
    
    if N>=3
    [~,~,p3] = size(NewAg{N-2});
    NewAg2{2} = NewAg{2};
    %Reduce model - 2 step extended
    for i1 = 1:p3
        for i2 = 1:p
            for i3 = 1:p
            A_clg2{N}(:,:,(i1-1)*p*p+(i2-1)*p+i3)= NewAg2{N-2}(:,:,i1)*A_cl{1}(:,:,i2)*A_cl{1}(:,:,i3);
            end
        end
    end
    
    

    [A_cl_bigg2{N},A_cl_smallg2{N},setg2{N},nonsetg2{N}] = get_matrix_min_max(A_clg2{N},n);
    NewAg2{N} = generate_matrix_from_min_max(A_cl_smallg2{N},A_cl_bigg2{N},n,setg2{N},nonsetg2{N});
    
    t(N,4) = toc;
    end
    
    % Vertex
    
    for i=1:p
        A_clv{N}(:,:,i) = A_clv{N-1}(:,:,i)*A_cl{1}(:,:,i);
    end

    [A_cl_bigv{N},A_cl_smallv{N},setv{N},nonsetv{N}] = get_matrix_min_max(A_clv{N},n);
    t(N,3) = toc;
    
end

for n = 2:9
    t_diff(n-1,1) = t(n,1);             % time for full computation
    t_diff(n-1,2) = t(n,2)-t(n,1);      % time for reduce model
    t_diff(n-1,3) = t(n,4)-t(n,2);      % time for reduce model (extended)
    t_diff(n-1,4) = t(n,3)-t(n,4);      % time for vertex
end

save('A_cl.mat')
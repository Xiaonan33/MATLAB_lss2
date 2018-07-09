clear all

A_cl(:,:,1) =[1.0000    0.1000; -4.2285   -0.1470];
A_cl(:,:,2) =[1.0000    0.1000; -4.1885   -0.1470];
A_cl(:,:,3) =[1.0000    0.1000; -6.2427   -0.7124];
A_cl(:,:,4) =[1.0000    0.1000; -6.2827   -0.7124];
A_cl(:,:,5) =[1.0000    0.1000; -6.2427   -0.7204];
A_cl(:,:,6) =[1.0000    0.1000; -6.2827   -0.7204];
A_cl(:,:,7) =[1.0000    0.1000; -4.1885   -0.1550];
A_cl(:,:,8) =[1.0000    0.1000; -4.2285   -0.1550];

%% A_cl
[~,~,p] = size(A_cl);
set = [];nonset = [];
% for each entry
% element wise min-max for 2 by 2 matrix
for m1 = 1:2
    for m2 = 1:2
        NewA_big(m1,m2) = max(A_cl(m1,m2,:));
        NewA_small(m1,m2) = min(A_cl(m1,m2,:)); 
        if NewA_big(m1,m2) ==NewA_small(m1,m2)
            set = [set;m1,m2];
        else
            nonset = [nonset;m1,m2];
        end
    end
end

% mn represents the number of set element in the matrix
[~,mn] = size(set);

NewA = zeros(2,2,2^(4-mn));
% re-generate the combination with mix and max values
for n = 1:2^(4-mn)
    for m4 = 1:mn
        m1 = set(m4,1);
        m2 = set(m4,2);
        NewA(m1,m2,n) = NewA_big(m1,m2);
    end
    
    for m3 = 1:4-mn
        m1 = nonset(m3,1);
        m2 = nonset(m3,2);
        
        if mod(n,2^(m3)) >=2^(m3-1)
            NewA(m1,m2,n) = NewA_big(m1,m2);
        else
            NewA(m1,m2,n) = NewA_small(m1,m2);
        end
    end
end

% figure
% for i = 1:p
% plot(A_cl(1,1,i),A_cl(1,2,i),'x')
% hold on
% plot(A_cl(2,1,i),A_cl(2,2,i),'*')
% hold on
% end

%% A_cl2
% calculate the full calculation of A_cl
for i1 = 1:p
    for i2 = 1:p
        A_cl2(:,:,(i2-1)*p+i1)= A_cl(:,:,i1)*A_cl(:,:,i2);
    end
end


set2 = [];nonset2 = [];
% compute the element wise min max for full calculation A_cl2
for m1 = 1:2
    for m2 = 1:2
        NewA_big2(m1,m2) = max(A_cl2(m1,m2,:));
        NewA_small2(m1,m2) = min(A_cl2(m1,m2,:)); 
        if NewA_big2(m1,m2) ==NewA_small2(m1,m2)
            set2 = [set2;m1,m2];
        else
            nonset2 = [nonset2;m1,m2];
        end
    end
end

% mn represents the number of set element in the matrix
[~,mn2] = size(set2);

NewA2 = zeros(2,2,2^(4-mn2));
% regenerate the full combination of min max of A_cl2 (full computation)
for n = 1:2^(4-mn2)
    for m4 = 1:mn2
        m1 = set2(m4,1);
        m2 = set2(m4,2);
        NewA2(m1,m2,n) = NewA_big2(m1,m2);
    end
    
    for m3 = 1:4-mn2
        m1 = nonset2(m3,1);
        m2 = nonset2(m3,2);
        
        if mod(n,2^(m3)) >=2^(m3-1)
            NewA2(m1,m2,n) = NewA_big2(m1,m2);
        else
            NewA2(m1,m2,n) = NewA_small2(m1,m2);
        end
    end
end

%% A_cl2 using past general values
[~,~,p2] = size(NewA);

% calculation the computation for the reduced A_cl2g
for i1 = 1:p2
    for i2 = 1:p2
        A_cl2g(:,:,(i2-1)*p2+i1)= NewA(:,:,i1)*NewA(:,:,i2);
    end
end

set2g = [];nonset2g = [];
% calculate the min-max entries for A_cl2g
for m1 = 1:2
    for m2 = 1:2
        NewA_big2g(m1,m2) = max(A_cl2g(m1,m2,:));
        NewA_small2g(m1,m2) = min(A_cl2g(m1,m2,:)); 
        if NewA_big2g(m1,m2) ==NewA_small2g(m1,m2)
            set2g = [set2g;m1,m2];
        else
            nonset2g = [nonset2g;m1,m2];
        end
    end
end

% mn represents the number of set element in the matrix
[~,mn2g] = size(set2g);

NewA2 = zeros(2,2,2^(4-mn2g));
% regenerate the full combination of min max of A_cl2 (full computation)
for n = 1:2^(4-mn2g)
    if isemtpy(set2g) == 0
    for m4 = 1:mn2g
        m1 = set2(m4,1);
        m2 = set2(m4,2);
        NewA2(m1,m2,n) = NewA_big2(m1,m2);
    end
    end
    
    for m3 = 1:4-mn2g
        m1 = nonset2g(m3,1);
        m2 = nonset2g(m3,2);
        
        if mod(n,2^(m3)) >=2^(m3-1)
            NewA2g(m1,m2,n) = NewA_big2g(m1,m2);
        else
            NewA2g(m1,m2,n) = NewA_small2g(m1,m2);
        end
    end
end

% figure
% for i = 1:p^2
% plot(A_cl2(1,1,i),A_cl2(1,2,i),'b*')
% hold on
% plot(A_cl2(2,1,i),A_cl2(2,2,i),'gx')
% hold on   
% end

%% Vertex wise A_cl2v
for i=1:p
    A_cl2v(:,:,i) = A_cl(:,:,i)*A_cl(:,:,i);
end

set2v = [];nonset2v = [];
% calculate the min-max entries for A_cl2v
for m1 = 1:2
    for m2 = 1:2
        NewA_big2v(m1,m2) = max(A_cl2v(m1,m2,:));
        NewA_small2v(m1,m2) = min(A_cl2v(m1,m2,:)); 
        if NewA_big2v(m1,m2) ==NewA_small2v(m1,m2)
            set2v = [set2;m1,m2];
        else
            nonset2v = [nonset2;m1,m2];
        end
    end
end


%% A_cl3
for i1 = 1:p
    for i2 = 1:p
        for i3 = 1:p
        A_cl3(:,:,(i3-1)*p*p+(i2-1)*p+i1)= A_cl2(:,:,(i2-1)*p+i1)*A_cl(:,:,i3);
        end
    end
end

set3 = [];nonset3 = [];
% compute the element wise min max for full calculation A_cl2
for m1 = 1:2
    for m2 = 1:2
        NewA_big3(m1,m2) = max(A_cl3(m1,m2,:));
        NewA_small3(m1,m2) = min(A_cl3(m1,m2,:)); 
        if NewA_big3(m1,m2) ==NewA_small3(m1,m2)
            set3 = [set3;m1,m2];
        else
            nonset3 = [nonset3;m1,m2];
        end
    end
end

%% A_cl3g, which is the reduced model

p3 = 2^4;

% calculation the computation for the reduced A_cl2g
for i1 = 1:p3
    for i2 = 1:p3
        A_cl2g(:,:,(i2-1)*p2+i1)= NewA(:,:,i1)*NewA(:,:,i2);
    end
end

set2g = [];nonset2g = [];
% calculate the min-max entries for A_cl2g
for m1 = 1:2
    for m2 = 1:2
        NewA_big2g(m1,m2) = max(A_cl2g(m1,m2,:));
        NewA_small2g(m1,m2) = min(A_cl2g(m1,m2,:)); 
        if NewA_big2g(m1,m2) ==NewA_small2g(m1,m2)
            set2g = [set2;m1,m2];
        else
            nonset2g = [nonset2;m1,m2];
        end
    end
end


% figure
% for i = 1:p^3
% plot(A_cl3(1,1,i),A_cl3(1,2,i),'r*')
% hold on
% plot(A_cl3(2,1,i),A_cl3(2,2,i),'yx')
% hold on   
% end

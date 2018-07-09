
%load('A_cl.mat')
xk0 = [1;1];

[~,~,p4] = size(A_cl{4});
for i = 1:p4
    x4(:,i)=A_cl{4}(:,:,i)*xk0;
end

p4_max(1,1) = max(x4(1,:));
p4_max(2,1) = max(x4(2,:));
p4_min(1,1) = min(x4(1,:));
p4_min(2,1) = min(x4(2,:));

[~,~,p4g] = size(A_clg{4});
for i = 1:p4g
    x4g(:,i)=A_clg{4}(:,:,i)*xk0;
end

p4g_max(1,1) = max(x4g(1,:));
p4g_max(2,1) = max(x4g(2,:));
p4g_min(1,1) = min(x4g(1,:));
p4g_min(2,1) = min(x4g(2,:));

[~,~,p4v] = size(A_clv{4});
for i = 1:p4v
    x4v(:,i)=A_clv{4}(:,:,i)*xk0;
end

p4v_max(1,1) = max(x4v(1,:));
p4v_max(2,1) = max(x4v(2,:));
p4v_min(1,1) = min(x4v(1,:));
p4v_min(2,1) = min(x4v(2,:));
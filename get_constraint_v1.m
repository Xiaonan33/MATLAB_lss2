% the get_constraint function should be applicable to both examples
% which means, the w term can be a scalar or a vector
% the model of the system can be changing over iteration

function hi = get_constraint_v1(A_cl,D,N,F,G,K,W)

% definition of term
% A_cl is the model
% State constraint in the form of Fx<= 1
% Input constraint in the form of Gu<= 1

% optimize over w, where w are within the range Ww<=1


% p is the number of vertices of uncertainty set
[~,~,p]= size(A_cl);

% the constraint satisfaction horizon is N
for n = 1:N
    lmi = [];
    sdpvar wx(2,1)
    sdpvar cost_max
    ops = sdpsettings('solver','sdpt3');
    ops = sdpsettings(ops,'verbose',0);
    lmi = [lmi,W*wx<=1];
    
    cost_max = max();
    
    
    
end


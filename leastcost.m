clc
clear all
demand = [30 25 35 40];
supply = [50 40 70];
cost = [11 20 7 8;
        21 16 10 12;
        8 12 18 9];

[m n] = size(cost);
if sum(supply) == sum(demand)
    disp('Balanced problem');
elseif sum(supply) < sum(demand)
        disp('Unbalanced Problem');
        cost(end + 1,:) = zeros(1,n);
        supply(end + 1) = sum(demand) - sum(supply);
else
    disp('Unbalanced Problem')
    cost(:,end + 1) = zeros(m,1);
    demand(end + 1) = sum(supply) - sum(demand);
end
disp('Balanced Problem')


[m n] = size(cost);
X = zeros(m,n);
Icost = cost;
while any(supply > 0) && any(demand > 0)
    min_cost = min(cost(:));
    [r c] = find(cost == min_cost);
    y = min(supply(r), demand(c));
    [aloc, index] = max(y);
    rr = r(index);
    cc = c(index);
    X(rr,cc) = aloc;
    supply(rr) = supply(rr) - aloc;  %supply(rr) - y
    demand(cc) = demand(cc) - aloc; %supply(cc) - y
    if supply(rr) == 0
        cost(rr,:) = Inf;
    end
    if demand(cc) == 0
        cost(:,cc) = Inf;
    end
end



if nnz(X) == m + n - 1
    disp('Non-Degenerate Solution')
else
    disp('Degenerate Solution')
end

%%LEAST COST
Matrix = Icost .*  X
Final_cost = sum(Matrix(:))
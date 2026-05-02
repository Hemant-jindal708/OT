clc
clear all
B = [30 25 35 40];
A = [50 40 70];
cost = [11 20 7 8;
        21 16 10 12;
        8 12 18 9];
if sum(A)==sum(B)
    fprintf("Problem is balanced")
else
    fprintf("Problem is unbalanced")
    if sum(A)<sum(B)
        cost(end+1,:)=zeros(1,length(B))
        A(end+1)=sum(B)-sum(A)
    elseif sum(A)>sum(B)
        cost(:,end+1)=zeros(length(A),1)
        B(end+1)=sum(A)-sum(B)
    end
end
Icost = cost;
X = zeros(size(cost));
[m,n]=size(cost);
BFS=m+n-1;
for i = 1:size(cost,1)
    for j=1:size(cost,2)
        hh = min(cost(:));
        [row_index col_index]=find(hh==cost);
        x11 = min(A(row_index),B(col_index));
        [value,index]=max(x11);
        ii=row_index(index);
        jj=col_index(index);
        y11=min(A(ii),B(jj));
        X(ii,jj)=y11;
        A(ii)=A(ii)-y11;
        B(jj)=B(jj)-y11;
        cost(ii,jj)=inf;
    end
end
fprintf("BFS=\n");
IBFS = array2table(X);
disp(IBFS)
totalBFS=length(nonzeros(X));
if totalBFS == BFS
    fprintf("initial BFS is Non Degenerate\n");
else
    fprintf("initial BFS is Degenerate\n")
end 
totalCost = sum(sum(X .* Icost));
fprintf("Total transportation cost: %.2f\n", totalCost);

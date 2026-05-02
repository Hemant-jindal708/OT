clc
clear all
B = [30 25 35 40];
A = [50 40 70];
cost = [11 20 7 8;
        21 16 10 12;
        8 12 18 9];
if sum(A)==sum(B)
    fprintf("balanced");
else
    fprintf("unbalanced");
    if sum(A)>sum(B)
        cost(:,end+1)=zeros(length(A),1)
        B(end+1)=sum(A)-sum(B)
    else
        B(end+1)=sum(A)-sum(B)
        cost(end+1,:)=zeros(1,length(B))
    end
end
X=zeros(size(cost));
[m,n]=size(cost);
BFS = m+n-1;
Icost=cost;
for i=1:m
    for j=1:n
        hh=min(cost(:));
        [row col]=find(cost==hh);
        x11=min(A(row),B(col));
        [val,index]=max(x11);
        ii=row(index);
        jj=col(index);
        y11=min(A(ii),B(jj));
        A(ii)=A(ii)-y11;
        B(jj)=B(jj)-y11;
        X(ii,jj)=y11;
        cost(ii,jj) = inf;
    end
end
totalBFS=length(nonzeros(X));
if(BFS==totalBFS)
    fprintf("non degenerate");
else
    fprintf("degenerate");
end
totalCost=sum(sum(X.*Icost))
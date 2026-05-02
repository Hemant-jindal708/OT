clc 
clear all
format short
info = [3 -1 2;-2 4 0;-4 3 8];
c = [-1 3 -2];
b=[7;12;10];
NoOfVar=size(info,2);
s= eye(size(info,1));
A=[info s b];
bv = NoOfVar+1:size(A,2)-1;
cost = zeros(1,size(A,2));
cost(1:NoOfVar) = c; 
zRow = cost(bv) * A - cost;
Run = true;
while Run
    if any(zRow<0)
        [minVal,Pvt_column]=min(zRow(1:end-1));
        sol = A(:,end);
        ratio = zeros(size(A,1),1);
        for i = 1:size(A,1)
            if A(i,Pvt_column)>0
                ratio(i)=sol(i)/A(i,Pvt_column);
            else
                ratio(i)=inf;
            end
        end
        [minRatio,Pvt_Row]=min(ratio);
        A(Pvt_Row,:)=A(Pvt_Row,:)./A(Pvt_Row,Pvt_column);
        bv(Pvt_Row)=Pvt_column;
        for i= 1:size(A,1)
            if i~= Pvt_Row
                A(i,:)=A(i,:)-A(i,Pvt_column)*A(Pvt_Row,:);
            end
        end
        zRow = cost(bv)*A-cost;
        zjcj = [zRow;A];

        BFS = zeros(size(A,2)-1,1);
        BFS(bv)=A(:,end);
        sol=sum(cost(1:end-1)*BFS);
        sol
        zjcj
    else
        fprintf("optimalty Reached\n");
        display(array2table([BFS;sol]'))
        Run= false;
    end
end

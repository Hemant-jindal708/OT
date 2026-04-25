clc
clear all
format short
C=[-1 3 -2];
info=[3 -1 2;-2 4 0;-4 3 8];
b=[7; 12; 10];
NoVariables=size(info,2);
s=eye(size(info,1));
A=[info s b];
Cost=zeros(1,size(A,2));
Cost(1:NoVariables)=C;
BV=NoVariables+1:size(A,2)-1;
% calculate Zj-Cj
ZRow=Cost(BV)*A-Cost;
ZjCj=[ZRow;A];
SimpTable=array2table(ZjCj);
SimpTable.Properties.VariableNames(1:size(ZjCj,2))={'x_1','x_2','x_3','s_1','s_2','s_3','Sol'}

Run=true;
while Run
    if any(ZRow<0)
        fprintf('not optimal')
        fprintf('\n--------Next iteration--------\n')
        disp('old BV=')
        disp(BV)

        ZC=ZRow(1:end-1);
        [EnterCol,Pvt_Col]=min(ZC);
        fprintf('Most -ve element in zrow is %d corresponding to column %d \n',EnterCol,Pvt_Col)
        fprintf('entering variable is %d \n',Pvt_Col)

        sol=A(:,end);
        Column=A(:,Pvt_Col);
        if all (Column<=0)
            error('Lpp has unbounded solution. All entries <=0 in column %d',Pvt_Col)
        else

        for i=1:size(Column,1)
            if Column(i)>0
                ratio(i)=sol(i)./Column(i);
            else
                ratio(i)=inf;
            end
        end

        [MinRatio, Pvt_Row]=min(ratio);
        fprintf('Minimum ratio corresponding to pivot row is %d \n',Pvt_Row)
        fprintf('Leaving variable is %d \n', BV(Pvt_Row))
        end
        BV(Pvt_Row)=Pvt_Col;
        disp('new BV =')
        disp(BV)

        Pvt_Key=A(Pvt_Row,Pvt_Col);

        A(Pvt_Row,:)=A(Pvt_Row,:)./Pvt_Key;
        for i=1:size(A,1)
            if i~=Pvt_Row
                A(i,:)=A(i,:)-A(i,Pvt_Col).*A(Pvt_Row,:);
            end
            ZRow=ZRow-ZRow(Pvt_Col).*A(Pvt_Row,:);
            ZjCj=[ZRow;A];
            SimpTable=array2table(ZjCj);
            SimpTable.Properties.VariableNames(1:size(ZjCj,2))={'x_1','x_2','x_3','s_1','s_2','s_3','Sol'}
            BFS=zeros(1,size(A,2));
            BFS(BV)=A(:,end);
            BFS(end)=sum(BFS.*Cost);
            CurrentBFS=array2table(BFS);
            CurrentBFS.Properties.VariableNames(1:size(CurrentBFS,2))={'x_1','x_2','x_3','s_1','s_2','s_3','Sol'}
        end
    else
        Run=false;
        fprintf('======********************============\n')
        fprintf('The current BFS is optimal and Optimality is reached \n')
        fprintf('======********************============\n')
    end
end 

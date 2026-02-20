% max z = 2x1 + 3x2 + 4x3 + 7x4
% 2x1 + 3x2 - x3 + 4x4 = 8
% x1 - 2x2 + 6x3 - 7x4 = -3
clc 
clear all
%phase 1
C=[2 3 0 0];
A=[-1 2 1 0; 1 1 0 1];
B=[4;5];

%phase 2
n=size(A,2);
m=size(A,1);

%phase 3
if (n>m)
    nCm=nchoosek(n,m);
    pair=nchoosek(1:n,m);

    %phase 4
    sol=[];
    for i=1:nCm
        y=zeros(n,1);
        x=A(:,pair(i,:))\B;

        %phase 5
        if all(x>=0 & x~=inf & x~=-inf)
            y(pair(i,:))=x;
            sol=[sol y];
        end
    end
else
    error('nCm does not exist');
end

%phase 6
Z=C*sol
[Zmax,Zindex]=max(Z)
bfs=sol(:,Zindex)

%phase 7
optimal_value=[bfs' Zmax]
optimal_bfs=array2table(optimal_value);
optimal_bfs.Properties.VariableNames(1:size(optimal_bfs,2))={'x1','x2','x3','x4','z'}

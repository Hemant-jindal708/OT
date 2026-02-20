clc
clear all
clear figure

c=[4 3 4 6 3];
A=[3 3 -1 4 2;
   2 -2 6 5 1];
b=[6;-3];
z=@(X)c*X;
m=size(A,1);
n=size(A,2);

basicsol=[];
bfsol=[];
degeneratesol=[];
nondegeneratesol=[];
ncm=nchoosek(n,m);
pairs=nchoosek(1:n,m);

for i=1:ncm
    y=zeros(n,1);
    basicvarindex=pairs(i,:);
    X=A(:,basicvarindex)\b;
    y(basicvarindex)=X;
    basicsol=[basicsol y];
    if all(X>=0)
        bfsol=[bfsol y];
        if any(X > 0)
            % non-degenerate BFS (as per modified condition)
            nondegeneratesol = [nondegeneratesol y];
        else
            % degenerate BFS
            degeneratesol = [degeneratesol y];
        end
    end
end

disp('Basic Solution Set:');
disp(basicsol);

disp('Basic Feasible Solution Set:');
disp(bfsol);

disp('Degenerate Basic Feasible Solutions:');
disp(degeneratesol);

disp('Non-Degenerate Basic Feasible Solutions:');
disp(nondegeneratesol);

cost=z(bfsol);
[optimalval,index]=max(cost);
optimalsol=bfsol(:,index);

disp('Optimal Solution:');
disp(optimalsol);

disp('Optimal Value:');
disp(optimalval);
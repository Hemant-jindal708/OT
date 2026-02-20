clc
clear all
%phase 1
A=[-1 3;1 1;1 -1]; 
B=[10;6;2];
C=[1 5];
%phase 2
y1=0:1:max(B);
x21=(B(1)-A(1,1).*y1)./A(1,2);
x22=(B(2)-A(2,1).*y1)./A(2,2);
x23=(B(3)-A(3,1).*y1)./A(3,2);
x21=max(0,x21);
x22=max(0,x22);
x23=max(0,x23);
hold on
plot(y1,x21)
plot(y1,x22)
plot(y1,x23)
legend("x+2y=2000","x+y=1500","y=600")
grid on;
hold off;
%phase 3
cx1=find(y1==0);
c1=find(x21==0);
line1=[y1(:,[c1 cx1]);x21(:,[c1 cx1])]';
c2=find(x22==0);
line2=[y1(:,[c2,cx1]);x21(:,[c2,cx1])]';
c3=find(x23==0);
line3=[y1(:,[c3,cx1]);x21(:,[c3,cx1])]';
corpt=unique([line1;line2;line3],'rows');
%phase 4
pt=[0;0];
for i=1:size(A,1)
    A1=A(i,:);
    B1=B(i,:);
    for j=i+1:size(A,1)
        A2=A(j,:);
        B2=B(j,:);
        A4=[A1;A2];
        B4=[B1;B2];
        X=A4\B4;
        pt=[pt X];
    end
end
ptt=pt';
%phase 5
allpt=[ptt;corpt];
points=unique(allpt,"rows");

%phase 6
x1=allpt(:,1);
x2=allpt(:,2);
cons1 = -x1+3.*x2-10;
h1=find(cons1>0);
allpt(h1,:)=[];

x1=allpt(:,1);
x2=allpt(:,2);
cons2 = x1+ x2-6;
h2=find(cons2>0);
allpt(h2,:)=[];

x1=allpt(:,1);
x2=allpt(:,2);
cons3 = x1- x2-2;
h3=find(cons3>0);
allpt(h3,:)=[];

point = allpt;

P=unique(point,"rows");

%phase7
for i=1:size(P,1)
    fn(i,:)=sum(P(i,:).*C);
end
ver_fns=[P fn];

%phase 8
[Optval optPosition]=max(fn);

optval=ver_fns(optPosition,:);

optimal_BFS = array2table(optval)
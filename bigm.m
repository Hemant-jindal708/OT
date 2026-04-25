clc
clear all
format rational
M=1000

c = [2 1 0 0 -M]
A = [4 3 -1 0 1; 1 2 0 1 0]
b = [6; 3]
m= size(A,1)
n = size(A,2)
X=zeros(n,1)
bv_index=[5 4]
Y = [A,b]

for s=1:inf
    count=s
    cb = c(bv_index)
    xb = Y(:,end)
    z=cb*xb
    zjcj=cb*Y(:,1:n)-c

    if zjcj>=0
        disp('Optimal solution')
        xb
        basic_variables=bv_index
        X(basic_variables)=xb'
        fprintf("optimal objective function value = %f", z)
        break
       
    else
        [a,EV]=min(zjcj)
        if Y(:,EV)<0
            disp("unbounded solution")
        else
            for j=1:m
                if Y(j,EV)>0
                    ratio(j)=xb(j)/Y(j,EV)
                else
                    ratio(j)= Inf
                end
            end
        end
        [k,LV]=min(ratio)
        bv_index(LV)=EV
        pivot=Y(LV,EV)
        Y(LV,:)=Y(LV,:)/pivot
        for i=1:m
            if i~=LV
                Y(i,:)=Y(i,:)-Y(LV,:)*Y(i,EV);
            end
        end
    end
end

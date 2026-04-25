clear all
clc
S=[5 8 7 14]
D=[7 9 18]
C=[2 7 4; 3 3 1; 5 5 4; 1 6 2]

if sum(S)==sum(D)
    fprintf("Problem is balanced")
else
    fprintf("Problem is unbalanced")
    if sum(S)<sum(D)
        C(end+1,:)=zeros(1,length(D))
        S(end+1)=sum(D)-sum(S)
    elseif sum(S)>sum(D)
        C(:,end+1)=zeros(length(S),1)
        D(end+1)=sum(S)-sum(D)
    end
end
AV=zeros(size(C))
IC=C
for i=1:size(C,1)*size(C,2)
    mc=min(C(:))
    [mc_r, mc_c]=find(mc==C)
    x=min(S(mc_r),D(mc_c))
    [alloc_val ind]=max(x)
    p=mc_r(ind)
    q=mc_c(ind)
    AV(p,q)=alloc_val
    S(p)=S(p)-alloc_val
    D(q)=D(q)-alloc_val
    if S(p)==0
        C(p,:)=inf
    end
    if D(q)==0
        C(:,q)=inf
    end
end
TC=sum(sum(IC.*AV))
fprintf("Total transportation cost is %f", TC)

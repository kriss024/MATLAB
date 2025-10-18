function [ out ] = mRMR( X,group,N)

[row,col]=size(X);
ii=[1:col]';
V_f=[];
for c = 1:col
    [F, p]=F_score(X(:,c),group);
    V_f=[V_f; F];
end
W_c=[];
for c = 1:col
    R=corr(X,X(:,c));
    W_c=[W_c; R];
end
score=V_f./W_c;
m=[ii,score];
sort=sortrows(m,-2);
ss=[];
for c = 1:N
    s=sort(c,1);
    ss=[ss; s];
end
out=ss;
end


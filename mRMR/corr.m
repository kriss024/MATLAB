function [ out ] = corr( matrix, X )

[row,col]=size(matrix);

R_tab=[];
for c = 1:col
    R=corrcoef(matrix(:,c),X);
    r=R(2,1);
    R_tab=[R_tab; abs(r)];
end

out=(1/(col^2))*sum(R_tab);
end


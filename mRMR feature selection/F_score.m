function [F, p_value ] = F_score( X,group )
l=length(X);
df_Total=l-1;
df_groups=length(unique(group))-1;
df_error=df_Total-df_groups;
avg=mean(X);
avg_grp=[];
len_grp=[];
uni_tab=unique(group);
uni_num=length(unique(group));
matrix=[X,group];

for i = 1:uni_num
    gr=uni_tab(i);
    mx=matrix(matrix(:,2)==gr,:);
    v=mx(:,1);
    avg_grp=[avg_grp;mean(v)];
    len_grp=[len_grp;length(v)];
end
a=avg-avg_grp;
b=a.^2;
c=len_grp.*b;
SS_groups=sum(c);
MS_groups=SS_groups/df_groups;
mxx=[];
for i = 1:uni_num
    gr=uni_tab(i);
    mx=matrix(matrix(:,2)==gr,:);
    v=mx(:,1);
    a=v-avg_grp(i);
    b=a.^2;
    mxx=[mxx;b];
end
SS_error=sum(mxx);
MS_error=SS_error/df_error;
F=MS_groups/MS_error;
v1=df_groups;
v2=df_error;
x=v2/(v2+v1*F);
p_value=betainc(x,v2/2,v1/2);
end


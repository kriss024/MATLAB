%Anova test between normalized  groups 
for f=1:32
anova1([    [GenS(:,f);GenS(:,f);GenS(:,f);GenS(:,f);] ,  ForS(:,1)   ])
end


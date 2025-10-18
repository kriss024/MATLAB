for i=1:32
f=zeros(1,32);f(i)=1;
[G,F]=scoresCalculation(DB,f,f);
EER=ac_eer(G(:),F(:));e(i)=EER.EER;
end;
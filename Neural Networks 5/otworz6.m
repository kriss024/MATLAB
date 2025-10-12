% otwiera 5 plików z prawidlowymi sygna³ami EKG, które s¹ testowane. Ka¿dy
% sygna³ sk³ada siê z 101 próbek. Jak równie¿ otwierane s¹ wektory T o
% wartoœci 1 Tu podobnie tylko u mnie tym razem maj¹ byæ tu otwarte sygna³y
% przedstawiajace œmiech. Pozozsta³e pliki o nazwie otworz bêda
% analogicznie 
P=[];
T=[];
P1=[];
T1=[];

for (i=1:5)
  xxx=int2str(i);
  nazwa=['d',xxx,'.txt'];
  P1=load(nazwa);
  P=[P P1(100:250,1)];
  P1=[];
  nazwa=['T',xxx,'.txt'];
  T1=load(nazwa);
  T=[T T1(1,:)];
  T1=[];
end

T
P

clear P1;



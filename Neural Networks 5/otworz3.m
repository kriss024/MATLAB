% Tu za bardzo nie wiem jak zrobiæ t¹ pêtlê to jest pêtla do otwarcie 39 plików które s¹ uczone. Ka¿dy plik sk³ada siê ze 101 próbek. Jak równie¿ otwierane s¹ wektory T - w ten sposób przyporz¹dkowuje siê czy dany sygna³ 
%poddany na wejœciu jest prawid³owy (1) czy nienieprawid³owy (0). Tu
%chodzi³o o analizê sygna³ów EKG, który sygna³ pochodzi od zdrowego 
%pacjenta a który nie. 
P=[];
T=[];
P1=[];
T1=[];

for (i=6:44)
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

%kiedy sygna³y zostaja za³adaowane uaktywniaj¹ siê pozosta³e okna
set([Menu2],'Enable','On');
set([Menu3],'Enable','On');
set([Menu4],'Enable','On');
set([Menu5],'Enable','On');


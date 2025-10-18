clear;
% wczytywanie danych
load('dane15.mat');
x=dane15(:,1);
y=dane15(:,2);

'Obliczanie wspó³czynników dla modeli liniowych'
% 1. Dla danych zawartych w pliku daneXX.txt1 zaproponuj liniowy model parametryczny 
% a nastêpnie okreœl parametry modelu stosuj¹c metodê najmniejszych kwadratów.
% model  y = a1*x + a2
%  a1 =     -0.1002
%  a2 =      0.2606

% przygtowanie macierzy A do metody MNK
n = length(x);
e = ones(n, 1);
A = [x e];
% obliczanie wspó³czyników
a = A\y;
a

% 2. Zaproponuj bardziej z³o¿ony, uogólniony model regresji liniowej, 
% a nastêpnie okreœl parametry modelu stosuj¹c pseudoinwersjê. 
% Porównaj obie metody oraz otrzymane wyniki.
%  y = a1*x^3 + a2*x^2 + a3*x + a4
%  a1 =    -0.0491
%  a2 =    -0.0257
%  a3 =     0.1905
%  a4 =     0.3454  

% przygtowanie macierzy A
n = length(x);
e = ones(n, 1);
A = [x.^3 x.^2 x e];
% obliczanie wspó³czyników wielomianu
a2=inv(A'*A)*A'*y;
a2

% Porównaj obie metody oraz otrzymane wyniki.
'Obliczanie wspó³czynników dopasowania R^2 dla ró¿nych modeli i sieci neuronowych'
p1=a(1,1);
p2=a(2,1);
y2=x.*p1+p2;
'Metoda Najmniejszych Kwadratów'
corr2(y,y2)^2 % obliczanie wspó³czynnika korelacji

p1=a2(1,1);
p2=a2(2,1);
p3=a2(3,1);
p4=a2(4,1);
y3=p1*x.^3+p2*x.^2+p3*x+p4;
'Wielomian 3-go stopnia'
corr2(y,y3)^2


% 3. Zaproponuj jednokierunkow¹ sieæ neuronow¹ do modelowania posiadanych danych. 
% Stosuj¹c metodê propagacji wstecznej b³êdu naucz sieæ w oparciu o posiadane dane. Wzorce ucz¹ce sieæ podaj stosuj¹c metodê wsadow¹. 
% Przynajmniej jedna warstwa sieci powinna posiadaæ nieliniow¹ funkcj¹ aktywacji. Skomentuj metodê i otrzymane wyniki.

inputs = x';
targets = y';

hiddenLayerSize = 30; % liczba neuronów w warstwie ukrytej 
net = fitnet(hiddenLayerSize);
net.layers{1}.transferFcn = 'tansig'; % wybór funkcji aktywacji
net.divideParam.trainRatio = 90/100;
net.divideParam.valRatio = 5/100;
net.divideParam.testRatio = 5/100;
% trening sieci neuronowej
[net,tr] = train(net,inputs,targets);
outputs = net(inputs);
view(net);

y4=outputs';
'Sieæ neurnowa - tangens hiperboliczny'
corr2(y,y4)^2

% 5. Zmieñ funkcjê aktywacji i przeprowadŸ naukê jak w punkcie 3.

inputs = x';
targets = y';

hiddenLayerSize = 30;
net = fitnet(hiddenLayerSize);
net.layers{1}.transferFcn = 'logsig'; 
net.divideParam.trainRatio = 90/100;
net.divideParam.valRatio = 5/100;
net.divideParam.testRatio = 5/100;

[net,tr] = train(net,inputs,targets);
outputs = net(inputs);
view(net);

y5=outputs';
'Sieæ neurnowa - funkcja logistyczna'
corr2(y,y5)^2

plot(x,y,'*',x,y2,'--',x,y3,'--',x,y4,':o',x,y5,':o');
legend('Oryginalne dane','Metoda Najmniejszych Kwadratów','Wielomian 3-go stopnia','Sieæ neurnowa - tangens hiperboliczny','Sieæ neurnowa - funkcja logistyczna',3);

% 4. Zmieniaj¹c metodê podawania wzorców z metody wsadowej na metodê ”on line” przeprowadŸ analogiczne obliczenia jak w punkcie 3. 
% Skomentuj metodê i otrzymane wyniki.
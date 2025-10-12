clear
% siec do predykcji wartosci funkcji jednej zmiennej fx = f(x) na
% podstawie pewnej liczby wczesniejszych jej wartosci   

x = 1:1200;
%fx = sin(0.005*x)+ 0.2*sin(0.01*x+1)+ 0.5*sin(0.03*x-1)+ ...
%   0.8*sin(0.04*x-3)+0.6*sin(0.2*x+2);
%fx = sin(0.01*x+5)+0.3*sin(0.1*x+1)+ 0.5*sin(0.3*x-1);
fx=sin(0.01 .*x +1) + 0.8* sin(0.03 .*x +1) + 0.5 * sin(0.1 .*x +10);


liczba_we = 10;
zakres_we = repmat([-5 5],liczba_we,1);
net = newff(zakres_we,[10 5 1],{'tansig','tansig','purelin'});
%net = newff(zakres_we,[10 1],{'tansig','purelin'});

net.trainParam.epochs = 150;
net.trainParam.goal = 1e-10;
% Preparujemy dane wejsciowe - bierzemy pewna liczbe probek oddalonych od
% siebie o dT pozycji i staramy sie przewidziec wartosc ostatniej na podstawie
% pozostalych np. dla 4 wejsc i dT=6 aproksymujemy funkcje
%   x(t+24) = f(x(t), x(t+6), x(t+12), x(t+18))
dT = 7;
NrPrz=1:500;
Len = length(NrPrz);
NrWe = 0:dT:(dT*(liczba_we-1));
Nr = NrPrz'*ones(1,liczba_we)+ones(Len,1)*NrWe;
NrWy = NrPrz+dT*liczba_we;

P = fx(Nr);                  % tworzymy tablice - obrazy w wierszach
K = fx(NrWy);  % wektor wartosci wyjsciowych

net = train(net,P',K);

Y = sim(net,P');

subplot(2,1,1);         % rysowanie wykresu funkcji i aproksymacji dla prz. uczacych
plot(NrWy,K,NrWy,Y);
title('Uczenie');
legend('wart. funkcji','wyjscie sieci');

NrPrzTest = 601:1100;
Len = length(NrPrzTest);
Nrtest = NrPrzTest'*ones(1,liczba_we)+ones(Len,1)*NrWe;
Ptest = fx(Nrtest);
NrWytest = NrPrzTest+dT*liczba_we;
Ktest = fx(NrWytest);

Y = sim(net,Ptest');

srbladtestu = mean(abs(Y-Ktest))

subplot(2,1,2);        % rysowanie wykresu funkcji i aproksymacji dla prz. testowych
plot(NrWytest,Ktest,NrWytest,Y);
title('Test');
legend('wart. funkcji','wyjscie sieci');

pause;
% przebieg odtwarzania funkcji:
NrWe = -dT*liczba_we:dT:-dT;
fxx = fx;
%fxx(NrPrzTest) = 0;
NrPrzTest=(1+dT*liczba_we):1100;
for i=NrPrzTest
   % odtworz wartosc funkcji na podstawie poprzednich wartosci
   Nrtest = i+NrWe;
   fxx(i) = sim(net,fxx(Nrtest)');
end

close;

plot(NrPrzTest,fx(NrPrzTest),NrPrzTest,fxx(NrPrzTest));
legend('funkcja','odtworzenie');
title('Odtwarzanie przebiegu czasowego');



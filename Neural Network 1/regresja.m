% Aproksymacja funkcji za pomoca sieci neuronowej
Puczenie = -1:0.05:1;      % punkty do uczenia
Ptest = -1:0.01:1;         % -||- do testu

Tuczenie = sin(3*pi*Puczenie).^(2).*sin(pi*Puczenie);  % wartosci punktow uczacych     
Ttest = sin(3*pi*Ptest).^(2).*sin(pi*Ptest);

net = newff([-1 1],[10 1],{'tansig' 'purelin'}, 'trainlm');   % tworzenie nowej sieci

net.trainParam.epochs = 500;              % liczba epok
net.trainParam.show = 100;                % co ile epok wyswietlac wykres
net.trainParam.goal=0.0000001;            % maksymalny blad aproksymacji

net = init(net);                          % inicjacja wag sieci
net = train(net,Puczenie,Tuczenie);       % uczenie sieci
Y = sim(net,Puczenie);                    % symulacja sieci dla punktow uczacych
sredni_blad_uczenia = mean(abs(Y-Tuczenie))

Y = sim(net,Ptest);                       % symulacja sieci dla punktow uczacych
sredni_blad_testu = mean(abs(Y-Ttest))

plot(Ptest, Ttest, 'r', Puczenie,Tuczenie,'gO', Ptest,Y, 'b');   % wykres
legend('funkcja zadana','przyklady uczace','funkcja aproks.');
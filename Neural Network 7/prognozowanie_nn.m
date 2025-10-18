function [ wynik ] = prognozowanie_nn( dane, liczba_n )

h1=floor(max(dane(:,1)/2));

t = dane(h1+1:end,2);
x = dane(1:h1,2);

X = num2cell(x');
T = num2cell(t');

delay = 1:2;
net = timedelaynet(delay, liczba_n);
[Xs,Xi,Ai,Ts] = preparets(net,X,T);
net.trainParam.epochs = 1000;
net.divideParam.trainRatio = .7; 
net.divideParam.valRatio   = .3; 
net.trainFcn = 'trainlm';
net.performFcn = 'mse';
net.trainParam.showWindow=0;
net = train(net,Xs,Ts,Xi,Ai,'useParallel','yes','useGPU','only');
Xp=T(delay);
Tp = T(max(delay)+1:end);
Y = net(Tp,Xp,Ai);
YP=cell2mat(Y);
wynik = YP(1:24)';

end


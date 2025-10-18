function [ wynik ] = prognozowanie_nn( dane, siec )

h1=floor(max(dane(:,1)/2));

mi=mean(dane(:,2));
ro=std(dane(:,2));
v_max = mi+3*ro;
v_min = mi-3*ro;

t = dane(h1+1:end,2);
x = dane(1:h1,2);

X = num2cell(x');
T = num2cell(t');

delay = 1:2;
warstwy = [siec.warstwa1 siec.warstwa2 siec.warstwa3];
net = timedelaynet(delay, warstwy);
[Xs,Xi,Ai,Ts] = preparets(net,X,T);
net.trainParam.epochs = 1000;
net.divideParam.trainRatio = .7; 
net.divideParam.valRatio   = .3; 
net.trainFcn = 'trainlm';
net.performFcn = 'mse';
net.layers{1}.transferFcn = siec.funkcja_aktywacji1;
net.layers{2}.transferFcn = siec.funkcja_aktywacji2;
net.layers{3}.transferFcn = siec.funkcja_aktywacji3;
net.trainParam.showWindow = 0;
net = train(net,Xs,Ts,Xi,Ai,'useParallel','yes','useGPU','yes');
Xp=T(delay);
Tp = T(max(delay)+1:end);
Y = net(Tp,Xp,Ai);
YP=cell2mat(Y);
l=length(YP);
for i = 1:l
    p = YP(i);
    p = min([p v_max]);
    p = max([p v_min 0]);
    YP(i) = p;
end

wynik = YP(1:24)';

end


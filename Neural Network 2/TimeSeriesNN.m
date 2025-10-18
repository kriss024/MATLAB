clear;
load('EURUSD_D1.mat');
uczacy=EURUSD_TS(1:3000,:);
testowy=EURUSD_TS(3001:end,:);

t=uczacy(:,1);
y=uczacy(:,2);

t_t=testowy(:,1);
y_t=testowy(:,2);

inputSeries = tonndata(t,false,false);
targetSeries = tonndata(y,false,false);

inputDelays = 1:2;
feedbackDelays = 1:2;
hiddenLayerSize = 30;
net = narxnet(inputDelays,feedbackDelays,hiddenLayerSize);

[inputs,inputStates,layerStates,targets] = preparets(net,inputSeries,{},targetSeries);

net.divideParam.trainRatio = .8;
net.divideParam.valRatio = .2;
net.divideParam.testRatio = 0;

[net,tr] = train(net,inputs,targets,inputStates,layerStates);

outputs = net(inputs,inputStates,layerStates);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);

view(net);

outputs = outputs';

outputs = cell2mat(outputs);

s=max(inputDelays)+1;
t=uczacy(s:end,1);
y=uczacy(s:end,2);

figure(1);
plot(t,y,t,outputs,'--');
title('Wykres dla danych ucz¹cych');
legend('Oryginalne dane Y','Przewidywane wartoœci Y');

errors=cell2mat(errors);

figure(2);
k=sqrt(length(errors));
hist(errors, k);
title('Rozk³ad b³êdów na zbiorze testowym');


netc = closeloop(net);
netc.name = [net.name ' - Closed Loop'];
view(netc);

inputSeries = tonndata(t_t,false,false);
targetSeries = tonndata(y_t,false,false);

[xc,xic,aic,tc] = preparets(netc,inputSeries,{},targetSeries);
yc = netc(xc,xic,aic);
perfc = perform(netc,tc,yc);

s=max(inputDelays)+1;
t_t=testowy(s:end,1);
y_t=testowy(s:end,2);

yc = yc';
yc = cell2mat(yc);

figure(3);
plot(t_t,y_t,t_t,yc,'r--');
title('Wykres dla danych testuj¹cych');
legend('Oryginalne dane Y','Przewidywane wartoœci Y');

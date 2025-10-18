clear;
load('EURUSD_D1.mat');
uczacy=EURUSD_NN(1:3000,:);
testowy=EURUSD_NN(3001:end,:);

zmienne=uczacy(:,1:9);
t=uczacy(:,1);
y=uczacy(:,10);

zmienne_t=testowy(:,1:9);
t_t=testowy(:,1);
y_t=testowy(:,10);

inputs = zmienne';
targets = y';

hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize);

net.divideParam.trainRatio = .8;
net.divideParam.valRatio = .2;
net.divideParam.testRatio = 0;

[net,tr] = train(net,inputs,targets);

outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);

view(net)

outputs = outputs';

figure(1);
plot(t,y,t,outputs,'--');
title('Wykres dla danych ucz¹cych');
legend('Oryginalne dane Y','Przewidywane wartoœci Y');

figure(2);
k=sqrt(length(errors));
hist(errors, k);
title('Rozk³ad b³êdów na zbiorze testowym');

inputs_t = zmienne_t';
outputs_t = net(inputs_t);
outputs_t = outputs_t';

figure(3);
plot(t_t,y_t,t_t,outputs_t,'r--');
title('Wykres dla danych testuj¹cych');
legend('Oryginalne dane Y','Przewidywane wartoœci Y');

function [Y,net,P,T,tr]=trainNN(G,F,neurons)

sG=size(G,1);
sF=size(F,1);
T=[0.8*ones(1,sG),-0.8*ones(1,sF)];

P=[G',F'];
%net=nets;

net = newff([min(G)' max(G)'],[neurons 1],{'tansig' 'purelin'},'trainlm');
%nets=net;
%Y = sim(net,P);
% plot(P,T,P,Y,'o')

net.trainParam.goal=0.020;
net.trainParam.epochs=200;
[net,tr] = train(net,P,T);
Y = sim(net,P);
% plot(P,T,P,Y,'o')

% 20, 0.09, cf

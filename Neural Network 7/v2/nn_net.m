clear all; clc;

t=0:0.1:4*pi;
n=length(t);
okres=n/2;

l=normrnd(0,1,1,n)/10;

y=sqrt(t/10)+sin(t)+l;

figure(1);
plot(t,y);
grid on;

a=1:okres;
x=[a, a; a*0+log(1), a*0+log(2)];

%----------------------------------

inputs = x;
targets = y;

% Create a Fitting Network
hiddenLayerSize = 20;
net = fitnet(hiddenLayerSize);

net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

[net,tr] = train(net,inputs,targets);

% Test the Network
i=[a; a*0+log(2)];
inputs = [x, i];
yp = net(inputs);

figure(2);
plot(yp);
grid on;
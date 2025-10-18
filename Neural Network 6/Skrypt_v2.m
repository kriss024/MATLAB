close all; clear all; clc;
cd('C:/Temp');

input = xlsread('INPUTS-2.xlsx');
output = xlsread('OUTPUTS-2.xlsx');

wej = input';
wyj = output';

hiddenLayerSize = 35;
net = feedforwardnet(hiddenLayerSize,'trainlm');
net = train(net,wej,wyj);

wynik = net(wej);
bledy = gsubtract(wyj,wynik);

figure(1); 
ploterrhist(bledy);
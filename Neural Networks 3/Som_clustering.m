clear;
load('wine.mat');

inputs = wineInputs;

% Create a Self-Organizing Map
dimension1 = 3;
dimension2 = 3;
net = selforgmap([dimension1 dimension2]);

% Train the Network
[net,tr] = train(net,inputs);

% Test the Network
outputs = net(inputs);

% View the Network
view(net);

figure;
plotsomhits(net,inputs);
input = [0 0; 0 1; 1 0; 1 1]';               % each column is an input vector
ouputActual = [0 1 1 0];                     % 

net = newpr(input, ouputActual, 3);          % 1 hidden layer with 3 neurons
net = init(net);                             % Initialize neural network
[net,tr] = train(net, input, ouputActual);   % Train
outputPredicted = sim(net, input);           % Predict

[c,cm] = confusion(ouputActual,outputPredicted);
cm
fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);

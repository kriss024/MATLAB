clear;
load('wine.mat');

inputs = wineInputs;
targets = wineTargets;

% settings of "i" parameter
start=1;
step=1;
to=35;

performance=[];
row=1;
for i=start:step:to
    
    % Create a Pattern Recognition Network
    
    units=2; %number of hidden units
    lr=0.01; %learning rate for the network
    epochs= i; %number of epochs
    
    net = newff(inputs, targets, units);
    net.layers{1}.transferFcn = 'tansig';
    net.layers{2}.transferFcn = 'purelin';

    % Setup Division of Data for Training, Validation, Testing
    net.divideParam.trainRatio = 1; % use all inputs for training
    net.divideParam.valRatio = 0; % and none for validation
    net.divideParam.testRatio = 0; % or testing
    net.trainParam.lr=lr;
    net.trainParam.epochs = epochs;
    net.trainParam.showWindow=0;
    
    % Train the Network
    [net,errors] = train(net, inputs, targets);

    % Simulate dynamic system
    outputs = sim(net,inputs);
    outputs = round(outputs);
    
    tl=size(outputs,2);
    pos=0;
    for n = 1:tl
      ab=abs(targets(:,n)-outputs(:,n));
      se=sum(ab);
      if (se==0)
        pos=pos+1;
      end
    end
    error=1-pos/tl;
    fprintf('The value of error is %i.\n',error);
    
    performance(row,:)=[i error];
    row=row+1;
    

end

x=performance(:,1);
y=performance(:,2);
figure;
plot(x,y);
grid on;
xlabel('parameter value')
ylabel('misclassification rate')

% View the Network
view(net);



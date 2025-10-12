net=network; %tworzenie sieci 
net.numInputs=1;
net.inputs{1}.size=length(P(:,1));

net.numLayers = 3; %liczba warstw sieci - 3 
net.layers{1}.size=35; %w pierwszej warstwie jest 35 neuronów
net.layers{2}.size=18; %w drugiej warstwie jest 18 neuronów
net.layers{3}.size=1; %w trzeciej warstwie jest 1 neuron 

net.inputConnect(1)=1;
net.layerConnect(2,1)=1;
net.layerConnect(3,2)=1;
net.outputConnect(3)=1;
%net.targetConnect(3)=1;

net.layers{1}.transferFcn='tansig'; %funkcja aktywacji w pierwszej warstwie - funkcja tangensoidalna 
net.layers{2}.transferFcn='tansig'; %funkcja aktywacji w drugiej warstwie - funkcja tangensoidalna 
net.layers{3}.transferFcn='purelin'; %funkcja aktywacji w trzeciej warstwie - funkcja liniowa
net.biasConnect=[1;1;0];

net.layers{1}.initFcn='initnw'; %funkcja inicjalizacji w pierwszej warstwie 
net.layers{2}.initFcn='initnw'; %funkcja inicjalizacji w drugiej warstwie 
net.layers{3}.initFcn='initnw' %funkcja inicjalizacji w trzeciej warstwie 


%wejœciowe wagi sieci 
net.inputWeights{1,1}.initFcn='rands'; 
net.biases{1}.initFcn='rands';
net.biases{2}.initFcn='rands';
net.biases{3}.initFcn='rands';

net.layerWeights{2,1}.initFcn='rands';
net.layerWeights{2,2}.initFcn='rands';

net=init(net); %tworzenie sieci neuronowej 

net.performFcn='mse'; %funkcja oceny b³êdów odwzorowania sieci - b³¹d œredniokwadratowy
net.trainFcn='trainlm'; %metoda uczenia - propagacja wsteczna Levenberg-Marquardta

net.trainParam.lr=0.1; %wspó³czynnik uczenia sieci
net.trainParam.goal=0.01; %akceptowalny b³¹d
net.trainParam.mc=0.9; 

net.trainParam.epochs=1000; %liczba iteracji w czasie uczenia
net.trainParam.show=100; %liczba kroków algorytmu uczenia, po którym wyœwietlany jest komunikat



[net,tr]=train(net,P,T); %uczenie sieæ
plotperform(tr) %wykres uczenia 
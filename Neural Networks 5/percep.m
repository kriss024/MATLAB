net=newp(minmax(P),100)
T=[]
%utworzenie sieci perceptronowej 

net = init(net);
Y = sim(net,P)


elem11=inputdlg('Maksymalna ilosc epok');
net.trainParam.epochs=str2num(elem11{1,1});
disp(net.IW)

[net, tr]=train(net,P,T) 

Y = sim(net,P)

net=adapt(net,P,T);

net=init(net); %inicjalizacja sieci 
%net=train(net,P,T)


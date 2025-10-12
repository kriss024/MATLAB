net=newlin(P,S);
T=[]


elem11=inputdlg('Maksymalna ilosc epok');
net.trainParam.epochs=str2num(elem11{1,1});
disp(net.IW)


elem11=inputdlg('Dopuszczalny blad iteracji');
net.trainParam.goal=str2num(elem11{1,1});


S=100 
lr=0.01


%utworzenie sieci liniowej, gdzie Pr-macierz, S - liczba neurnów na
%wyjœciu, Ir - wspó³czynnik uczenia sieci, ld-wejœciowy wektor opóŸnieñ 
%uczenia

[net, tr]=train(net,P,T) 

Y = sim(net,P)

net=adapt(net,P,T);

net=init(net); %inicjalizacja sieci 





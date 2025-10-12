P = [0 1 2 3 4 5 6 7 8 9 10];
T = [0 1 2 3 4 3 2 1 2 3 4];
P2 = 0:.01:10;

net = feedforwardnet(4);
net.trainParam.showWindow = false;
net.trainParam.epochs = 50;
net = train(net,P,T);
Y = sim(net,P2);

plot(P2,Y,P,T,'o');


net.IW{1}

net.b{1}
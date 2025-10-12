clear all; clc;

t_org = 0:199;

l=normrnd(0,1,1,200)/10;

x_org=sqrt(t_org/100)+sin(t_org/5/pi)+l;

%E =[144.63 126.15 122.45 124.05 124.05 123.05 124.05 144.63 144.63 144.63 145.60 146.96 148.03 147.36 146.96 145.60 145.60 144.63 140.01 116.75 140.31 140.01 129.10 126.45 85.00 74.50 72.20 72.20 72.20 100.00 115.00 77.30 85.00 125.00 110.89 125.00 125.00 125.00 100.00 85.00 85.00 77.80 80.89 113.89 127.20 128.20 127.10 115.00];

t=x_org(101:end);
x=x_org(1:100);
P1 = [x,t];

figure(1);
plot(P1);
grid on;

X = num2cell(x);
T = num2cell(t);

delay = 1:2;
net = timedelaynet(delay, 15);
[Xs,Xi,Ai,Ts] = preparets(net,X,T);
net.divideParam.trainRatio = .72;
net.divideParam.valRatio   = .28; 
net = train(net,Xs,Ts,Xi,Ai, 'useParallel','yes','useGPU','only');
view(net);
Xp=T(delay);
Tp = T(max(delay)+1:end);
Y = net(Tp,Xp,Ai);
YP=cell2mat(Y);
P2=[P1,YP];

figure(2);
plot(P2);
grid on;








clear all; clc;

t_org = 0:199;

l=normrnd(0,1,1,200)/10;

x_org=sqrt(t_org/5/pi)+sin(t_org/5/pi);


t=t_org;
x=x_org;

figure(1);
plot(t,x);
grid on;

y = num2cell(x);
d = 2; % input delay 8
s = 100; % predict next values in series
Pi = y(1:d);
p = y(d+1:end-s); % inputs
t = y(d+s+1:end); % targets
ftdnn_net = timedelaynet([1:d],20);
ftdnn_net.trainParam.epochs = 1000;
ftdnn_net.divideFcn = '';
ftdnn_net = train(ftdnn_net,p,t,Pi);
Pi = y(s+1:s+d);
yp = ftdnn_net(t,Pi);
Y = cell2mat(yp);
all=[x, Y];

figure(2);
plot(all);
grid on;


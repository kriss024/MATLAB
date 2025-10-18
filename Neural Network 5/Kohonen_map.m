clear;
 
r1 = normrnd(0,1,[1 500])';
r2 = normrnd(0,1,[1 500])';
 
s1=[r1+4 r2+4];
s2=[r2+8 r1+8];

dat=[s1;s2];

x=dat(:,1);
y=dat(:,2);
figure(1);
scatter(x,y);


inputs = dat';

% Create a Self-Organizing Map
dimension1 = 10;
dimension2 = 10;
net = selforgmap([dimension1 dimension2]);

% Train the Network
[net,tr] = train(net,inputs);

figure(2);
plotsomnd(net);

figure(3);
plotsomhits(net,inputs);

figure(4);
plotsompos(net,inputs);
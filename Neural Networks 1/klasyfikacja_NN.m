clear;
load('fisheriris.mat');

x1 = meas(:,3);   
x2 = meas(:,4);
wejscie=[x1,x2]';

klasy=[];

for i=1:length(species)
   if strcmp(species(i,1),'setosa') klasy=[klasy;[1 0 0]]; end
   if strcmp(species(i,1),'versicolor') klasy=[klasy;[0 1 0]]; end
   if strcmp(species(i,1),'virginica') klasy=[klasy;[0 0 1]]; end
end

klasy=klasy';
figure(1);
gscatter(x1, x2, species);
xlabel('sepal width');
ylabel('sepal length');
title('orginalny zbiór danych');

hiddenLayerSize = 30;
net = patternnet(hiddenLayerSize);
net.trainParam.epochs = 100;
net.layers{1}.transferFcn = 'logsig';
net.layers{2}.transferFcn = 'tansig';
view(net);
[net,tr] = train(net,wejscie,klasy);
figure(2);
plotperform(tr);
wyjscie = net(wejscie);

x1_ls = linspace(min(x1),max(x1),60);
x2_ls = linspace(min(x2),max(x2),60);

[x,y] = meshgrid(x1_ls,x2_ls);

for i=1:length(x)
    for j=1:length(x)
        wejscie=[x(i,j);y(i,j)];
        wyjscie = net(wejscie);
        R(i,j)=uint8(wyjscie(1,:).*255);
        G(i,j)=uint8(wyjscie(2,:).*255);
        B(i,j)=uint8(wyjscie(3,:).*255);
    end
end

Map(:,:,1)=R;
Map(:,:,2)=G;
Map(:,:,3)=B;
figure(3);
imshow(Map);
xlabel('sepal width');
ylabel('sepal length');
title('obszar klasyfikacja na podstawie sieci neurnowej');

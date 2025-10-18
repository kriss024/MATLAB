clear;
load('fisheriris.mat');

x1 = meas(:,3);   
x2 = meas(:,4);
wejscie=[x1,x2];

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


[class,type]=dbscan(wejscie,5,[]);

class=class';
figure(2);
gscatter(x1, x2, class);
xlabel('sepal width');
ylabel('sepal length');
title('zbiór po klasteryzacji dbscan');

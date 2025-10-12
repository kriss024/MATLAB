clear; 
cd('C:/Temp/drtoolbox');
addpath(genpath('C:\Temp\drtoolbox'))
disp(pwd);
 
filename = 'iris.data';

fileID = fopen(filename);
c = textscan(fileID,'%n %n %n %n %s','Delimiter',',');
fclose(fileID);

a=c(1:4);
a2=c(5);
k=a2{1,1};
ds=cell2mat(a);

% ------- No dimension reduction ------- 

x=ds(:,1);
y=ds(:,2);
subplot(2,3,1);
gscatter(x,y,k);
grid on;
title('No dimension reduction');
xlabel('Dimension 1');
ylabel('Dimension 2');

% ------- PCA method ------- 

d=2;
Y=compute_mapping(ds,'PCA',d);
x=Y(:,1);
y=Y(:,2);

subplot(2,3,2);
gscatter(x,y,k);
grid on;
title('PCA method');
xlabel('Dimension 1');
ylabel('Dimension 2');

% ------- KernelPCA method ------- 

d=2;
Y=compute_mapping(ds,'KernelPCA',d);
x=Y(:,1);
y=Y(:,2);

subplot(2,3,3);
gscatter(x,y,k);
grid on;
title('KernelPCA method');
xlabel('Dimension 1');
ylabel('Dimension 2');

% -------  GDA method ------- 

d=2;
Y=compute_mapping(ds,'GDA',d);
x=Y(:,1);
y=Y(:,2);

subplot(2,3,4);
gscatter(x,y,k);
grid on;
title('GDA method');
xlabel('Dimension 1');
ylabel('Dimension 2');

% -------  LDA method ------- 

d=2;
Y=compute_mapping(ds,'LDA',d);
x=Y(:,1);
y=Y(:,2);

subplot(2,3,5);
gscatter(x,y,k);
grid on;
title('LDA method');
xlabel('Dimension 1');
ylabel('Dimension 2');

% ------- LLTSA method ------- 

d=2;
Y=compute_mapping(ds,'LLTSA',d);
x=Y(:,1);
y=Y(:,2);

subplot(2,3,6);
gscatter(x,y,k);
grid on;
title('LLTSA method');
xlabel('Dimension 1');
ylabel('Dimension 2');



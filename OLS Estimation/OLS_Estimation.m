% Drop all varibales
clear all; clc;
cd('C:\Temp');

% Loading the data to matlab
[data,countries] = xlsread('AssignmentData.xlsx','A2:D190');
le = data(:,1);
pci = data(:,3);
lpci = log10(pci);

% Createing scatter plot
figure(1);
scatter(lpci, le);
title('The relationship between per capita income and life expectancy');
xlabel('Log10(Per capita income)');
ylabel('Life expectancy');

% OLS parameter estimates
Y = le;
n = length(lpci);
X = ones(n,1);
X(:,2)=lpci;
B = inv(X'*X)*X'*Y;
B = B';
'Coefficients b0 b1'
disp(B);

% Regression line
b0 = B(1,1);
b1 = B(1,2);
p = [b1 b0];
y_le = polyval(p,lpci);


% SST SSE S R^2
le_mean = mean(le);
et2 = (le - le_mean).^2;
SST = sum(et2);
'SST'
disp(SST);
e2 = (le - y_le).^2;
SSE = sum(e2);
'SSE'
disp(SSE);
S = sqrt(SSE/(n-2));
R2=1-SSE/SST;
'R^2'
disp(R2);

'S'
disp(S);

% Std. Error and p-value
lpci_mean = mean(lpci);
lpcir2 = (lpci - lpci_mean).^2;
lpcir2sum = sum(lpcir2);

Sb0 = S*sqrt(1/n+lpci_mean^2/lpcir2sum);
Sb1 = S/sqrt(lpcir2sum);

'Std. Error b0 b1'
disp([Sb0 Sb1]);

't value b0 b1'
t0 = b0/Sb0;
t1 = b1/Sb1;
disp([t0 t1]);

'p-value b0 b1'
pval0=2*(1-tcdf(abs(t0),n-2));
pval1=2*(1-tcdf(abs(t1),n-2));
disp([pval0 pval1]);

figure(2);
scatter(lpci, le);
hold on;
plot(lpci, y_le,'r');
title('The relationship between per capita income and life expectancy');
xlabel('Log10(Per capita income)');
ylabel('Life expectancy');
legend('Empirical data','Regression line');
hold off;


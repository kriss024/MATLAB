clear; clc;

[dane, tekst] = xlsread('Kursy_walut_NBP_Tab_C_2017.xlsx');
data_num = dane(:,1);
data_tekst = datestr(data_num+datenum('30-Dec-1899'));

save('Kursy_walut_NBP.mat','dane','tekst','data_tekst');
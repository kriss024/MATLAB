%Przygotowanie_danych;

clear; close all; clc;

load('Kursy_walut_NBP.mat');

kursy_walut = dane(:,2:14);
nr_tabeli = dane(:,15);
nazwy_walut = tekst(1,2:14);

disp('Pocz¹tek notowañ kursów');
data_tekst(1,:)

disp('Koniec notowañ kursów');
data_tekst(251,:)

disp('Statystyki walut');
w =  max(size(nazwy_walut));
wal_s = {};
for x = 1:w
    wal = {};
    k = kursy_walut(:,x);
    wal(1,1)  = nazwy_walut(1,x);
    wal(2,1) = cellstr('Minimalna wartoœæ');
    wal(2,2) = num2cell(min(k));
    wal(3,1) = cellstr('Maksymalna wartoœæ');
    wal(3,2) = num2cell(max(k));
    wal(4,1) = cellstr('Œrednia wartoœæ');
    wal(4,2) = num2cell(mean(k));
    wal(5,1) = cellstr('Mediana');
    wal(5,2) = num2cell(median(k));
    wal(6,1) = cellstr('Wariancja');
    wal(6,2) = num2cell(var(k));
    wal(7,1) = cellstr('Odchylenie standardowe');
    wal(7,2) = num2cell(std(k));
    wal_s = [wal_s; wal];
end
disp(wal_s);

disp('Analiza korelacji (korelacje ca³kowite)');
[R,PValue] = corrplot(kursy_walut, 'type', 'Pearson', 'testR','on');
% print('analiza korelacji','-dpng');

disp('Istotne korelacje');
alpha = 0.05;
w =  max(size(R));
wal = {};
i = 1;
for y = 1:w
  for x = 1:w
    a = PValue(y,x);
    if any(alpha > a)
        wal1 = nazwy_walut(1,x);
        wal2 = nazwy_walut(1,y);
        sep = cellstr(' x ');
        wal(i,1) = strcat(wal1, sep, wal2);
        wal(i,2) = num2cell(R(y,x));
        i = i + 1;
    end
  end
end
disp(wal);

disp('Korelacje w oknie czasowym');

poczatek = 1;
koniec = 100;

kursy_walut_2 = kursy_walut(poczatek:koniec,:);

disp('Pocz¹tek notowañ kursów w oknie czasowym');
data_tekst(poczatek,:)

disp('Koniec notowañ kursów w oknie czasowym');
data_tekst(koniec,:)

[R,PValue] = corrcoef(kursy_walut_2);
% print('analiza korelacji','-dpng');

disp('Istotne korelacje w oknie czasowym');
alpha = 0.05;
w =  max(size(R));
wal = {};
i = 1;
for y = 1:w
  for x = 1:w
    a = PValue(y,x);
    if any(alpha > a)
        wal1 = nazwy_walut(1,x);
        wal2 = nazwy_walut(1,y);
        sep = cellstr(' x ');
        wal(i,1) = strcat(wal1, sep, wal2);
        wal(i,2) = num2cell(R(y,x));
        i = i + 1;
        vx = kursy_walut_2(:,x);
        vy = kursy_walut_2(:,y);
        figure(i);
        plot(vx,vy,'*r');
        title('Korelacje w oknie czasowym');
        ylabel(char(wal1));
        xlabel(char(wal2)); 
        nazwa = strcat(wal1, '_', wal2);
        print(char(nazwa),'-dpng');
    end
  end
end
disp(wal);

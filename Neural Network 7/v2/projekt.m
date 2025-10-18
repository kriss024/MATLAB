close all, clear all, clc;
cd('C:\Work\Projekt');

load('dane.mat');

zares_lat = [2010:2015];
uczenie = dane_do_prognozy(zares_lat, dane);

prognoza_roczna=[];

rok = 2016
max_dni = 3;
kolumna_danych = 5;

% ustawienie liczby neuronów w kolejnych warstwach
f1 = 'warstwa1';  w1 = 15;
f2 = 'warstwa2';  w2 = 10;
f3 = 'warstwa3';  w3 = 5;

% ustawienie funkcji aktywacji dla neuronów w poszczególnych warstwach
f4 = 'funkcja_aktywacji1';  fa1 = 'purelin'; % tansig, logsig
f5 = 'funkcja_aktywacji2';  fa2 = 'purelin'; % tansig, logsig
f6 = 'funkcja_aktywacji3';  fa3 = 'purelin'; % tansig, logsig

siec = struct(f1,w1,f2,w2,f3,w3,f4,fa1,f5,fa2,f6,fa3);

liczba_dni_w_mies = [31 28 31 30 31 30 31 31 30 31 30 31];

for mies = 1:length(liczba_dni_w_mies)
    
    for dzien = 1:liczba_dni_w_mies(mies)
        uczenie_dni = dni_do_prognozy(mies, dzien, uczenie);
        dni3 = max_prognoza(max_dni, uczenie_dni);
        szereg = dodaj_czas_id(kolumna_danych, dni3);
        prognoza_dzien = prognozowanie_nn(szereg, siec);
        dzien1 = prognoza_data(rok, mies, dzien, prognoza_dzien);
        prognoza_roczna = [prognoza_roczna; dzien1];
        sprintf('Miesi¹c %d, dzieñ %d.',mies, dzien)
    end

end

wykres = prognoza_roczna(:,kolumna_danych);
figure;
plot(wykres);
grid on;



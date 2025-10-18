close all, clear all, clc;
cd('C:\Projekt');

load('dane.mat');

zares_lat = [2010:2015];
uczenie = dane_do_prognozy(zares_lat, dane);

prognoza_roczna=[];

rok = 2016
max_dni = 3;
kolumna_danych = 5;
liczba_neuronow = 15;

mies = 1;
for dzien = 1:31
    uczenie_dni = dni_do_prognozy(mies, dzien, uczenie);
    dni3 = max_prognoza(max_dni, uczenie_dni);
    szereg = dodaj_czas_id(kolumna_danych, dni3);
    prognoza_dzien = prognozowanie_nn(szereg, liczba_neuronow);
    dzien1 = prognoza_data(rok, mies, dzien, prognoza_dzien);
    prognoza_roczna = [prognoza_roczna; dzien1];
    disp('*** styczeñ ***');
end

mies = 2;
for dzien = 1:28
    uczenie_dni = dni_do_prognozy(mies, dzien, uczenie);
    dni3 = max_prognoza(max_dni, uczenie_dni);
    szereg = dodaj_czas_id(kolumna_danych, dni3);
    prognoza_dzien = prognozowanie_nn(szereg, liczba_neuronow);
    dzien1 = prognoza_data(rok, mies, dzien, prognoza_dzien);
    prognoza_roczna = [prognoza_roczna; dzien1];
    disp('*** luty ***');
end


mies = 3;
for dzien = 1:31
    uczenie_dni = dni_do_prognozy(mies, dzien, uczenie);
    dni3 = max_prognoza(max_dni, uczenie_dni);
    szereg = dodaj_czas_id(kolumna_danych, dni3);
    prognoza_dzien = prognozowanie_nn(szereg, liczba_neuronow);
    dzien1 = prognoza_data(rok, mies, dzien, prognoza_dzien);
    prognoza_roczna = [prognoza_roczna; dzien1];
    disp('*** marzec ***');
end

mies = 3;
for dzien = 1:30
    uczenie_dni = dni_do_prognozy(mies, dzien, uczenie);
    dni3 = max_prognoza(max_dni, uczenie_dni);
    szereg = dodaj_czas_id(kolumna_danych, dni3);
    prognoza_dzien = prognozowanie_nn(szereg, liczba_neuronow);
    dzien1 = prognoza_data(rok, mies, dzien, prognoza_dzien);
    prognoza_roczna = [prognoza_roczna; dzien1];
    disp('*** kwiecieñ ***');
end


wykres = prognoza_roczna(:,kolumna_danych);
figure;
plot(wykres);
grid on;

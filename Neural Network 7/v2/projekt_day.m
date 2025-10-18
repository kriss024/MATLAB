clear all; clc;
cd('C:\Projekt');

load('dane.mat');

zares_lat = [2009:2014];

uczenie = dane_do_prognozy(zares_lat, dane);

mies = 12;
dzien = 24;

uczenie_dni = dni_do_prognozy(mies, dzien, uczenie);

max_dni = 3;

dni3 = max_prognoza(max_dni, uczenie_dni);

kolumna_danych = 5;

szereg = dodaj_czas_id(kolumna_danych, dni3);

liczba_neuronow = 15;

prognoza_dzien = prognozowanie_nn(szereg, liczba_neuronow);

rok = 2016;

dzien1 = prognoza_data(rok, mies, dzien, prognoza_dzien);

pp = [szereg(:,2)' , prognoza_dzien'];

plot(pp);
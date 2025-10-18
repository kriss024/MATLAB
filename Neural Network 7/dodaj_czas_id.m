function [ wynik ] = dodaj_czas_id(kol_dane, dane )
    n = size(dane,1);
    i = 1:n;
    j = i';
    w = dane(:,kol_dane);
    wynik = [j, w];
end


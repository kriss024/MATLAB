function [ wynik ] = dni_do_prognozy(miesiac, dzien, dane)

    w = dane(dane(:,2)==miesiac & dane(:,3)==dzien,:);
    wynik = sortrows(w,[1 2 3 4]);
end


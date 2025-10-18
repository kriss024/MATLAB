function [ wynik ] = prognoza_data(rok, miesiac, dzien, szereg )
    n=size(szereg,1);
    i=1:n;
    h=i';
    r = ones(n, 1) * rok;
    m = ones(n, 1) * miesiac;
    d = ones(n, 1) * dzien;
    wynik = [r, m, d, h, szereg];
end


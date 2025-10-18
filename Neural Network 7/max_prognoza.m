function [ wynik ] = max_prognoza(dni, dane)
    n = size(dane,1);
    n2 = size(dane,2);
    n3 = n2 + 1;
    i = 1:n;
    i = fliplr(i);
    j = i';
    w = [dane, j];
    d = dni * 24;
    z = w(w(:,n3)<=d,:);
    wynik = sortrows(z,[1 2 3 4]);
end


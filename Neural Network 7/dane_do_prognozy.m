function [ wynik ] = dane_do_prognozy(lista, dane )
n = size(lista,2);

w = [];
for i = 1:n
    j = lista(i);
    z = dane(dane(:,1)==j,:);
    w = [w; z];
end
wynik = sortrows(w,[1 2 3 4]);
end


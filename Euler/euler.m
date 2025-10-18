function [t,x]=euler(f,tinit,xinit,tfinal,n)
% EULER - metoda Eulera dla ODE
% nazwa pliku euler.m
% krok czasowy:
h=(tfinal-tinit)/n;
% warunek pocz¹tkowy - przygotowanie wektorów t oraz x:
t=[tinit zeros(1,n)]; x=[xinit zeros(1,n)];
% obliczenie x(t) w postaci wektorów t i x:
for i=1:n
    t(i+1)=t(i)+h;
    x(i+1)=x(i)+h*f(x(i));
end

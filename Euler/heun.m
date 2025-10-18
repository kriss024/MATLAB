function [t,x]=heun(f,tinit,xinit,tfinal,n)
% HEUN - metoda Heuna dla ODE
% nazwa pliku heun.m
% krok czasowy:
h=(tfinal-tinit)/n;
% warunek pocz¹tkowy - przygotowanie wektorów t oraz x:
t=[tinit zeros(1,n)]; x=[xinit zeros(1,n)];
% obliczenie x(t) w postaci wektorów t i x:
for i=1:n
    t(i+1)=t(i)+h;
    k=x(i)+h*f(t(i),x(i));
    x(i+1)=x(i)+(h/2)*(f(t(i),x(i))+f(t(i+1),k));
end

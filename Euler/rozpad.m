clc; clear;
% Rozwiazanie analityczne 
ta=0:0.1:3; xa=exp(-ta); 
% Rozwiazanie numeryczne 
% Prawa strona równania f = -x: 
f=inline('-x'); 
% Metoda Eulera dla kroku 0.15: 
[t1, x1]=euler(f,0,1,3,20);
% Metoda Eulera dla kroku 0.3: 
[t2, x2]=euler(f,0,1,3,10);
% Metoda Eulera dla kroku 0.6: 
[t3, x3]=euler(f,0,1,3,5);
% Wykres: 
plot(ta,xa,'r-', t1,x1,'b-',t2,x2,'g-',t3,x3,'y-') 
xlabel('t') 
ylabel('x') 
legend('Exact','Euler 0.15','Euler 0.3','Euler 0.6') 
title('Rozpad promieniotwórczy') 
axis([0 3 0 1]) 
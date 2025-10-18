function dgdt = pochodna_wektor_wrazliwosci(t, theta)
% Okresl parametry nominalne
K  = theta(1);
r  = theta(2);
x0 = theta(3);
% Wyznacz pochodną wektora wrażliwości względem czasu
t1 = r * t;
t2 = exp(-t1);
t3 = K - x0;
t4 = t3 * t2;
t5 = x0 + t4;
t6 = -x0 + t4;
t5 = 0.1e1 / t5;
t7 = t5^2;
t5 = t5 * t7;
dgdt = [-x0^2 * r * t2 * (x0 * (-t2 + 0.1e1) + K * (-0.2e1 + t2)) * t5;
         K * t3 * x0 * t2 * (t1 * t6 + t4 + x0) * t5;
         K^2 * r * t2 * t6 * t5];

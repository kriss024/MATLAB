function g = wektor_wrazliwosci(t, theta)
% Okresl parametry
K  = theta(1);
r  = theta(2);
x0 = theta(3);
% Wyznacz wektor pochodnych x(t) względem kolejnych parametrów
t1 = exp(-r * t);
t2 = K - x0;
t3 = t1 * t2 + x0;
t3 = 0.1e1 / t3 ^ 2;
g = [-x0^2 * (-0.1e1 + t1) * t3;
      K * t2 * x0 * t * t1 * t3;
      K^2 * t1 * t3];

function [x, J] = model(theta, czasy);
K  = theta(1);
r  = theta(2);
x0 = theta(3);
t5 = exp(-r * czasy);
% wyznaczenie wyjscia modelu
x = K ./ (0.1e1 + (K / x0 - 1) * t5);
if nargout > 1 
   % wyznaczenie jakobianu po parametrach 
   N = length(czasy);
   J = zeros(N, 3);
   for i = 1: N
      J(i, :) = wektor_wrazliwosci(czasy(i), theta)'; 
   end    
end
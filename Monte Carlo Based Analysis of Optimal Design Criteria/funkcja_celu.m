function [minus_det_M, gradient] = funkcja_celu(chwile_czasowe)
theta = parametry_nominalne();
M = zeros(3);
gradient = zeros(size(chwile_czasowe));
for t = chwile_czasowe
   g = wektor_wrazliwosci(t, theta);   
   M = M + g * g';
end    
minus_det_M = -det(M);
for i = 1: length(chwile_czasowe)
   t = chwile_czasowe(i);
   g = wektor_wrazliwosci(t, theta);
   dgdt = pochodna_wektor_wrazliwosci(t, theta);
   gradient(i) = 2 * minus_det_M * g' * inv(M) * dgdt;
end

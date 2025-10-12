clear; clc;

% y = -4*x^3+3*x^2-2*x+1
y = [-4 3 -2 1];

% Find the roots of this polynomial
r = roots(y)

% Find the polynomial from the roots
p = poly(r)

% Multiply Polynomials
a = [1 2 1];
b = [2 -2];
c = conv(a,b) 

% a = 2x^3 + 2x^2 - 2x - 2
% b = 2x - 2
a = [2 2 -2 -2];
b = [2 -2]; 

% now divide b into a finding the quotient and remainder
[q, r] = deconv(a,b)

% Fitting Data to a Polynomial
x = linspace(0, pi);

% make a cosine function with 10% random error on it
f = cos(x) + 0.1 * rand(1, length(x)); 

% fit to the data
p = polyfit(x, f, 4); 

% evaluate the fit
g = polyval(p,x); 

% plot data and fit together
figure(1);
plot(x, f,'r:', x, g,'b-');
legend('noisy data', 'fit');
grid on;
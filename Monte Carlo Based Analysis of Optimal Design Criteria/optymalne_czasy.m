N = 10;
T = 25;
sigma = sqrt(0.01);
liczba_replikacji = 1000;
theta_min = 0.9 * [17.5, 0.7, 0.1];
theta_max = 1.1 * [17.5, 0.7, 0.1];
liczba_restartow = 30;
t_min = repmat(0, 1, N);
t_max = repmat(T, 1, N);
czasy_startowe = linspace(0, T, N);
options = optimset('GradObj','on');
[czasy, minus_det_M] = fmincon(@funkcja_celu, czasy_startowe, ...
                       [],[],[],[],t_min,t_max, [], options)
                   
theta_nom = parametry_nominalne();                   
ydata = model(theta_nom, czasy); % 'idealny' zestaw danych, bez bledu
kol = []; % kolektor wynikow
options = optimset('Algorithm', 'trust-region-reflective', 'Jacobian', 'on', 'Display', 'off');
for i = 1: liczba_replikacji    
    if rem(i, 10) == 0
        disp(['Replikacja ', num2str(i)])
    end        
    e = sigma * randn(1,N); % blad symulujacy obiekt rzeczywisty
    ydata = ydata + e; % zaszumianie idealnych probek   
    blad_opt = 1e30;
    for k = 1: liczba_restartow
       theta_start = theta_min + (theta_max - theta_min) .* rand(1, 3);
       [theta, blad] = lsqcurvefit(@model, theta_start, czasy, ydata, [], [], options);  % obliczanie wspolczynnikow 
       if blad < blad_opt
           blad_opt = blad;
           theta_opt = theta;
       end    
    end   
    % wykorzystujac metode Levenberga-Marquardta
    kol = [kol; theta_opt];
end

L = round(sqrt(liczba_replikacji));
hist(kol(:, 1), L)
xlabel('wspolczynnik K')
ylabel('czestosc')
figure
hist(kol(:, 2), L)
xlabel('wspolczynnik r')
ylabel('czestosc')
figure
hist(kol(:, 3), L)
xlabel('wspolczynnik x0')
ylabel('czestosc')
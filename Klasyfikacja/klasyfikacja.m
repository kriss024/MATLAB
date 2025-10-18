x1 = [1,3,1,2,3,5,7,3,2,5];
x2 = [5,5,3,3,1,3,1,3,1,5];
klasy = [1,1,1,1,0,0,0,0,1,1];

% % inny zbior przykladow:
% x1 =    [1 2 8 1 2 8 9 2 3 8 4 4 2 3 5 3 4 6 7 8 9 4 5 6 4 5 6 0 1 0 1 7 1 2 9 0 1 7 8 8];
% x2 =    [0 0 0 1 1 1 1 2 2 2 6 7 8 8 8 9 9 9 9 9 9 0 0 0 1 1 2 3 3 4 4 4 5 5 5 6 6 6 7 8];
% klasy = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

liczba_pkt = length(klasy)

ind1 = find(klasy==0);
ind2 = find(klasy==1);
plot(x1(ind1),x2(ind1),'bo',x1(ind2),x2(ind2),'rs')
text(x1+0.2,x2, int2str([1:liczba_pkt]'));
legend('obrazy klasy 0','obrazy klasy 1');
title('nacisnij klawisz ...');
axis([-1 10 -1 13]);
pause

%net = newff([-1 7;-1 7],[1],{'logsig'}, 'trainlm');
net = newff([-1 10;-1 10],[10 1],{'tansig' 'logsig'}, 'trainlm');
%net = newff([-1 7;-1 7],[20 20 1],{'tansig' 'logsig' 'logsig'}, 'trainlm');

net.trainParam.epochs = 500;
net.trainParam.show = 100;
net.trainParam.goal=0.0000001;

% TUTAJ NALEZY WYBRAC ALGORYTM UCZENIA:
%net.trainFcn = 'trainlm';     % algorytm Levenberga-Marquanda szybki, ale pamieciochlonny
%net.trainFcn = 'traingd';    % zwykla propagacja wsteczna, wolna ale czasami skuteczniejsza
%net.trainFcn = 'traingdm';   % propagacja wsteczna z momentem
  %net.trainParam.mc = 0.9      % wartosc momentu
%net.trainFcn = 'traingdx';   % propagacja wsteczna z mozliwoscia wczesniejszego zatrzymania i
                              % koniecznoscia wydzielenia zbioru walidacyjnego ze zbioru przykladow
                              % do uczenia - patrz <early.m>  
%net.trainFcn = 'traincgf';   % Fletchar-Powell conjugate gradient
%net.trainFcn = 'trainbfg';   % quasi-Newton
%net.trainFcn = 'traincgp';   % Polak-Ribiere conjugate gradient

net = init(net);
net = train(net,[x1;x2],klasy);
wyjscie = sim(net,[x1;x2]);
y = wyjscie > 0.5;
liczba_bledow = sum(y~=klasy)

[X,Y]=meshgrid(-1:0.1:10);
Z=X;
Z(:) = sim(net,[X(:) Y(:)]');

contour(X,Y,Z,[0.499 0.5 0.501]);
hold on
ind1 = find(klasy==0);
ind2 = find(klasy==1);
plot(x1(ind1),x2(ind1),'bo',x1(ind2),x2(ind2),'rs')
text(x1+0.2,x2, int2str([1:liczba_pkt]'));
legend('obrazy klasy 0','obrazy klasy 1');
title('Klasyfikacja punktow 2D - granica decyzji')
hold off
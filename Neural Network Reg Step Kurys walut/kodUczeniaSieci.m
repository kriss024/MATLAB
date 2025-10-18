clear;
clc;

load('Dane.mat');
Target=Matrix(:,2);
Instrumenty=Matrix(:,2:46);
Wskazniki=Matrix(:,47:end);

Headers_Ins=Headers(:,2:46);
Headers_Wsk=Headers(:,47:end);
Headers_Delay=[];
Delay=[];
%Data_M=Matrix(:,1);
%Data_Str=datestr(Data_M);

col=size(Headers_Ins,2);
for j=1:col
   zm=Instrumenty(:,col);
   o1=dodajOpoznienie(zm,1);
   o2=dodajOpoznienie(zm,2);
   o3=dodajOpoznienie(zm,3);
   h1=strcat(Headers_Ins(1,j),' T-1');
   h2=strcat(Headers_Ins(1,j),' T-2');
   h3=strcat(Headers_Ins(1,j),' T-3');
   Headers_Delay=[Headers_Delay,h1,h2,h3];
   Delay=[Delay,o1,o2,o3];
end

Dependent=[Delay,Wskazniki];
Headers_New=[Headers_Delay,Headers_Wsk];

'Zmienne przed selekcj¹'
disp(Headers_New);

stepwise(Dependent,Target);

[b,se,pval,inmodel,stats,nextstep,history]=stepwisefit(Dependent,Target);

Dependent_Step=[];
Headers_Step=[];
col=size(inmodel,2);
for j=1:col
    if inmodel(1,j)==1
        Dependent_Step=[Dependent_Step,Dependent(:,j)];
        Headers_Step=[Headers_Step,Headers_New(:,j)];
    end
end

'Zmienne istotne po selekcji'
disp(Headers_Step);

Uczace=Dependent_Step(1:700,:);
Testowe=Dependent_Step(701:end,:);

Target_u=Target(1:700,:);
Target_t=Target(701:end,:);

inputs = Uczace';
targets = Target_u';

hiddenLayerSize = 30;
net = fitnet(hiddenLayerSize);

net.divideParam.trainRatio = .75;
net.divideParam.valRatio = .25;
net.divideparam.testratio = 0;

[net,tr] = train(net,inputs,targets);

outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);

view(net);
plotperform(tr);
ploterrhist(errors);

t=1:length(Target_u);
figure(1);
plot(t,Target_u,t,outputs,'--');
title('Wykres dla danych ucz¹cych');
legend('Oryginalne dane EURUSD','Przewidywane wartoœci EURUSD');

inputs_t = Testowe';
outputs_t = net(inputs_t);
outputs_t = outputs_t';

figure(2);
errors=outputs_t-Target_t;
k=sqrt(length(errors));
hist(errors, k);
title('Rozk³ad b³êdów na zbiorze testowym');

t_t=1:length(Target_t);
figure(3);
plot(t_t,Target_t,t_t,outputs_t,'r--');
title('Wykres dla danych testuj¹cych');
legend('Oryginalne dane EURUSD','Przewidywane wartoœci EURUSD');

tab=[Target_t,outputs_t,errors];
%'Oryginalne dane EURUSD, przewidywane wartoœci oraz ró¿nica'
%disp(tab);
xlswrite('Prognoza.xls',tab);

clear all;
clc;
cd('C:\Temp');

Database = xlsread('dane.xlsx','Arkusz1');

Dependent = Database(:, 1:13);
Target = Database(:, 14);

max_row = size(Dependent, 1);
rng(1587);
p_split = rand(max_row,1);

Dependent_training = [];
Target_training = [];

Dependent_test = [];
Target_test = [];

for i = 1:max_row
    d = Dependent(i, :);
    t = Target(i, :);
    if p_split(i)<0.5
        Dependent_training = [Dependent_training; d];
        Target_training = [Target_training; t];
    else
        Dependent_test = [Dependent_test; d];
        Target_test = [Target_test; t];
    end

end

%-------------------------

figure(1);
plot(Target_test);
grid on;
title('Target variable for dataset test');
xlabel('Number of obserwation');
ylabel('Target value');

%-------------------------

max_s = size(Dependent_training,2);

for i = 1:max_s
   v = Dependent_training(:, i);
   c = corr(v,Target_training);
   corr_coeff(i) = c;
   r_squ(i) = power(c, 2);
end

figure(2);
subplot(1,2,1);
barh(corr_coeff);
title('Pearson''s Correlation Coefficient for dataset train');
ylabel('Number of variable');
axis([-1,1,0,max_s+1]);

subplot(1,2,2);
bar(r_squ);
title('R-Squared values');
xlabel('Number of variable');


%-------------------------

% Stepwise Regression
% The step-by-step iterative construction of a regression model that involves automatic 
% selection of independent variables. Stepwise regression can be achieved either by trying out 
% one independent variable at a time and including it in the regression model if it is statistically 
% significant, or by including all potential independent variables in the model and eliminating 
% those that are not statistically significant, or by a combination of both methods.

'Variable before selection'
Headers = 1:max_s;
disp(Headers);

[b,se,pval,inmodel,stats,nextstep,history]=stepwisefit(Dependent_training,Target_training);

Dependent_Step=[];
Dependent_test_s=[];
Headers_Step=[];
col=size(inmodel,2);
for j=1:col
    if inmodel(1,j)==1
        Dependent_Step=[Dependent_Step,Dependent_training(:,j)];
        Dependent_test_s = [Dependent_test_s, Dependent_test(:,j)];
        Headers_Step=[Headers_Step,Headers(:,j)];
    end
end

'Variable after selection'
disp(Headers_Step);

%-------------------------

% http://homepage.cs.latrobe.edu.au/dwang/html/DNNEweb/index.html#download

ensemble_models = 6;
hidden_neurons = 10;
lambda = 0.05;

dnne = newdnne(ensemble_models, hidden_neurons, Dependent_Step, Target_training, lambda);

[dnne, err] = traindnne(dnne, Dependent_Step, Target_training);

Pred = simdnne(dnne, Dependent_test_s);

n = size(Dependent_test_s, 1);
ls = linspace(1,n,n)';

figure(3);
plot(ls,Target_test,'g',ls,Pred,'b');
grid on;
title('Orginal and predicted values for dataset test');
xlabel('Number of obserwation');
legend('Orginal', 'Predicted');


'Root Mean Squared Error (RMSE) for dataset test'
disp(rmse(Target_test,Pred));

'Correlation beetwene orginal and predicted values for dataset test'
disp(corr(Target_test,Pred));

figure(4);
plot(Pred,Target_test,'b*');
grid on;
title('Orginal and predicted values for dataset test');
xlabel('Predicted values');
ylabel('Orginal values');
axis([0.5,max(Pred),0.5,max(Target_test)]);
%-------------------------

Diff = Pred - Target_test;

figure(5);
subplot(1,2,1);
ystart = (ls*0)';
yend = Diff';
hold on;
for idx = 1 : numel(ystart)
    plot([idx idx], [ystart(idx) yend(idx)]);
end
grid on;
title('Difference beetwene predicted and orginal values');
axis([0,max(ls),min(Diff),max(Diff)]);

subplot(1,2,2);
hist(Diff);
title('Distributionn of error');

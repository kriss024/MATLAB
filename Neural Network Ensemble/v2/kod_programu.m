clear all;
clc;
cd('C:\Temp');

Database = xlsread('dane.xlsx','Arkusz1');

Dependent = Database(:, 1:13);
Target = Database(:, 14);

%-------------------------

figure(1);
plot(Target);
grid on;
title('Target variable');
xlabel('Number of obserwation');
ylabel('Target value');

%-------------------------

max_s = size(Dependent,2);

for i = 1:max_s
   v = Dependent(:, i);
   c = corr(v,Target);
   corr_coeff(i) = c;
   r_squ(i) = power(c, 2);
end

figure(2);
subplot(1,2,1);
barh(corr_coeff);
title('Pearson''s Correlation Coefficient');
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

[b,se,pval,inmodel,stats,nextstep,history]=stepwisefit(Dependent,Target);

Dependent_Step=[];
Headers_Step=[];
col=size(inmodel,2);
for j=1:col
    if inmodel(1,j)==1
        Dependent_Step=[Dependent_Step,Dependent(:,j)];
        Headers_Step=[Headers_Step,Headers(:,j)];
    end
end

'Variable after selection'
disp(Headers_Step);
n = size(Dependent_Step, 1);

%------ cross validation and optimal netork size --------

ensemble_models_b=1;
ensemble_models_e=30;

hidden_neurons_b = 1;
hidden_neurons_e = 50;

lambda_b=0.1;
lambda_e=0.9;

n_cross_valid = 30;
n_cross_size = 2*n;

config=[];

q=1;
for j=ensemble_models_b:ensemble_models_e,
     for i=hidden_neurons_b:hidden_neurons_e,
              for k=lambda_b:0.1:lambda_e,
               c=[q j i k 0.0 0.0];
               config=[config; c];
               q=q+1;
             end 
     end
end

q=size(config,1);

for j=1:q;
    
ensemble_models = config(j,2);
hidden_neurons = config(j,3);
lambda = config(j,4);

r_corr_arr=[];
rmse_arr=[];

for iter=1:n_cross_valid;
    
    r_size=size(Dependent_Step,1);

    if r_size >= n_cross_size
        rv=randperm(n_cross_size)';
    else
        rv=randi([1 r_size],n_cross_size,1);
    end

    Dependent_tmp=Dependent_Step(rv,:);
    Target_tmp=Target(rv,:);
    k_size=size(Dependent_tmp,1);
    
    v1=[];
    v2=[];
    
    for k=1:k_size
        if mod(k, 2)==1
           v1=[v1; k];
        else
           v2=[v2; k]; 
        end
    end 
    
    Dependent_a1=Dependent_tmp(v1,:);
    Dependent_a2=Dependent_tmp(v2,:);
    Target_a1=Target_tmp(v1,:);
    Target_a2=Target_tmp(v2,:);
    
    dnne = newdnne(ensemble_models, hidden_neurons, Dependent_a1, Target_a1, lambda);

    [dnne, rmse] = traindnne(dnne, Dependent_a1, Target_a1);

    Pred = simdnne(dnne, Dependent_a2);
    Targ = Target_a2;
    r_corr=corr(Targ, Pred);
    rmse=sqrt(mean((Targ-Pred).^2));
    r_corr_arr(iter)=r_corr;
    rmse_arr(iter)=rmse;
end
     
config(j,5) = mean(r_corr_arr);   
    
config(j,6) = mean(rmse_arr);   

end

best = sortrows(config,6);

ensemble_models = best(1,2);
hidden_neurons = best(1,3);
lambda = best(1,4);

'Optimal netork size'
disp(ensemble_models);
disp(hidden_neurons);
disp(lambda);

error=sortrows(config,-6);
figure(3);
semilogy(error(:,6));
grid on;
title('Root-mean-square error');
xlabel('Number of models');
ylabel('Error (log scale)');

%-------------------------

% http://homepage.cs.latrobe.edu.au/dwang/html/DNNEweb/index.html#download

dnne = newdnne(ensemble_models, hidden_neurons, Dependent_Step, Target, lambda);

[dnne, rmse] = traindnne(dnne, Dependent_Step, Target);

Pred = simdnne(dnne, Dependent_Step);

ls = linspace(1,n,n)';

figure(4);
plot(ls,Target,'g',ls,Pred,'b');
grid on;
title('Orginal and predicted values');
xlabel('Number of obserwation');
legend('Orginal', 'Predicted');

'Correlation beetwene orginal and predicted values'
disp(corr(Target,Pred));

%-------------------------

Diff = Pred - Target;

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

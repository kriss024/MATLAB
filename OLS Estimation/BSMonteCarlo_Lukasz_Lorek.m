clear all; clc;
cd('C:\Temp');

S0 = 198;
K = 195;
T = 1;
r = 0.0829;
sigma = 0.2;

[C,P] = BSAnalytical_Lukasz_Lorek(S0 , K, r, T, sigma);

'C, P'
disp([C,P]);
disp(K+C);
disp(K-P);
'To buyer of the option has reached the threshold of profitability the current share price must increase by'
disp((K+C)-S0);
'For option profitability threshold is reached the current share price fall by'
disp(S0-(K-P));


N=365;
M=1000000;
h=1/365;
t=linspace(0,T,N);

x=zeros(M,N);
x(:,1)=S0*ones(M,1);
for i=2:N
  x(:,i)=x(:,i-1) + r*x(:,i-1)*h + sigma*sqrt(h)*x(:,i-1).*normrnd (0,1,M,1);
end

call_MC=exp(-r*T)*mean( max(x(:,N)-K,0) )
put_MC=exp(-r*T)*mean( max(K-x(:,N),0) )

[call,put]=BSAnalytical_Lukasz_Lorek(S0,K,r,T,sigma)

error_rel_call=abs(call_MC-call)/call_MC*100
error_rel_put=abs(put_MC-put)/put_MC*100

figure(1)
subplot(2,1,1);
plot(t,x(1:100,:),'r-');
title('Monte-Carlo simulation of the underlying instrument');
grid on;

c(1)=0;
p(1)=0;
for i=2:N
 [c_, p_]=BSAnalytical_Lukasz_Lorek(S0,K,r,t(i),sigma);
 c(i) = c_;
 p(i) = p_;
end

subplot(2,1,2);
plot(t,c,'b-',t,p,'g-');
title('Call/put option in time');
grid on;

function [C, P] = BSAnalytical_Lukasz_Lorek(S,K,r,T,sigma)
  d1 = (log(S./K)+(r+sigma^2/2)*T)/(sigma*sqrt(T));
  d2 = d1-sigma*sqrt(T);
  C = S.*normcdf(d1)-K*exp(-r*T)*normcdf(d2);
  P = K*exp(-r*T)*normcdf(-d2)-S.*normcdf(-d1);
end


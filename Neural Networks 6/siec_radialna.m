clear all
% nntwarn off

P=-1:.1:1;
Y=-1:.1:1;

T = zeros(length(P),length(Y));
PP = [];
YY = [];
TT = [];
for i = 1:length(P),
	for j = 1:length(Y),
		PP = [PP P(i)];
		YY = [YY Y(j)];
		T(i,j)= sin (pi * P(i) * Y(j));
		TT = [TT T(i,j)];
	end
end;

df = 10;   % frequency of progress displays (in neurons).
me = 1000; % maximum number of neurons.
eg = 0.02; % sum-squared error goal.
sc = .3;    % spread constant radial basis functions.

P_ = [PP; YY];

[w1,b1,w2,b2,nr,err] = solverb(P_,TT,[df me eg sc]);

% a = simurb(P_,w1,b1,w2,b2);
a_=zeros(size(T));
for i=1:length(P),
    for j=1:length(Y),
        a_(i,j)=simurb([P(i) Y(j)]',w1,b1,w2,b2);
    end
end
figure(2)
subplot(1,2,1), mesh(T);
subplot(1,2,2), mesh(a_);
nr
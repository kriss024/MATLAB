% x + y + z =5
% 2*x + 2*y + z = 3
% 3*x + 2*y + z =1

A=[1 1 1; 2 2 1; 3 2 1];

B= [5;3;1];

A_inv=inv(A);

X=A_inv*B;

disp('Rozwi¹zanie uk³adu równañ liniowych, kolejno wartoœci dla x, y, z');

disp(X);

disp('---------------');

GaussianEliminate(A,B);
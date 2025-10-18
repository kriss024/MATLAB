function [x] = GaussianEliminate(A,b) 
% Solves Ax = b by Gaussian elimination 
%work out the number of equations 
N = length(b); 
%Gaussian elimination 
for column=1:(N-1) 
 %swap rows so that the row we are using to eliminate 
 %the entries in the rows below is larger than the 
 %values to be eliminated. 
 [dummy,index] = max(abs(A(column:end,column))); 
 index=index+column-1; 
 temp = A(column,:); 
 A(column,:) = A(index,:); 
 A(index,:) = temp; 
 temp = b(column) 
 b(column)= b(index); 
 b(index) = temp; 
 %work on all the rows below the diagonal element 
 for row =(column+1):N 
 %work out the value of d 
 d = A(row,column)/A(column,column); 
 %do the row operation (result displayed on screen) 
 A(row,column:end) = A(row,column:end)-d*A(column,column:end) ; 
 b(row) = b(row)-d*b(column); 
 end%loop through rows 
end %loop through columns 
%back substitution 
for row=N:-1:1 
x(row) = b(row); 
 for i=(row+1):N 
 x(row) = x(row)-A(row,i)*x(i); 
 end 
x(row) = x(row)/A(row,row); 
end 
x = x' 
return
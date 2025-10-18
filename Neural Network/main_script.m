load('matlab.mat');
load('Users.mat');

USER_NUMBER=50;
% get rows for women
dbWomen=[];
for n = 1:USER_NUMBER
    if U(n,2)==0
        dbWomen=[dbWomen; DB(n,1:end)];
    end
end
% get rows for male
dbMale=[];
for n = 1:USER_NUMBER
    if U(n,2)==1
        dbMale=[dbMale; DB(n,1:end)];
    end
end
% get rows for age=0
dbAgeZero=[];
for n = 1:USER_NUMBER
    if U(n,4)==0
        dbAgeZero=[dbAgeZero; DB(n,1:end)];
    end
end
% get rows for age=1
dbAgeOne=[];
for n = 1:USER_NUMBER
    if U(n,4)==1
        dbAgeOne=[dbAgeOne; DB(n,1:end)];
    end
end
% get rows for age=2
dbAgeTwo=[];
for n = 1:USER_NUMBER
    if U(n,4)==2
        dbAgeTwo=[dbAgeTwo; DB(n,1:end)];
    end
end
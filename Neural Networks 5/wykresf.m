clc
figure('color',[1 1 1]); %tworzy nowe okno graficzne
%S=P([1:255],1,1);

P=[];
P1=[];
for(i=1:1:1);
    [naz,sciezka]=uigetfile('*.txt','Otworz plik danych'); %s³u¿y do wyszukiwania plików 
    P1=load(strcat(sciezka,naz));
    P=[P P1(1:150,1)];
end
clear P1;
plot(P,'-g','LineWidth',1);
%plot(S,'-g','LineWidth',1);
title('PRZEBIEG SYGNA£U');
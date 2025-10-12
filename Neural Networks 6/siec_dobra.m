%czyszczenie ekranu
clear all

%macierz wynikowa
wyniki=zeros(3000,3);

%zmienna potrzebna do inkrementacji w petli w celu zapisu wynikow
liczba=0;

%wczytanie pliku z danymi wina
load wine.txt

%wczytanie macierzy wektorów wyjsciowych
T=wine(:, 1)';

%wczytanie macierzy wektorów wejsciowych
disp('/*****************************   Dane przed normalizacja:   *****************************/')
P=wine(:, 2:14)'

%wykonanie normalizacji danych wejœciowych
ymax = 1;
ymin = -1;
pmax = max(P');
pmin = min(P');
Pn = zeros(size(P));
for i=1:length(pmax)
    Pn(i,:) = (ymax-ymin)/(pmax(i)-pmin(i))*(P(i,:)-pmin(i))+ymin;
end
disp('/*****************************   Dane po normalizacji:   *****************************/')
Pn

%sta³a rozrzutu RBF
sc = [0.01:0.1:10];	

%liczba neuronów
mn = [10:10:200];

%b³¹d œredniokwadratowy (b³¹d / liczba zbadanych win)
mse = 0.25 / 187;


%proces uczenia
for mn_iterator=1:length(mn)
    for sc_iterator=1:length(sc)
        
        %inkrementacja zmiennej potrzebnej do zapisu wynikow
        liczba=liczba+1;
        
        %nowa sieæ
        net = newrb(Pn, T, mse, sc(sc_iterator), mn(mn_iterator));
        
        %wyjœcie sieci
        A=sim(net,Pn);
        
        %zapis wyników sc i mn
        wyniki(liczba,1)=sc(sc_iterator);
        wyniki(liczba,2)=mn(mn_iterator);
        
        %zapis wskaznika poprawnosci
        wyniki(liczba,3)=(1-sum(abs(T-A)>0.5)/length(T))*100; 
        
    end;
end;

disp('koniec')


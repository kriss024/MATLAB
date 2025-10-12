clc
close all
global CalyEkran Fig Tytul
global szereg P T P1 S lr Pr
main=get(0,'ScreenSize')
CalyEkran=[0.003 0.073 0.994 0.83];
% figure('position', main) %widok na ca³y ekran 
Tytul='Sztuczne Sieci Neuronowe';
Fig=figure('Name',Tytul, 'NumberTitle','Off',  'MenuBar','None', 'Color','green', ...
   'Units','Normalized','Position',CalyEkran,'Resize','Off');
random=2;
Menu1=uimenu('Label','&Plik');
   Pod1Menu1=uimenu(Menu1,'Label','&Otworz','CallBack','otworz3;'); %otwiera wszystkie sygna³y, które maj¹ byæ uczone 
   Pod2Menu1=uimenu(Menu1,'Label','&Zapisz','CallBack','zapisz;');  % mo¿na zapisaæ skrypt 
   Pod3Menu1=uimenu(Menu1,'Label','&Zamknij','CallBack','zamknij'); %zamuyka program 
 Menu2=uimenu('Label','&Utworz siec','Enable','off');
 Pod1Menu2=uimenu(Menu2,'Label','&Liniowa','CallBack','liniowa;'); % tworzenie sieci liniowej
   Pod2Menu2=uimenu(Menu2,'Label','&Perceptron','CallBack','percep;'); % tworzenie perceptronu
   Pod3Menu2=uimenu(Menu2,'Label','&Wielowarstwowa','CallBack','wielo2;'); % tworzenie sieci wielowarstwowej I ze wsteczn¹ propagacj¹ b³êdów (z dwoma funkcjami aktywacji tangensoidalnymi 
   %i jedn¹ liniow¹ i liczb¹ iteracji 1000)
 Menu3=uimenu('Label','&Pokaz','Enable','off');
  Pod1Menu3=uimenu(Menu3,'Label','&Wspolczynnik wagowy','CallBack','wagowy;'); %pokazuje wspó³czyynik wagowy 
  Pod2Menu3=uimenu(Menu3,'Label','&Wspolczynnik progowy','CallBack','progowy;'); %pokazuje wspó³czyynik progowy
 Menu4=uimenu('Label','&Test','Enable','off');
  Pod1Menu4=uimenu(Menu4,'Label','&Œmiech','CallBack','otworz6;'); %otwiera sygnaly przedstawiajace smiech,które s¹ testowane 
  Pod2Menu4=uimenu(Menu4,'Label','&Chrz¹kanie','CallBack','otworz7;'); %otwiera sygnaly przedstawiajace chrzakanie, które s¹ testowane 
  Pod3Menu4=uimenu(Menu4,'Label','&Kaszel','CallBack','otworz8;'); %otwiera sygnaly przedstawiajace kaszel, które s¹ testowane 
  Pod4Menu4=uimenu(Menu4,'Label','&Krzyk','CallBack','otworz9;'); %otwiera sygnaly przedstawiajace chrzakanie, które s¹ testowane 
 Menu5=uimenu('Label','&Siec','Enable','off'); 
 Pod1Menu5=uimenu(Menu5,'Label','&Przebieg sygnalu ','CallBack','wykres;');  %rysuje wykres ca³ego przebiegu 
 Pod2Menu5=uimenu(Menu5,'Label','&Fragment sygnalu ','CallBack','wykresf;'); %ryssuje wykres fragmentu - 150 pierwszych wartoœci 
  
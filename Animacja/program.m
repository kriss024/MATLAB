clear;
obraz=imread('garden.jpg');

wysokosc=size(obraz,1);
szerokosc=size(obraz,2);
polowa=round(szerokosc/2);

nowy_szer=szerokosc*2;

matrix = ones([wysokosc nowy_szer],'uint8');  % Or, a = zeros(size(I),class(I));
white(:,:,1) = matrix*255;
white(:,:,2) = matrix*255;
white(:,:,3) = matrix*255;

CWLG=imcrop(obraz,[0 0 polowa polowa]);
CWPG=imcrop(obraz,[polowa+1 0 szerokosc polowa]);
CWLD=imcrop(obraz,[0 polowa+1 polowa wysokosc]);
CWPD=imcrop(obraz,[polowa+1 polowa+1 szerokosc wysokosc]);
i=0;
while(i<polowa)
obraz3=white;
i = i + 1;
lewo=i*(-1);
prawo=i;
obraz3(1:polowa,(1:polowa)+polowa+lewo,:)=CWLG;
obraz3(1:polowa,(1:polowa)+szerokosc,:)=CWPG;
obraz3((1:polowa)+polowa,(1:polowa)+polowa,:)=CWLD;
obraz3((1:polowa)+polowa,(1:polowa)+szerokosc+prawo,:)=CWPD;
imshow(obraz3);
pause(0.01);
end
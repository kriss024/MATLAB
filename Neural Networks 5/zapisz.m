pp={'*.m;*.mat','MATLAB Files (*.m,*.mat)';
'*.m', 'M-files (*.m)'; ...
'*.mat','MAT-files (*.mat)'};

[nazwa_pliku, sciezka, nr] = uiputfile(pp,'Zapisz');
imwrite(im,nazwa_pliku); 
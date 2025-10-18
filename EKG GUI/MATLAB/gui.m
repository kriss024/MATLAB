function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 09-Nov-2017 18:01:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%PRZYCISK WCZYTAJ PRZEBIEG EKG
function pushbutton1_Callback(hObject, eventdata, handles)
    startingFolder = 'C:\Users\Agnieszka\Desktop\MATLAB';
if ~exist(startingFolder, 'dir')
	% If that folder doesn't exist, just start in the current folder.
	startingFolder = pwd;
end
%Get the name of the mat file that the user wants to use.
defaultFileName = fullfile(startingFolder, '*.mat');
[baseFileName, folder] = uigetfile(defaultFileName, 'Wybierz plik w formacie mat');
if baseFileName == 0
	% User clicked the Cancel button.
	return;
end
fullFileName = fullfile(folder, baseFileName)
storedStructure = load(fullFileName);

%PRZYCISK "WYCZYŒÆ"
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1,'reset');
cla(handles.axes2,'reset');
set(handles.edit1,'string',num2str(0));
set(handles.edit2,'string',num2str(0));
set(handles.pushbutton1,'string',num2str(0));
set(handles.pushbutton3,'string',num2str(0));

%PRZYCISK "DOKONAJ OBLICZEÑ"
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ECG_original=(val-1024)/200;
Fs=500;
t=(0:length(ECG_original)-1)/Fs;
[m,n]=size(ECG_original);

%Usuniêcie trendu z sygna³u EKG
ECG_dt=detrend(ECG_original);

%Usuniêcie wartoœci œredniej z sygna³u EKG
M=mean(ECG_dt);
ECG_mn=ECG_dt-M;

%Usuniêcie wp³ywu sieci 50Hz z sygna³u EKG
d = designfilt('bandstopiir','FilterOrder',4, 'HalfPowerFrequency1',49,'HalfPowerFrequency2',51, 'DesignMethod','butter','SampleRate',Fs);
ECG_filtr1 = filtfilt(d,ECG_mn);

%Wykres odpowiedzi impulsowej
fvtool(d,'Fs',Fs)
[p_ECG_mn,f_ECG_mn] = periodogram(ECG_mn,[],[],Fs);
[p_ECG_filtr1,f_ECG_filtr1] = periodogram(ECG_filtr1,[],[],Fs);
title('OdpowiedŸ impulsowa');
xlabel('Czêstotliwoœæ [Hz]');
ylabel('Amplituda [dB]');

% Górnoprzepustowy filtr Butterwortha
Fc_1 = 0.5;
[z,p,k] = butter(4,Fc_1/Fs,'high');
sos = zp2sos(z,p,k);
fvtool(sos,'Analysis','freq');
title('OdpowiedŸ impulsowa i fazowa');
xlabel('Znormalizowana czêstotliwoœæ [Hz]');
ylabel('Amplituda [dB]/Faza[rad]');

ECG_filtr2 = filtfilt(sos,0.5,ECG_filtr1);

% Œrodkowoprzepustowy filtr Butterwortha
[A,B,C,D] = butter(4,[15 20]/(Fs/2));
d = designfilt('bandpassiir','FilterOrder',8, 'HalfPowerFrequency1',15,'HalfPowerFrequency2',20, 'SampleRate',360);

sos2 = ss2sos(A,B,C,D);
fvt = fvtool(sos2,d,'Fs',360);
legend(fvt,'Przed zastosowaniem filtru œrodkowoprzepustowego','Po zastosowaniu filtru œrodkowoprzepustowego')
title('OdpowiedŸ impulsowa');
xlabel('Czêstotliwoœæ [Hz]');
ylabel('Amplituda [dB]');

ECG_filtr3 = filtfilt(sos2,[15 20],ECG_filtr2);

%Obliczanie energii próbkowania
ECG_energia=zeros(n,1);
for i=1:n
ECG_energia(i)=ECG_filtr3(i)*ECG_filtr3(i);
end;    

ECG_energia_mn=mean(ECG_energia);

%Obliczanie wartoœci progowej
TH=zeros(n,1);
for i=1:n
    TH(i)=2*ECG_energia_mn;  
end;

%Znalezienie za³amków R
R=zeros(n,1);
for i=1:n
    if ECG_energia(i)<TH
        ECG_energia(i)=0;
    end; 
end;

[pks,locs]=findpeaks(ECG_energia);
findpeaks(ECG_energia);

%Wyznaczanie za³amków R
R_peak=zeros(n,1);
for i=1:n
    if i~=1 && i~=n
         if ECG_energia(i-1)<ECG_energia(i) && ECG_energia(i+1)<ECG_energia(i)
            R_peak(i)=ECG_energia(i);
         end;     
    end;
end;    

%Obliczanie odstêpów miêdzy za³amkami R-R
t_RR=zeros(n,1);
for i=1:n
    if i~=1 && i~=n
        if R_peak(i)~=0
           t_RR(i)=t(i);
        end;
    end;
end; 

t_index = find(t_RR);  %indeks próbki, dla której mamy R_peak

RR_interval=zeros;
for i=1:length(t_index)
    if i~=length(t_index)
        zmienna1 = t_index(i);
        zmienna2 = t_index(i+1);
        RR_interval(i)=t_RR(zmienna2)-t_RR(zmienna1);
    end;
end;

RR_interval_mn=mean(RR_interval);

TT_interval=zeros;
for i=1:length(t_index)
    if i~=length(t_index)
        TT_interval(i)=t_index(i+1)-t_index(i);
    end;
end;
nz = find(TT_interval <50);
TT_interval = TT_interval(nz);
TT_interval_mn=mean(TT_interval);

%Obliczanie œredniej czêstotliwoœci czêstotliwoœci bicia serca
HR_mn=1500/TT_interval_mn;

%Obliczanie chwilowej czêstotliwoœci bicia serca
HR_moment=zeros;
for i=1:length(TT_interval)
HR_moment(i)=1500/TT_interval(i);
end;

% Wyznaczenie wartoœci chwili czasu odpowiadaj¹cych momentom HR
t_HR=t(t_index);
t_HR = t_HR(nz);


%Wykres chwilowej czêstotliwoœci bicia serca
% plot(t_HR, HR_moment);
% ylabel('Czêstotliwoœæ bicia serca [bpm]');
% xlabel('Czas (ms)');
% title('Chwilowa czêstotliwoœæ bicia serca');  


%Wykres surowego sygna³u EKG
subplot(4,2,1);
plot(t,ECG_original,'b');
ylabel('Napiêcie (mV)');
xlabel('Czas (ms)');
title('Surowy sygna³ EKG');
grid on;

%Wykres sygna³u EKG po usuniêciu linii trendu, wartoœci œredniej, wp³ywu
%sieci
subplot(4,2,2);
plot(t,ECG_filtr1,'b');
ylabel('Napiêcie (mV)');
xlabel('Czas (ms)');
title('Sygna³ EKG po usuniêciu linii trendu, wartoœci œredniej, wp³ywu sieci');
grid on;

%Wykres gêstoœci mocy
subplot(4,2,3);
plot(f_ECG_mn,20*log10(abs(p_ECG_mn)),f_ECG_filtr1,20*log10(abs(p_ECG_filtr1)),'--');
ylabel('Moc/czêstotliwoœæ (dB/Hz)');
xlabel('Czêstotliwoœæ (Hz)');
title('Gêstoœæ mocy');
legend('Sygna³ EKG przed filtacj¹','Sygna³ EKG po filtracji');
grid on;

%Wykres sygna³u EKG po zastosowaniu górnoprzepustowego filtru Butterwortha
subplot(4,2,4);
plot(t,ECG_filtr2,'b');
ylabel('Napiêcie (mV)');
xlabel('Czas (ms)');
title('Sygna³ EKG po zastosowaniu górnoprzepustowego filtru Butterwortha');
grid on;

%Wykres sygna³u EKG po zastosowaniu œrodkowoprzepustowego filtru Butterwortha
subplot(4,2,5);
plot(t,ECG_filtr3,'r');
ylabel('Napiêcie (mV)');
xlabel('Czas (ms)');
title('Sygna³ po zastosowaniu œrodkowoprzepustowego filtru Butterwortha');
grid on;

%Wykres sygna³u energii
subplot(4,2,6);
plot(t,ECG_energia,'b',t,TH,'r');
ylabel('Energia')
xlabel('Czas (ms)')
title('Sygna³ energii');
grid on;

%Wykres uwydatnionych za³amków R
subplot(4,2,[7,8]);
[pks,locs]=findpeaks(ECG_energia);
findpeaks(ECG_energia);
xlabel('Próbki')
ylabel('Energia')
title('Uwydatnione za³amki R')
grid on;
   


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% PRZYCISK ZAPISZ DANE
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

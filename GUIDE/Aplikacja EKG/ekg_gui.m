function varargout = ekg_gui(varargin)
% EKG_GUI MATLAB code for ekg_gui.fig
%      EKG_GUI, by itself, creates a new EKG_GUI or raises the existing
%      singleton*.
%
%      H = EKG_GUI returns the handle to a new EKG_GUI or the handle to
%      the existing singleton*.
%
%      EKG_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EKG_GUI.M with the given input arguments.
%
%      EKG_GUI('Property','Value',...) creates a new EKG_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ekg_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ekg_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ekg_gui

% Last Modified by GUIDE v2.5 30-Apr-2017 17:54:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ekg_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @ekg_gui_OutputFcn, ...
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


% --- Executes just before ekg_gui is made visible.
function ekg_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ekg_gui (see VARARGIN)

% Choose default command line output for ekg_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global dane;
dane = [];

% UIWAIT makes ekg_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ekg_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnWczytaj.
function btnWczytaj_Callback(hObject, eventdata, handles)
% hObject    handle to btnWczytaj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dane;
dane = [];
[filename, pathname] = uigetfile({'*.txt';'*.dat';'*.data';'*.*'},'Wybierz plik do wczytania');
if (filename~=0)
    plik = strcat(pathname,filename);
    dane = dlmread(plik);
end
s = size(dane,1);
h = msgbox(strcat('Wczytano rekordów #:',num2str(s)),'£adowanie danych');


% --- Executes on button press in btnObliczenia.
function btnObliczenia_Callback(hObject, eventdata, handles)
% hObject    handle to btnObliczenia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dane;
global x;
global y;
if (min(size(dane))>0)
    parametr = str2double(get(handles.editBPM,'String'));
    x=dane(:,1)/parametr;
    y=dane(:,2);
    handles.axWykres = plot(x, y);
else
    msgbox('Brak wczytanych danych','B³¹d');
end

% --- Executes on button press in btnZapisz.
function btnZapisz_Callback(hObject, eventdata, handles)
% hObject    handle to btnZapisz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x;
global y;
dane_zapis = [x y];
[filename, pathname] = uiputfile({'*.txt';'*.dat';'*.data';'*.*'},'Wybierz plik do wczytania');
if (filename~=0)
    plik = strcat(pathname,filename);
    dlmwrite(plik,dane_zapis);
end


% --- Executes on button press in btnWyczysc.
function btnWyczysc_Callback(hObject, eventdata, handles)
% hObject    handle to btnWyczysc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dane;
dane = [];
set(handles.editBPM,'String',num2str(1.0));
handles.axWykres = plot(0, 0);

function editBPM_Callback(hObject, eventdata, handles)
% hObject    handle to editBPM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBPM as text
%        str2double(get(hObject,'String')) returns contents of editBPM as a double


% --- Executes during object creation, after setting all properties.
function editBPM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBPM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

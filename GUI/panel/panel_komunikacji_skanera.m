function varargout = panel_komunikacji_skanera(varargin)
% PANEL_KOMUNIKACJI_SKANERA MATLAB code for panel_komunikacji_skanera.fig
%      PANEL_KOMUNIKACJI_SKANERA, by itself, creates a new PANEL_KOMUNIKACJI_SKANERA or raises the existing
%      singleton*.
%
%      H = PANEL_KOMUNIKACJI_SKANERA returns the handle to a new PANEL_KOMUNIKACJI_SKANERA or the handle to
%      the existing singleton*.
%
%      PANEL_KOMUNIKACJI_SKANERA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PANEL_KOMUNIKACJI_SKANERA.M with the given input arguments.
%
%      PANEL_KOMUNIKACJI_SKANERA('Property','Value',...) creates a new PANEL_KOMUNIKACJI_SKANERA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before panel_komunikacji_skanera_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to panel_komunikacji_skanera_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help panel_komunikacji_skanera

% Last Modified by GUIDE v2.5 06-Aug-2013 01:18:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @panel_komunikacji_skanera_OpeningFcn, ...
                   'gui_OutputFcn',  @panel_komunikacji_skanera_OutputFcn, ...
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




% --- Executes just before panel_komunikacji_skanera is made visible.
function panel_komunikacji_skanera_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to panel_komunikacji_skanera (see VARARGIN)

% Choose default command line output for panel_komunikacji_skanera
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes panel_komunikacji_skanera wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = panel_komunikacji_skanera_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1_com_port.
function listbox1_com_port_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1_com_port (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1_com_port contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1_com_port
global port_com;
item = get(handles.listbox1_com_port,'Value');
list = get(handles.listbox1_com_port,'String');
item_selected = list{item};
port_com = item_selected;
disp('Wybrano port');
disp(port_com);


% --- Executes during object creation, after setting all properties.
function listbox1_com_port_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1_com_port (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2_baudrate.
function listbox2_baudrate_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2_baudrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global baudrate;
item = get(handles.listbox2_baudrate,'Value');
list = get(handles.listbox2_baudrate,'String');
item_selected = list{item};
baudrate = str2num(item_selected);
disp('Wybrano baud rate portu');
disp(baudrate);



% --- Executes during object creation, after setting all properties.
function listbox2_baudrate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2_baudrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1_connect.
function pushbutton1_connect_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1_connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global port;
global port_com;
global baudrate;
disp('Otwieranie portu');
port = serial(port_com, 'BaudRate', baudrate);
disp(port);
fopen(port);


% --- Executes on button press in pushbutton2_disconect.
function pushbutton2_disconect_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2_disconect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global port;
disp('Zamykanie portu');
fclose(port);



function edit1_skrypt_Callback(hObject, eventdata, handles)
% hObject    handle to edit1_skrypt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1_skrypt as text
%        str2double(get(hObject,'String')) returns contents of edit1_skrypt as a double
global skrypt;
skrypt = get(handles.edit1_skrypt,'String');
disp(skrypt);


% --- Executes during object creation, after setting all properties.
function edit1_skrypt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1_skrypt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit1_skrypt and none of its controls.
function edit1_skrypt_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit1_skrypt (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4_send.
function pushbutton4_send_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4_send (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global skrypt;
global port;
disp('Wysy³anie skryptu do urz¹dzenia');
disp(skrypt);
set(handles.edit3_wynik,'String',skrypt)
%fprintf(port,skrypt);


% --- Executes during object creation, after setting all properties.
function edit3_wynik_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3_wynik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in listbox4_command.
function listbox4_command_Callback(hObject, eventdata, handles)
% hObject    handle to listbox4_command (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global opcja;
item = get(handles.listbox4_command,'Value');
opcja = item;
disp('Wybrano opcje');
disp(opcja);

% Hints: contents = cellstr(get(hObject,'String')) returns listbox4_command contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox4_command


% --- Executes during object creation, after setting all properties.
function listbox4_command_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox4_command (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_parametr_Callback(hObject, eventdata, handles)
% hObject    handle to edit4_parametr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4_parametr as text
%        str2double(get(hObject,'String')) returns contents of edit4_parametr as a double
global parametr;
parametr = get(handles.edit4_parametr,'String');


% --- Executes during object creation, after setting all properties.
function edit4_parametr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4_parametr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5_send.
function pushbutton5_send_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5_send (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global opcja;
global os;
global polecenie;
global parametr;

if (opcja==1)
    polecenie = 'GI';
elseif (opcja==2)
    polecenie = strcat(os,'MM',parametr);
elseif (opcja==3)
    polecenie ='';
elseif (opcja==4)
    polecenie = strcat('XF',parametr,', YF',parametr);
end
disp('Wyœlij polecenie');
disp(polecenie);
set(handles.edit3_wynik,'String',polecenie)
%fprintf(port,polecenie);



% --- Executes on selection change in listbox5_chart.
function listbox5_chart_Callback(hObject, eventdata, handles)
% hObject    handle to listbox5_chart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global os;
item = get(handles.listbox5_chart,'Value');
list = get(handles.listbox5_chart,'String');
item_selected = list{item};
os = item_selected;
disp('Wybrano Oœ');
disp(os);



% Hints: contents = cellstr(get(hObject,'String')) returns listbox5_chart contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox5_chart


% --- Executes during object creation, after setting all properties.
function listbox5_chart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox5_chart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

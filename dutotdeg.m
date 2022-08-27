function varargout = dutotdeg(varargin)
% DUTOTDEG MATLAB code for dutotdeg.fig
%      DUTOTDEG, by itself, creates a new DUTOTDEG or raises the existing
%      singleton*.
%
%      H = DUTOTDEG returns the handle to a new DUTOTDEG or the handle to
%      the existing singleton*.
%
%      DUTOTDEG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DUTOTDEG.M with the given input arguments.
%
%      DUTOTDEG('Property','Value',...) creates a new DUTOTDEG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dutotdeg_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dutotdeg_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dutotdeg

% Last Modified by GUIDE v2.5 22-Jun-2021 22:38:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dutotdeg_OpeningFcn, ...
                   'gui_OutputFcn',  @dutotdeg_OutputFcn, ...
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


% --- Executes just before dutotdeg is made visible.
function dutotdeg_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dutotdeg (see VARARGIN)

% Choose default command line output for dutotdeg
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dutotdeg wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dutotdeg_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x=get(handles.edit1,'string');
x=str2double(x);
du=dfm_du(x);
du=num2str(du);
set(handles.edit2,'string',du);
function du=dfm_du(x)
  x_1=fix(x);
  x_2=fix(100*(x-x_1));
  x_3=round(100*(100*(x-x_1)-x_2));
  du=x_1+x_2/60+x_3/3600;
% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x=get(handles.edit1,'string');
x=str2double(x);
dmf=du_dfm(x);
dmf=num2str(dmf);
set(handles.edit2,'string',dmf);
function dmf=du_dfm(x)
  x_du=fix(x);
  x_fen=fix((x-x_du)*60);
  x_miao=round(((x-x_du)*60-x_fen)*60);
  dmf=sprintf('%d°%d′%d″',x_du,x_fen,x_miao);
% Hint: get(hObject,'Value') returns toggle state of radiobutton2

function varargout = radtotdeg(varargin)
% RADTOTDEG MATLAB code for radtotdeg.fig
%      RADTOTDEG, by itself, creates a new RADTOTDEG or raises the existing
%      singleton*.
%
%      H = RADTOTDEG returns the handle to a new RADTOTDEG or the handle to
%      the existing singleton*.
%
%      RADTOTDEG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RADTOTDEG.M with the given input arguments.
%
%      RADTOTDEG('Property','Value',...) creates a new RADTOTDEG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before radtotdeg_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to radtotdeg_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help radtotdeg

% Last Modified by GUIDE v2.5 22-Jun-2021 22:19:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @radtotdeg_OpeningFcn, ...
                   'gui_OutputFcn',  @radtotdeg_OutputFcn, ...
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


% --- Executes just before radtotdeg is made visible.
function radtotdeg_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to radtotdeg (see VARARGIN)

% Choose default command line output for radtotdeg
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes radtotdeg wait for user response (see UIRESUME)
% uiwait(handles.radtotdeg);


% --- Outputs from this function are returned to the command line.
function varargout = radtotdeg_OutputFcn(hObject, eventdata, handles) 
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

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x=get(handles.edit1,'String');
x=str2double(x);
rad=angle_rad(x);
rad=num2str(rad);
set(handles.edit2,'String',rad);
function rad=angle_rad(x)
%角度转化弧度
a=fix(x);%取度数
b1=(x-a)*100;
b=fix(b1);%取分
c=(b1-b)*100;%取秒
d=180*60*60/pi;
rad=(a*60*60+b*60+c)/d;

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x=get(handles.edit1,'string');
x=str2double(x);
angle=rad_angle(x);
angle=num2str(angle);
set(handles.edit2,'String',angle);
function angle=rad_angle(x)
% 弧度转度数,只能计算正的，负值可以先取绝对值然后360加上所算的值
d=(180*60*60)/pi;
a=x*d;
du=fix(a/3600);
fen=fix((a-du*3600)/60);
miao=fix(a-du*3600-fen*60);
   if(x>0)
     angle=sprintf('%d°%d′%d″',du,fen,miao);
   else
     angle=sprintf('%d°%d′%d″',359+du,59+fen,60+miao);
   end

% Hint: get(hObject,'Value') returns toggle state of radiobutton4

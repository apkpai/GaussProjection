function varargout = jiaohuitot(varargin)
% JIAOHUITOT MATLAB code for jiaohuitot.fig
%      JIAOHUITOT, by itself, creates a new JIAOHUITOT or raises the existing
%      singleton*.
%
%      H = JIAOHUITOT returns the handle to a new JIAOHUITOT or the handle to
%      the existing singleton*.
%
%      JIAOHUITOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in JIAOHUITOT.M with the given input arguments.
%
%      JIAOHUITOT('Property','Value',...) creates a new JIAOHUITOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before jiaohuitot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to jiaohuitot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help jiaohuitot

% Last Modified by GUIDE v2.5 09-Jan-2022 16:18:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @jiaohuitot_OpeningFcn, ...
                   'gui_OutputFcn',  @jiaohuitot_OutputFcn, ...
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


% --- Executes just before jiaohuitot is made visible.
function jiaohuitot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to jiaohuitot (see VARARGIN)

% Choose default command line output for jiaohuitot
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes jiaohuitot wait for user response (see UIRESUME)
% uiwait(handles.jiaohuitot);


% --- Outputs from this function are returned to the command line.
function varargout = jiaohuitot_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
A=imread('help.png');
A(A==0)=255;
set(handles.pushbutton3,'CData',A);



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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A=get(handles.edit1,'string');
A=regexp(A,',','split');
A=str2double(A);
x1=A(1);
y1=A(2);
x2=A(3);
y2=A(4);
a1=A(5);
a2=A(6);
qfjh=qianfangjiaohui(x1,y1,x2,y2,a1,a2);
qfjh=num2str(qfjh);
set(handles.edit2,'string',qfjh);

function qfjh=qianfangjiaohui(x1,y1,x2,y2,a1,a2)
%前方交会计算
% fprintf('两个点按照顺时针顺序输入：');
d_x=x2-x1;
d_y=y2-y1;
a1=angle_rad(a1);
a2=angle_rad(a2);
x=(x1*cot(a2)+x2*cot(a1)+d_y)/(cot(a1)+cot(a2));
y=(y1*cot(a2)+y2*cot(a1)-d_x)/(cot(a1)+cot(a2));
qfjh=sprintf('待求点:\nx:%f\ny:%f\n',x,y);
function rad=angle_rad(x)
%角度转化弧度
a=fix(x);%取度数
b1=(x-a)*100;
b=fix(b1);%取分
c=(b1-b)*100;%取秒
d=180*60*60/pi;
rad=(a*60*60+b*60+c)/d;

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit1,'string','');
set(handles.edit2,'string','');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function jiaohuitot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jiaohuitot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

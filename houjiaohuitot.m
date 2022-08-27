function varargout = houjiaohuitot(varargin)
% HOUJIAOHUITOT MATLAB code for houjiaohuitot.fig
%      HOUJIAOHUITOT, by itself, creates a new HOUJIAOHUITOT or raises the existing
%      singleton*.
%
%      H = HOUJIAOHUITOT returns the handle to a new HOUJIAOHUITOT or the handle to
%      the existing singleton*.
%
%      HOUJIAOHUITOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HOUJIAOHUITOT.M with the given input arguments.
%
%      HOUJIAOHUITOT('Property','Value',...) creates a new HOUJIAOHUITOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before houjiaohuitot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to houjiaohuitot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help houjiaohuitot

% Last Modified by GUIDE v2.5 23-Jun-2021 17:08:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @houjiaohuitot_OpeningFcn, ...
                   'gui_OutputFcn',  @houjiaohuitot_OutputFcn, ...
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


% --- Executes just before houjiaohuitot is made visible.
function houjiaohuitot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to houjiaohuitot (see VARARGIN)

% Choose default command line output for houjiaohuitot
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes houjiaohuitot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = houjiaohuitot_OutputFcn(hObject, eventdata, handles) 
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
x3=A(5);
y3=A(6);
a1=A(7);
a2=A(8);
a3=A(9);
hfjh=houfangjiaohui(x1,y1,x2,y2,x3,y3,a1,a2,a3);
hfjh=num2str(hfjh);
set(handles.edit2,'string',hfjh)
function hfjh=houfangjiaohui(x1,y1,x2,y2,x3,y3,a1,a2,a3)
%后方交会代码实现
%（x1,y1）（x2,y2）（x3,y3）,a1为角PBC，a2为角PCA，a3为角PAB
a1=angle_rad(a1);%将输入的度数转化为弧度
a2=angle_rad(a2);
a3=angle_rad(a3);
%计算方法一
cot_A=((x2-x1)*(x3-x1)+(y2-y1)*(y3-y1))/((x2-x1)*(y3-y1)-(y2-y1)*(x3-x1));
cot_B=((x3-x2)*(x1-x2)+(y3-y2)*(y1-y2))/((x3-x2)*(y1-y2)-(y3-y2)*(x1-x2));
cot_C=((x1-x3)*(x2-x3)+(y1-y3)*(y2-y3))/((x1-x3)*(y2-y3)-(y1-y3)*(x2-x3));
P_A=1/(cot_A-cot(a1));
P_B=1/(cot_B-cot(a2));
P_C=1/(cot_C-cot(a3));
X_P_1=(P_A*x1+P_B*x2+P_C*x3)/(P_A+P_B+P_C);
Y_P_1=(P_A*y1+P_B*y2+P_C*y3)/(P_A+P_B+P_C);
hfjh=sprintf('计算得P点坐标:\nx=%f\ny=%f\n',X_P_1,Y_P_1);
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

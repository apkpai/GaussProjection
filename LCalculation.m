function varargout = LCalculation(varargin)
% LCALCULATION MATLAB code for LCalculation.fig
%      LCALCULATION, by itself, creates a new LCALCULATION or raises the existing
%      singleton*.
%
%      H = LCALCULATION returns the handle to a new LCALCULATION or the handle to
%      the existing singleton*.
%
%      LCALCULATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LCALCULATION.M with the given input arguments.
%
%      LCALCULATION('Property','Value',...) creates a new LCALCULATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LCalculation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LCalculation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LCalculation

% Last Modified by GUIDE v2.5 09-Jan-2022 16:40:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LCalculation_OpeningFcn, ...
                   'gui_OutputFcn',  @LCalculation_OutputFcn, ...
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


% --- Executes just before LCalculation is made visible.
function LCalculation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LCalculation (see VARARGIN)

% Choose default command line output for LCalculation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LCalculation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LCalculation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
A=imread('help.png');
A(A==0)=255;
set(handles.Help,'CData',A);

% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in Help.
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function L_Callback(hObject, eventdata, handles)
% hObject    handle to L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of L as text
%        str2double(get(hObject,'String')) returns contents of L as a double


% --- Executes during object creation, after setting all properties.
function L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function L0_Callback(hObject, eventdata, handles)
% hObject    handle to L0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of L0 as text
%        str2double(get(hObject,'String')) returns contents of L0 as a double


% --- Executes during object creation, after setting all properties.
function L0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Band_Callback(hObject, eventdata, handles)
% hObject    handle to Band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Band as text
%        str2double(get(hObject,'String')) returns contents of Band as a double


% --- Executes during object creation, after setting all properties.
function Band_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Calculation.
function Calculation_Callback(hObject, eventdata, handles)
% hObject    handle to Calculation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch findobj(get(handles.uibuttongroup1,'selectedobject'))
    case handles.SixDegreeBand
        L=str2num(get(handles.L,'String'));
        L0=6*(fix(L/6)+1)-3;
        n=fix((dfm_du(L)+6)/6);%带号
        set(handles.L0,'String',num2str(L0));
        set(handles.Band,'String',num2str(n));
    case handles.ThirdDegreeBand
        L=dfm_du(str2num(get(handles.L,'String')));
        L0=fix((L+1.5)/3)*3;
        n=fix((L+1.5)/3);%带号
        set(handles.L0,'String',num2str(L0));
        set(handles.Band,'String',num2str(n));
    
end

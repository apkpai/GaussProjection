function varargout = GeodesyBasicComputing(varargin)
% GEODESYBASICCOMPUTING MATLAB code for GeodesyBasicComputing.fig
%      GEODESYBASICCOMPUTING, by itself, creates a new GEODESYBASICCOMPUTING or raises the existing
%      singleton*.
%
%      H = GEODESYBASICCOMPUTING returns the handle to a new GEODESYBASICCOMPUTING or the handle to
%      the existing singleton*.
%
%      GEODESYBASICCOMPUTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GEODESYBASICCOMPUTING.M with the given input arguments.
%
%      GEODESYBASICCOMPUTING('Property','Value',...) creates a new GEODESYBASICCOMPUTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GeodesyBasicComputing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GeodesyBasicComputing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GeodesyBasicComputing

% Last Modified by GUIDE v2.5 23-Mar-2022 10:37:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GeodesyBasicComputing_OpeningFcn, ...
                   'gui_OutputFcn',  @GeodesyBasicComputing_OutputFcn, ...
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


% --- Executes just before GeodesyBasicComputing is made visible.
function GeodesyBasicComputing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GeodesyBasicComputing (see VARARGIN)

% Choose default command line output for GeodesyBasicComputing
handles.output = hObject;
format long;
% Update handles structure
guidata(hObject, handles);
get(handles.Ellipsoid,'value');%获取选择的参考椭球
switch(get(handles.Ellipsoid,'value'))
    case 1%北京54椭球
        set(handles.DATA_a,'String',num2str(6378245.0,'%.10f'));%长半轴
        set(handles.DATA_f,'String','1/298.3');%扁率
    case 2%西安80椭球
        set(handles.DATA_a,'String',num2str(6378140.0,'%.10f'));
        set(handles.DATA_f,'String','1/298.257');%扁率
    case 3%CGCS2000椭球
        set(handles.DATA_a,'String',num2str(6378137.0,'%.10f'));
        set(handles.DATA_f,'String','1/298.25722210100');%扁率
    case 4%WGS84椭球
        set(handles.DATA_a,'String',num2str(6378137.0,'%.10f'));
        set(handles.DATA_f,'String','1/298.257223563');%扁率
    case 5%克拉索夫斯基椭球
        set(handles.DATA_a,'String',num2str(6378245.0,'%.10f'));%长半轴
        set(handles.DATA_f,'String','1/298.3');%扁率
    case 6%IUGG1975椭球
        set(handles.DATA_a,'String',num2str(6378140.0,'%.10f'));
        set(handles.DATA_f,'String','1/298.257');%扁率        
end
% UIWAIT makes GeodesyBasicComputing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GeodesyBasicComputing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Import.
function Import_Callback(hObject, eventdata, handles)
% hObject    handle to Import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.dat;*.txt', '选择文件');
    if  filename==0
        msgbox('操作已取消');
        return;
    end
    switch findobj(get(handles.Fselect_XYorBL,'selectedobject'))
      case handles.Fomer_XY
%           disp("Fomer_XY");
%%%%%%%%%%%%%%%以下代码均是针对高斯反算而进行的数据文件导入的工作%%%%%%%%%%%%%%%%%
          set(handles.XYDATA,'Data',[]);
          XYDATA=table2array(readtable(filename));
          set(handles.XYDATA,'Data',XYDATA);
%           LError=errordlg('请输入坐标所处的中央子午线经度','提示');
%           set(findall(allchild(LError),'style','pushbutton'),'string','确定');
%           set(findall(get(LError,'children'),'type','text'),'fontsize',10,'fontname','隶书');
          %设置输入中央子午线经度的弹窗
          L0Prompt = {'输入坐标所在的中央子午线经度L0:'};
          dlgtitle = '参数';
          dims = [1 35];
          definput = {'',''};
          answer = inputdlg(L0Prompt,dlgtitle,dims,definput);
          if isempty(answer)==1
              InputNegative=errordlg('未输入中央子午线经度L0','输入取消');
              set(findall(allchild(InputNegative),'style','pushbutton'),'string','确定');
              set(findall(get(InputNegative,'children'),'type','text'),'fontsize',15,'fontname','隶书');
              return;
          else
              L0=str2num(answer{1});
          end
          set(handles.Meridian,'String',num2str(L0));%设置转换前坐标所在的中央子午线经度
          set(handles.After_Meridian,'String',get(handles.Meridian,'String'));%默认与转换前保持一致，设置转换后坐标所在的中央子午线经度
%%%%%%%%%%%%%%%以上代码均是针对高斯反算而进行的数据文件导入的工作%%%%%%%%%%%%%%%%%
          return;%对handles.Fomer_XY的文件导入完成
      case handles.Fomer_BL
%           disp("Fomer_BL");
          %%%%%%%%%%%%%%%以下代码均是针对高斯正算而进行的数据文件导入的工作%%%%%%%%%%%%%%%%%
          set(handles.BLDATA,'Data',[]);
          BLdata=table2array(readtable(filename));
          if get(handles.SixDegreeBand,'value')==1
%               L=dfm_du(BLdata(1,3));
                L=BLdata(1,3);
              L0=6*(fix(L/6)+1)-3;%6度带中央经度
              set(handles.Meridian,'String',num2str(L0));
%               set(handles.After_Meridian,'String',num2str(L0));
              set(handles.After_Meridian,'String',get(handles.Meridian,'String'));
          else get(handles.ThirdDegreeBand,'value')==1
              L=dfm_du(BLdata(1,3));
              L0=fix((L+1.5)/3)*3;
              set(handles.Meridian,'String',num2str(L0));
              set(handles.After_Meridian,'String',get(handles.Meridian,'String'));
          end
          set(handles.BLDATA,'Data',BLdata);
%%%%%%%%%%%%%%%以上代码均是针对高斯正算而进行的数据文件导入的工作%%%%%%%%%%%%%%%%%
          return;%对handles.Fomer_BL的文件导入完成
    end


% --- Executes on button press in Clear.
function Clear_Callback(hObject, eventdata, handles)
% hObject    handle to Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%             set(findobj('style','edit'),'String','');%清空所有edit控件数据
            clear_button=questdlg('确定清空数据吗？','数据清空','Yes','No','Yes');%内容，标题，选项（2个），默认选项
            if strcmp(clear_button,'Yes')
                %Yes，清空
                    set(findobj('Tag','Meridian'),'String','');%清空中央子午线数据
                    set(findobj('Tag','After_Meridian'),'String','');
                    %清空大地坐标表格中的数据
                    clear_BLdata=cell(4,3);
                    set(findobj('Tag','BLDATA'),'Data',clear_BLdata);
                    %清空平面坐标表格中的数据
                    clear_XYdata=cell(4,3);
                    set(findobj('Tag','XYDATA'),'Data',clear_XYdata);
            end

% --- Executes on button press in Turn.
function Turn_Callback(hObject, eventdata, handles)
% hObject    handle to Turn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% switch findobj(get(handles.select_3or6,'selectedobject'))
%     case handles.ThirdDegreeBand&&handles.SixDegreeBand
%         %定义一个错误对话框
%         BandError=errordlg('不可同时选择两种带号','带号错误');
%         set(findall(allchild(BandError),'style','pushbutton'),'string','确定');
%         set(findall(get(BandError,'children'),'type','text'),'fontsize',15,'fontname','隶书');
%     case handles.ThirdDegreeBand||handles.SixDegreeBand
%         %定义一个错误对话框
%         BandError=errordlg('有且只能选择一种带号','带号错误');
%         set(findall(allchild(BandError),'style','pushbutton'),'string','确定');
%         set(findall(get(BandError,'children'),'type','text'),'fontsize',15,'fontname','隶书');
% end
              %引入自定义椭球参数
              global diy_a;
              global diy_b;
switch findobj(get(handles.Fselect_XYorBL,'selectedobject'))
    case handles.Fomer_BL
               set(handles.After_XY,'Value',1);
                    %%%%%%%高斯正算的相关操作%%%%%%%%%
               BLdata=get(handles.BLDATA,'Data');
               class(BLdata);%判断数组的类型
               %导入的数据均为double型数组
               if isfloat(BLdata)
                   if isempty(get(handles.BLDATA,'Data'))
                      BLDATAError=errordlg('请输\导入待处理数据','错误');
                      set(findall(allchild(BLDATAError),'style','pushbutton'),'string','确定');
                      set(findall(get(BLDATAError,'children'),'type','text'),'fontsize',15,'fontname','隶书'); 
                   end
               end
               %输入的数据均为cell型数组
               if iscell(BLdata)
                  if isempty(cell2mat(get(handles.BLDATA,'Data')))
                %定义一个错误对话框去判断大地坐标是否为空
                BLDATAError=errordlg('请输\导入待处理数据','错误');
                set(findall(allchild(BLDATAError),'style','pushbutton'),'string','确定');
                set(findall(get(BLDATAError,'children'),'type','text'),'fontsize',15,'fontname','隶书');
                  end

               end
              %带号选择判断
              if get(handles.ThirdDegreeBand,'value')==1&&get(handles.SixDegreeBand,'value')==1
                %定义一个错误对话框
                BandError=errordlg('不可同时选择两种带号','带号错误');
                set(findall(allchild(BandError),'style','pushbutton'),'string','确定');
                set(findall(get(BandError,'children'),'type','text'),'fontsize',15,'fontname','隶书');
                elseif get(handles.ThirdDegreeBand,'value')==0&&get(handles.SixDegreeBand,'value')==0
                BandError=errordlg('有且只能选择一种带号','带号错误');
                set(findall(allchild(BandError),'style','pushbutton'),'string','确定');
                set(findall(get(BandError,'children'),'type','text'),'fontsize',15,'fontname','隶书');
              end
              %以下进行导入数据的类型分析，以便进行数据类型的转化
              %正算数据格式化处理
              if class(BLdata)=="double"
%                   disp("在此处设置double型BLdata的处理");
                  PotName=BLdata(:,1);
                  BLdata=BLdata(:,2:3);
              elseif class(BLdata)=="cell"
%                   disp("在此处设置cell型BLdata的处理");
                  PotName_input=BLdata(:,1);
                  BLdata=cell2mat(BLdata);%将元胞数组转化为可进行数值计算的矩阵
                  PotName=BLdata(:,1);
                  BLdata=BLdata(:,2:3);
                  if get(handles.ThirdDegreeBand,'Value')==1
                      L=dfm_du(BLdata(1,2));
                      L0=fix((L+1.5)/3)*3;
                      set(handles.Meridian,'String',num2str(L0));
                      set(handles.After_Meridian,'String',get(handles.Meridian,'String'));
                  elseif get(handles.SixDegreeBand,'Value')==1
                      L=BLdata(1,2);
                      L0=6*(fix(L/6)+1)-3;
                      set(handles.Meridian,'String',num2str(L0));
                      set(handles.After_Meridian,'String',get(handles.Meridian,'String'));
                  end
              end
              switch(get(handles.Ellipsoid,'value'))
                    case 1%北京54椭球
                        a=6378245.0;
                        b=6356863.0187730473;
                    case 2%西安80椭球
                        a=6378140.0;
                        b=6356755.2881575287; 
                    case 3%CGCS2000椭球
                        a=6378137.0;
                        b=6356752.3141;%扁率
                    case 4%WGS84椭球
                        a=6378137.0;
                        b=6356752.3142;%扁率
                    case 5%克拉索夫斯基椭球
                        a=6378245.0;%长半轴
                        b=6356863.0187730473;%扁率
                    case 6%IUGG1975椭球
                        a=6378140.0;
                        b=6356755.2881575287;%扁率
                    case 7%自定义椭球
                        a=diy_a;
                        b=diy_b;
              end
              if get(handles.SixDegreeBand,'Value')==1
                  i=1;
                  %定义一个用于存放正算结果的空矩阵
                  Result_GaussPositiveFormula=zeros(size(get(handles.BLDATA,'Data')))*nan;
                  class(PotName);
                  while i<=size(BLdata,1)
                      [x,y] = GaussPositiveFormula(a,b,BLdata(i,1),BLdata(i,2));
                      Result_GaussPositiveFormula(i,:)=[PotName(i),x,y];
                      i=i+1;
                  end
              elseif get(handles.ThirdDegreeBand,'Value')==1
                  i=1;
                  %定义一个用于存放正算结果的空矩阵
                  Result_GaussPositiveFormula=zeros(size(get(handles.BLDATA,'Data')))*nan;
                  class(PotName);
                  while i<=size(BLdata,1)
                      [x,y] = GaussPositiveFormula_3(a,b,BLdata(i,1),BLdata(i,2));
                      Result_GaussPositiveFormula(i,:)=[PotName(i),x,y];
                      i=i+1;
                  end
              end

              PotName_str=num2str(PotName);
              PotName_cell=cellstr(PotName_str);
%               num2str(Result_GaussPositiveFormula(:,2),16)16为小数点位数

            Formerx0=str2num(get(handles.FormerX0,'String'))*1000;
            Result_GaussPositiveFormula_x=Result_GaussPositiveFormula(:,2)+Formerx0;
            Result_GaussPositiveFormula_x_cell=cellstr(num2str(Result_GaussPositiveFormula_x,16));
            Formery0=str2num(get(handles.FormerY0,'String'))*1000;
            Result_GaussPositiveFormula_y=Result_GaussPositiveFormula(:,3)+Formery0;
            Result_GaussPositiveFormula_y_cell=cellstr(num2str(Result_GaussPositiveFormula_y,16));

               Result_GaussPositiveFormula_x0=cellstr(num2str(Result_GaussPositiveFormula(:,2),16));%未加常数的x
               Result_GaussPositiveFormula_y0=cellstr(num2str(Result_GaussPositiveFormula(:,3),16));%未加常数的y
               if size(PotName,1)==1
                   PotName_cell={PotName;'NaN';'NaN';'NaN'};
               elseif size(PotName,1)==2
                   PotName_cell={PotName(1);PotName(2);'NaN';'NaN'};
               elseif size(PotName,1)==3
                   PotName_cell={PotName(1);PotName(2);PotName(3);'NaN'};
               elseif size(PotName,1)==4
                   PotName_cell={PotName(1);PotName(2);PotName(3);PotName(4)};
               end
              set(handles.XYDATA,'Data',[PotName_cell,Result_GaussPositiveFormula_x_cell,Result_GaussPositiveFormula_y_cell]);
%               [x,y] = GaussPositiveFormula(a,b,B,L)
              %%%%%%%高斯正算的相关操作%%%%%%%%%
    case handles.Fomer_XY
        set(handles.After_BL,'Value',1);
        %%%%%%%高斯反算的相关操作%%%%%%%%%
        XYdata=get(handles.XYDATA,'Data');
        class(XYdata);%判断数组的类型
        %导入的数据均为douXYe型数组
        if isfloat(XYdata)
            if isempty(get(handles.XYDATA,'Data'))
                XYDATAError=errordlg('请输\导入待处理数据','错误');
                set(findall(allchild(XYDATAError),'style','pushbutton'),'string','确定');
                set(findall(get(XYDATAError,'children'),'type','text'),'fontsize',15,'fontname','隶书');
            end
        end
        %输入的数据均为cell型数组
        if iscell(XYdata)
            if isempty(cell2mat(get(handles.XYDATA,'Data')))
                %定义一个错误对话框去判断大地坐标是否为空
                XYDATAError=errordlg('请输\导入待处理数据','错误');
                set(findall(allchild(XYDATAError),'style','pushbutton'),'string','确定');
                set(findall(get(XYDATAError,'children'),'type','text'),'fontsize',15,'fontname','隶书');
            end

        end

        %反算数据格式化处理
        if class(XYdata)=="double"
%             disp("在此处设置douXYe型XYdata的处理");
            PotName=XYdata(:,1);
            XYdata=XYdata(:,2:3);
            Formerx0=str2num(get(handles.FormerX0,'String'))*1000;
            Formery0=str2num(get(handles.FormerY0,'String'))*1000;
            XYdata_x=XYdata(:,1)-Formerx0;
            XYdata_y=XYdata(:,2)-Formery0;
            XYdata=[XYdata_x,XYdata_y];
        elseif class(XYdata)=="cell"
%             disp("在此处设置cell型XYdata的处理");
            PotName_input=XYdata(:,1);
            XYdata=cell2mat(XYdata);%将元胞数组转化为可进行数值计算的矩阵
            PotName=XYdata(:,1);
            XYdata=XYdata(:,2:3);
            Formerx0=str2num(get(handles.FormerX0,'String'))*1000;
            Formery0=str2num(get(handles.FormerY0,'String'))*1000;
            XYdata_x=XYdata(:,1)-Formerx0;
            XYdata_y=XYdata(:,2)-Formery0;
            XYdata=[XYdata_x,XYdata_y];
        end
        switch(get(handles.Ellipsoid,'value'))
            case 1%北京54椭球
                a=6378245.0;
                b=6356863.0187730473;
            case 2%西安80椭球
                a=6378140.0;
                b=6356755.2881575287;
            case 3%CGCS2000椭球
                a=6378137.0;
                b=6356752.3141;%扁率
            case 4%WGS84椭球
                a=6378137.0;
                b=6356752.3142;%扁率
            case 5%克拉索夫斯基椭球
                a=6378245.0;%长半轴
                b=6356863.0187730473;%扁率
            case 6%IUGG1975椭球
                a=6378140.0;
                b=6356755.2881575287;%扁率
            case 7%自定义椭球
                a=diy_a;
                b=diy_b;
        end
                i=1;
        %定义一个用于存放反算结果的空矩阵
        Result_GaussNegativeFormula=zeros(size(get(handles.XYDATA,'Data')))*nan;
        class(PotName);
        while i<=size(XYdata,1)
            [B,l] = GaussNegativeFormula(a,b,XYdata(i,1),XYdata(i,2));
            Result_GaussNegativeFormula(i,:)=[PotName(i),B,l];
            i=i+1;
        end
        PotName_str=num2str(PotName);
        PotName_cell=cellstr(PotName_str);
        if size(PotName,1)==1
            PotName_cell={PotName;'NaN';'NaN';'NaN'};
        elseif size(PotName,1)==2
            PotName_cell={PotName(1);PotName(2);'NaN';'NaN'};
        elseif size(PotName,1)==3
            PotName_cell={PotName(1);PotName(2);PotName(3);'NaN'};
        elseif size(PotName,1)==4
            PotName_cell={PotName(1);PotName(2);PotName(3);PotName(4)};
        end
        Result_GaussNegativeFormula_B=Result_GaussNegativeFormula(:,2);
        i=1;
        while i<=size(Result_GaussNegativeFormula_B,1)
            Result_GaussNegativeFormula_B_1(i,1)=cellstr(rad_angle(Result_GaussNegativeFormula_B(i)));
            i=i+1;
        end
        Result_GaussNegativeFormula_B_cell=Result_GaussNegativeFormula_B_1;
%         Result_GaussNegativeFormula_B_cell=cellstr(num2str(Result_GaussNegativeFormula_B,16))
        Result_GaussNegativeFormula_l=Result_GaussNegativeFormula(:,3);
        L0=get(handles.Meridian,'String');
        L0=str2num(L0);
        L0=angle_rad(L0);
        o=1;
        Result_GaussNegativeFormula_L=L0+Result_GaussNegativeFormula_l;
        while o<=size(Result_GaussNegativeFormula_L,1)
            Result_GaussNegativeFormula_L_1(o,1)=cellstr(rad_angle(Result_GaussNegativeFormula_L(o)));
            o=o+1;
        end
        Result_GaussNegativeFormula_L_cell=Result_GaussNegativeFormula_L_1;
%         Result_GaussNegativeFormula_L_cell=cellstr(num2str(Result_GaussNegativeFormula_L,16));
        set(handles.BLDATA,'Data',[PotName_cell,Result_GaussNegativeFormula_B_cell,Result_GaussNegativeFormula_L_cell]);
               %%%%%%%%%%%%%%%%%%%%%%%%%%
end

  
% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
        Savebutton=questdlg('选择导出数据的格式：','数据导出','Excle格式','文本格式','文本格式');
        switch findobj(get(handles.Fselect_XYorBL,'selectedobject'))
            case handles.Fomer_BL
                if strcmp(Savebutton,'文本格式')
                   [filename pathname]=uiputfile({'*.txt'},'保存','xy_myfile');
                   %%%%将元胞数组输出到文本文件
                   str=strcat(pathname,filename);
                   data=get(handles.XYDATA,'Data');
                   fin=fopen(str,'wt');
                   if isequal(filename,0) || isequal(pathname,0)
                       return;
                   else
                       for ii=1:size(data,1)
                           fprintf(fin,'%s\n',data{ii,:});
                       end
                       fclose(fin);
                   end
                   basicwaitbar;%进度条
                elseif strcmp(Savebutton,'Excle格式')
                    [filename pathname]=uiputfile({'*.xlsx'},'保存','xy_myfile');
                    xlswrite(filename,get(handles.XYDATA,'Data'));
                    basicwaitbar;%进度条
                end

            case handles.Fomer_XY
                if strcmp(Savebutton,'文本格式')
                   [filename pathname]=uiputfile({'*.txt'},'保存','BL_myfile');
                   %%%%将元胞数组输出到文本文件
                   str=strcat(pathname,filename);
                   data=get(handles.BLDATA,'Data');
                   fin=fopen(str,'wt');
                   if isequal(filename,0) || isequal(pathname,0)
                       return;
                   else
                       for ii=1:size(data,1)
                           fprintf(fin,'%s\n',data{ii,:});
                       end
                       fclose(fin);
                   end
                   basicwaitbar;%进度条
                elseif strcmp(Savebutton,'Excle格式')
                    [filename pathname]=uiputfile({'*.xlsx'},'保存','BL_myfile');
                    xlswrite(filename,get(handles.BLDATA,'Data'));
                end
                basicwaitbar;%进度条
        end

% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
        Exitbutton=questdlg('确定退出吗？','退出程序','Yes','No','Yes');%内容，标题，选项（2个），默认选项
        if strcmp(Exitbutton,'Yes')
            delete(hObject);%Yes，关闭程序界面
            close;
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


% --- Executes on selection change in Ellipsoid.
function Ellipsoid_Callback(hObject, eventdata, handles)
% hObject    handle to Ellipsoid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Ellipsoid contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Ellipsoid
guidata(hObject, handles);
get(handles.Ellipsoid,'value');%获取选择的参考椭球
global diy_a;
global diy_b;
switch(get(handles.Ellipsoid,'value'))
    case 1%北京54椭球
        set(handles.DATA_a,'String',num2str(6378245.0,'%.10f'));%长半轴
        set(handles.DATA_f,'String','1/298.3');%扁率
    case 2%西安80椭球
        set(handles.DATA_a,'String',num2str(6378140.0,'%.10f'));
        set(handles.DATA_f,'String','1/298.257');%扁率
    case 3%CGCS2000椭球
        set(handles.DATA_a,'String',num2str(6378137.0,'%.10f'));
        set(handles.DATA_f,'String','1/298.25722210100');%扁率
    case 4%WGS84椭球
        set(handles.DATA_a,'String',num2str(6378137.0,'%.10f'));
        set(handles.DATA_f,'String','1/298.257223563');%扁率
    case 5%克拉索夫斯基椭球
        set(handles.DATA_a,'String',num2str(6378245.0,'%.10f'));%长半轴
        set(handles.DATA_f,'String','1/298.3');%扁率
    case 6%IUGG1975椭球
        set(handles.DATA_a,'String',num2str(6378140.0,'%.10f'));
        set(handles.DATA_f,'String','1/298.257');%扁率
    case 7%其他椭球
        %输入椭球参数
        EllipsoidPrompt = {'输入长半轴a:','输入短半轴b:'};
        dlgtitle = '参数';
        dims = [1 35];
        definput = {'',''};
        answer = inputdlg(EllipsoidPrompt,dlgtitle,dims,definput);
        if isempty(answer)==1
            InputNegative=errordlg('未输入任何椭球参数','输入取消');
            set(findall(allchild(InputNegative),'style','pushbutton'),'string','确定');
            set(findall(get(InputNegative,'children'),'type','text'),'fontsize',15,'fontname','隶书');
            return;
        else
            diy_a=str2num(answer{1});
            diy_b=str2num(answer{2});
        end
        Data_f=(diy_a-diy_b)/diy_a;
        set(handles.DATA_a,'String',answer(1));
        set(handles.DATA_f,'String',num2str(Data_f));
end

% --- Executes during object creation, after setting all properties.
function Ellipsoid_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ellipsoid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DATA_a_Callback(hObject, eventdata, handles)
% hObject    handle to DATA_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DATA_a as text
%        str2double(get(hObject,'String')) returns contents of DATA_a as a double


% --- Executes during object creation, after setting all properties.
function DATA_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DATA_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DATA_f_Callback(hObject, eventdata, handles)
% hObject    handle to DATA_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DATA_f as text
%        str2double(get(hObject,'String')) returns contents of DATA_f as a double


% --- Executes during object creation, after setting all properties.
function DATA_f_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DATA_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object deletion, before destroying properties.
function BLDATA_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to BLDATA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function After_Meridian_Callback(hObject, eventdata, handles)
% hObject    handle to After_Meridian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of After_Meridian as text
%        str2double(get(hObject,'String')) returns contents of After_Meridian as a double


% --- Executes during object creation, after setting all properties.
function After_Meridian_CreateFcn(hObject, eventdata, handles)
% hObject    handle to After_Meridian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AfterX0_Callback(hObject, eventdata, handles)
% hObject    handle to AfterX0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AfterX0 as text
%        str2double(get(hObject,'String')) returns contents of AfterX0 as a double


% --- Executes during object creation, after setting all properties.
function AfterX0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AfterX0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AfterY0_Callback(hObject, eventdata, handles)
% hObject    handle to AfterY0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AfterY0 as text
%        str2double(get(hObject,'String')) returns contents of AfterY0 as a double


% --- Executes during object creation, after setting all properties.
function AfterY0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AfterY0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Meridian_Callback(hObject, eventdata, handles)
% hObject    handle to Meridian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Meridian as text
%        str2double(get(hObject,'String')) returns contents of Meridian as a double
set(handles.After_Meridian,'String',get(handles.Meridian,'String'));

% --- Executes during object creation, after setting all properties.
function Meridian_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Meridian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FormerX0_Callback(hObject, eventdata, handles)
% hObject    handle to FormerX0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FormerX0 as text
%        str2double(get(hObject,'String')) returns contents of FormerX0 as a double
set(handles.AfterX0,'String',get(handles.FormerX0,'String'));%默认与转换前保持一致,%设置转换前坐标加常数x0

% --- Executes during object creation, after setting all properties.
function FormerX0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FormerX0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FormerY0_Callback(hObject, eventdata, handles)
% hObject    handle to FormerY0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FormerY0 as text
%        str2double(get(hObject,'String')) returns contents of FormerY0 as a double
set(handles.AfterY0,'String',get(handles.FormerY0,'String'));%默认与转换前保持一致,%设置转换前坐标加常数y0

% --- Executes during object creation, after setting all properties.
function FormerY0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FormerY0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ThirdDegreeBand.
function ThirdDegreeBand_Callback(hObject, eventdata, handles)
% hObject    handle to ThirdDegreeBand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ThirdDegreeBand
        BLdata=get(handles.BLDATA,'Data');
        class(BLdata);
%         BLdata=cell2mat(BLdata);%将元胞数组转化为可进行数值计算的矩阵
%         if class(BLdata)==cell
%             BLdata=cell2mat(BLdata);
%         else
%             return;
%         end
        switch class(BLdata)
            case 'cell'
                BLdata=cell2mat(BLdata);%将元胞数组转化为可进行数值计算的矩阵
            otherwise
                BLdata_wuyong=BLdata;                
        end
        BLdata=BLdata(:,2:3);
        L=dfm_du(BLdata(1,2));
        L0=fix((L+1.5)/3)*3;
        set(handles.Meridian,'String',num2str(L0));
        set(handles.After_Meridian,'String',get(handles.Meridian,'String'));

% --- Executes on button press in SixDegreeBand.
function SixDegreeBand_Callback(hObject, eventdata, handles)
% hObject    handle to SixDegreeBand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SixDegreeBand
        BLdata=get(handles.BLDATA,'Data');
        class(BLdata);
        switch class(BLdata)
            case 'cell'
                BLdata=cell2mat(BLdata);%将元胞数组转化为可进行数值计算的矩阵
            otherwise
                BLdata_wuyong=BLdata;                
        end
%         BLdata=cell2mat(BLdata);%将元胞数组转化为可进行数值计算的矩阵
%         if class(BLdata)==cell
%             BLdata=cell2mat(BLdata);
%         else
%             return;
%         end
        BLdata=BLdata(:,2:3);
        L=BLdata(1,2);
        L0=6*(fix(L/6)+1)-3;
        set(handles.Meridian,'String',num2str(L0));
        set(handles.After_Meridian,'String',get(handles.Meridian,'String'));

% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function Fselect_XYorBL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Fselect_XYorBL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
function select_3or6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Fselect_XYorBL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on key press with focus on Meridian and none of its controls.
function Meridian_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Meridian (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.After_Meridian,'String',get(handles.Meridian,'String'));


% --- Executes when entered data in editable cell(s) in BLDATA.
function BLDATA_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to BLDATA (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
        BLdata=get(handles.BLDATA,'Data');
        BLdata=cell2mat(BLdata);%将元胞数组转化为可进行数值计算的矩阵
        BLdata=BLdata(:,2:3);
        if get(handles.ThirdDegreeBand,'Value')==1
            L=dfm_du(BLdata(1,2));
            L0=fix((L+1.5)/3)*3;
            set(handles.Meridian,'String',num2str(L0));
            set(handles.After_Meridian,'String',get(handles.Meridian,'String'));
        elseif get(handles.SixDegreeBand,'Value')==1
            L=BLdata(1,2);
            L0=6*(fix(L/6)+1)-3;
            set(handles.Meridian,'String',num2str(L0));
            set(handles.After_Meridian,'String',get(handles.Meridian,'String'));
        end


% --- Executes on button press in Fomer_BL.
function Fomer_BL_Callback(hObject, eventdata, handles)
% hObject    handle to Fomer_BL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Fomer_BL
set(handles.After_XY,'Value',1);


% --- Executes on button press in Fomer_XY.
function Fomer_XY_Callback(hObject, eventdata, handles)
% hObject    handle to Fomer_XY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Fomer_XY
set(handles.After_BL,'Value',1);


% --------------------------------------------------------------------
function import_s_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to import_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.dat;*.txt', '选择文件');
    if  filename==0
        msgbox('操作已取消');
        return;
    end
    switch findobj(get(handles.Fselect_XYorBL,'selectedobject'))
      case handles.Fomer_XY
%           disp("Fomer_XY");
%%%%%%%%%%%%%%%以下代码均是针对高斯反算而进行的数据文件导入的工作%%%%%%%%%%%%%%%%%
          set(handles.XYDATA,'Data',[]);
          XYDATA=table2array(readtable(filename));
          set(handles.XYDATA,'Data',XYDATA);
%           LError=errordlg('请输入坐标所处的中央子午线经度','提示');
%           set(findall(allchild(LError),'style','pushbutton'),'string','确定');
%           set(findall(get(LError,'children'),'type','text'),'fontsize',10,'fontname','隶书');
          %设置输入中央子午线经度的弹窗
          L0Prompt = {'输入坐标所在的中央子午线经度L0:'};
          dlgtitle = '参数';
          dims = [1 35];
          definput = {'',''};
          answer = inputdlg(L0Prompt,dlgtitle,dims,definput);
          if isempty(answer)==1
              InputNegative=errordlg('未输入中央子午线经度L0','输入取消');
              set(findall(allchild(InputNegative),'style','pushbutton'),'string','确定');
              set(findall(get(InputNegative,'children'),'type','text'),'fontsize',15,'fontname','隶书');
              return;
          else
              L0=str2num(answer{1});
          end
          set(handles.Meridian,'String',num2str(L0));%设置转换前坐标所在的中央子午线经度
          set(handles.After_Meridian,'String',get(handles.Meridian,'String'));%默认与转换前保持一致，设置转换后坐标所在的中央子午线经度
%%%%%%%%%%%%%%%以上代码均是针对高斯反算而进行的数据文件导入的工作%%%%%%%%%%%%%%%%%
          return;%对handles.Fomer_XY的文件导入完成
      case handles.Fomer_BL
%           disp("Fomer_BL");
          %%%%%%%%%%%%%%%以下代码均是针对高斯正算而进行的数据文件导入的工作%%%%%%%%%%%%%%%%%
          set(handles.BLDATA,'Data',[]);
          BLdata=table2array(readtable(filename));
          if get(handles.SixDegreeBand,'value')==1
%               L=dfm_du(BLdata(1,3));
                L=BLdata(1,3);
              L0=6*(fix(L/6)+1)-3;%6度带中央经度
              set(handles.Meridian,'String',num2str(L0));
%               set(handles.After_Meridian,'String',num2str(L0));
              set(handles.After_Meridian,'String',get(handles.Meridian,'String'));
          else get(handles.ThirdDegreeBand,'value')==1
              L=dfm_du(BLdata(1,3));
              L0=fix((L+1.5)/3)*3;
              set(handles.Meridian,'String',num2str(L0));
              set(handles.After_Meridian,'String',get(handles.Meridian,'String'));
          end
          set(handles.BLDATA,'Data',BLdata);
%%%%%%%%%%%%%%%以上代码均是针对高斯正算而进行的数据文件导入的工作%%%%%%%%%%%%%%%%%
          return;%对handles.Fomer_BL的文件导入完成
    end


% --------------------------------------------------------------------
function save_s_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to save_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Savebutton=questdlg('选择导出数据的格式：','数据导出','Excle格式','文本格式','文本格式');
        switch findobj(get(handles.Fselect_XYorBL,'selectedobject'))
            case handles.Fomer_BL
                if strcmp(Savebutton,'文本格式')
                   [filename pathname]=uiputfile({'*.txt'},'保存','xy_myfile');
                   %%%%将元胞数组输出到文本文件
                   str=strcat(pathname,filename);
                   data=get(handles.XYDATA,'Data');
                   fin=fopen(str,'wt');
                   if isequal(filename,0) || isequal(pathname,0)
                       return;
                   else
                       for ii=1:size(data,1)
                           fprintf(fin,'%s\n',data{ii,:});
                       end
                       fclose(fin);
                   end
                elseif strcmp(Savebutton,'Excle格式')
                    [filename pathname]=uiputfile({'*.xlsx'},'保存','xy_myfile');
                    xlswrite(filename,get(handles.XYDATA,'Data'));
                end

            case handles.Fomer_XY
                if strcmp(Savebutton,'文本格式')
                   [filename pathname]=uiputfile({'*.txt'},'保存','BL_myfile');
                   %%%%将元胞数组输出到文本文件
                   str=strcat(pathname,filename);
                   data=get(handles.BLDATA,'Data');
                   fin=fopen(str,'wt');
                   if isequal(filename,0) || isequal(pathname,0)
                       return;
                   else
                       for ii=1:size(data,1)
                           fprintf(fin,'%s\n',data{ii,:});
                       end
                       fclose(fin);
                   end
                elseif strcmp(Savebutton,'Excle格式')
                    [filename pathname]=uiputfile({'*.xlsx'},'保存','BL_myfile');
                    xlswrite(filename,get(handles.BLDATA,'Data'));
                end
        end


% --- Executes on button press in pushbutton6.


% --- Executes on mouse press over figure background.
function figure1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.


% --- Executes on button press in pushbutton8.


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_7_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_13_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_17_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Developer_Callback(hObject, eventdata, handles)
% hObject    handle to Developer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myicon = imread('mine.png');
myicon(myicon==0)=255;
msgbox({'开发人员：河南理工大学测绘王建';'QQ：1472318683';'微信公众号：酷软驿站';'个人介绍：一个测绘工程专业的称不上会编程的菜鸡';'版权归开发者所有，请勿用于商业用途，违者必究'},'开发人员','custom',myicon);

% --------------------------------------------------------------------
function about_principle_Callback(hObject, eventdata, handles)
% hObject    handle to about_principle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myicon = imread('principle.png');
myicon(myicon==0)=255;
msgbox({'基本原理：大地测量学基本原理、高斯正反算、数值积分原理';'该程序致力于解决各种坐标的转换、转换精度、转换效率问题'},'开发原理','custom',myicon);

% --------------------------------------------------------------------
function Untitled_14_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_16_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function radtotdeg_Callback(hObject, eventdata, handles)
% hObject    handle to radtotdeg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%角弧互化的弹窗
A=get(handles.figure1,'Position');
Position=[A(1,1)+20,A(1,2)+10,62.00000000000003,13.888888888888886];
radtotdeg('visible','on','Position',Position);

% --------------------------------------------------------------------
function Untitled_9_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function dutotdeg_Callback(hObject, eventdata, handles)
% hObject    handle to dutotdeg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A=get(handles.figure1,'Position');
Position=[A(1,1)+20,A(1,2)+10,62.14285714285714,13.888888888888886];
dutotdeg('visible','on','Position',Position);

% --------------------------------------------------------------------
function Untitled_12_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function L0Calculation_Callback(hObject, eventdata, handles)
% hObject    handle to L0Calculation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A=get(handles.figure1,'Position');
Position=[A(1,1)+20,A(1,2)+10,62.00000000000003,13.888888888888886];
LCalculation('visible','on','Position',Position);

% --------------------------------------------------------------------
function Untitled_6_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function ForwardIntersection_Callback(hObject, eventdata, handles)
% hObject    handle to ForwardIntersection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%前方交会
A=get(handles.figure1,'Position');
Position=[A(1,1)+20,A(1,2)+10,62.428571428571445,14.111111111111114];
jiaohuitot('visible','on','Position',Position);

% --------------------------------------------------------------------
function Resection_Callback(hObject, eventdata, handles)
% hObject    handle to Resection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%后方交会
A=get(handles.figure1,'Position');
Position=[A(1,1)+20,A(1,2)+10,62.571428571428584,14.055555555555557];
houjiaohuitot('visible','on','Position',Position);

% --------------------------------------------------------------------
function PositiveTXT_Demo_Callback(hObject, eventdata, handles)
% hObject    handle to PositiveTXT_Demo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myicon = imread('PositiveTXT_DEMO.png');
myicon(myicon==0)=255;
msgbox({'点号(仅支持数字)、B(度.分秒)、L(度.分秒)';'Demo如下(txt格式)：';'1,30.3000,114.2000';'2,30.3000,114.2000';'3,30.3000,114.2000';'4,30.3000,114.2000'},'正算数据模板','custom',myicon);

% --------------------------------------------------------------------
function NegativeTXT_Demo_Callback(hObject, eventdata, handles)
% hObject    handle to NegativeTXT_Demo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myicon = imread('PositiveTXT_DEMO.png');
myicon(myicon==0)=255;
msgbox({'点号(仅支持数字)、x(m)、y(m)';'Demo如下(txt格式)：';'1,3378627.239402275,243953.4126210633';'2,3378627.239402275,243953.4126210633';'3,3378627.239402275,243953.4126210633';'4,3378627.239402275,243953.4126210633'},'反算数据模板','custom',myicon);

% --------------------------------------------------------------------
function Format_Callback(hObject, eventdata, handles)
% hObject    handle to Format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myicon = imread('format.png');
myicon(myicon==0)=255;
msgbox({'角度：度.分秒';'分隔符：半角字符 '},'数据格式说明','custom',myicon);

% --------------------------------------------------------------------
function aboutsystem_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to aboutsystem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% A=get(handles.figure1,'Position');
% Position=[A(1,1)+20,A(1,2)+10,62.00000000000003,13.888888888888886];
% aboutsystem('visible','on','Position',Position);
myicon = imread('aboutsystem.png');
myicon(myicon==0)=255;
msgbox({'程序名称：高精度GeodesyBasicComputing软件';'程序版本：V1.0';'开发环境：WIN10+MATLAB2020A';'做梦相当程序员的开发者：王建';'UI设计：王建';'布局设计：王建';'版权归开发者所有，请勿用于商业用途，违者必究'},'关于系统','custom',myicon);


% --------------------------------------------------------------------
function uipushtool8_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%角弧互化的弹窗
A=get(handles.figure1,'Position');
Position=[A(1,1)+20,A(1,2)+10,62.00000000000003,13.888888888888886];
radtotdeg('visible','on','Position',Position);


% --------------------------------------------------------------------
function uipushtool7_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A=get(handles.figure1,'Position');
Position=[A(1,1)+20,A(1,2)+10,62.14285714285714,13.888888888888886];
dutotdeg('visible','on','Position',Position);


% --------------------------------------------------------------------
function uipushtool16_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A=get(handles.figure1,'Position');
Position=[A(1,1)+20,A(1,2)+10,62.00000000000003,13.888888888888886];
LCalculation('visible','on','Position',Position);


% --------------------------------------------------------------------
function uipushtool15_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%前方交会
A=get(handles.figure1,'Position');
Position=[A(1,1)+20,A(1,2)+10,62.428571428571445,14.111111111111114];
jiaohuitot('visible','on','Position',Position);

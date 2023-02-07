function varargout = start_gui(varargin)
% START_GUI MATLAB code for start_gui.fig
%      START_GUI, by itself, creates a new START_GUI or raises the existing
%      singleton*.
%
%      H = START_GUI returns the handle to a new START_GUI or the handle to
%      the existing singleton*.
%
%      START_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in START_GUI.M with the given input arguments.
%
%      START_GUI('Property','Value',...) creates a new START_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before start_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to start_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help start_gui

% Last Modified by GUIDE v2.5 07-Aug-2019 13:56:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @start_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @start_gui_OutputFcn, ...
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


% --- Executes just before start_gui is made visible.
function start_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to start_gui (see VARARGIN)

% Choose default command line output for start_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes start_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% global G
% ha=axes('units','normalized','position',[0 0 1 1]);
% uistack(ha,'down')
% II=imread('tum.png');
% imshow(uint8(G),[])
% colormap('jet')
% set(ha,'handlevisibility','off','visible','off');


% --- Outputs from this function are returned to the command line.
function varargout = start_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in display_dispMap.
function display_dispMap_Callback(hObject, eventdata, handles)
% hObject    handle to display_dispMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global D
axes(handles.axes3),imshow(D,[])
colormap('jet');
colorbar;
title('Disparity Map')

% --- Executes on selection change in selection.
function selection_Callback(hObject, eventdata, handles)
% hObject    handle to selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selection contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selection
global scene_path G
val = hObject.Value;
str = hObject.String{val};
scene_path = [str,'\'];
addpath(str);
G = pfmread(strcat(scene_path,'disp0.pfm'));
axes(handles.axes1),imshow(imread('im0.png'))
title('Left Image')
axes(handles.axes2),imshow(imread('im1.png'))
title('Right Image')

% --- Executes during object creation, after setting all properties.
function selection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in display_gt.
function display_gt_Callback(hObject, eventdata, handles)
% hObject    handle to display_gt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global G
axes(handles.axes3),imshow(uint8(G),[])
colormap('jet');
colorbar;
title('Ground Truth')

% --- Executes during object creation, after setting all properties.
function output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in show_results.
function show_results_Callback(hObject, eventdata, handles)
% hObject    handle to show_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global G D R T p
set(handles.R,'String',num2str(R));
set(handles.T,'String',num2str(T));
p = verify_dmap(D, G);
set(handles.p,'String',[num2str(p),'dB']);


% --- Executes on button press in display_3D.
function display_3D_Callback(hObject, eventdata, handles)
% hObject    handle to display_3D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global D
axes(handles.axes4),plot_3D(D)
title('3D plot')


% --- Executes on button press in compute_dispMap.
function compute_dispMap_Callback(hObject, eventdata, handles)
% hObject    handle to compute_dispMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global scene_path D R T
[D, R, T] = disparity_map(scene_path);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
global scene_path G
str = get(hObject,'string')
scene_path = [str,'/'];
addpath(str);
G = pfmread(strcat(scene_path,'disp0.pfm'));
axes(handles.axes1),imshow(imread('im0.png'))
title('Left Image')
axes(handles.axes2),imshow(imread('im1.png'))
title('Right Image')

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


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

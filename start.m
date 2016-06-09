function varargout = start(varargin)
% START MATLAB code for start.fig
%      START, by itself, creates a new_project START or raises the existing
%      singleton*.
%
%      H = START returns the handle to a new_project START or the handle to
%      the existing singleton*.
%
%      START('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in START.M with the given input arguments.
%
%      START('Property','Value',...) creates a new_project START or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before start_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to start_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help start

% Last Modified by GUIDE v2.5 09-Jun-2016 12:14:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @start_OpeningFcn, ...
                   'gui_OutputFcn',  @start_OutputFcn, ...
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


% --- Executes just before start is made visible.
function start_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to start (see VARARGIN)
data = struct();

data.data_status = 0;

data.preprocessing_functions = cell(0);
data.processing_functions = cell(0);
data.epoching_function = get_current_popup_string(handles.epoching_select_menu);
data.current_function = get_current_popup_string(handles.function_select_menu);
data.current_processing_function = get_current_popup_string(handles.processing_select_menu);
handles.data = data;
load_handles(handles);
% Choose default command line output for start
handles.output = hObject;
 
% Update handles structure
guidata(hObject, handles);
 
% UIWAIT makes start wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = start_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function new_project_Callback(hObject, eventdata, handles)
[file_name, path] = uiputfile;
if file_name
    handles.data.file_name = file_name;
    handles.data.path = path;
    save_file( handles);
    load_handles(handles);
    guidata(hObject,handles)
end

% --- Executes on selection change in function_select_menu.
function function_select_menu_Callback(hObject, eventdata, handles)
% hObject    handle to function_select_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns function_select_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from function_select_menu
% Determine the selected data set.

handles.data.current_function = get_current_popup_string(hObject);
% Save the handles structure.
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function function_select_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to function_select_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
str = read_file_by_lines('preprocessing/functions.txt');

set(hObject, 'String', str);


% --- Executes on button press in add_button.
function add_button_Callback(hObject, eventdata, handles)
% hObject    handle to add_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.data.preprocessing_functions = [handles.data.preprocessing_functions; {handles.data.current_function, strsplit(get(handles.preprocessing_variables,'String'),',')}];
handles.data.data_status = 0;
load_handles(handles);
guidata(hObject,handles)

% --- Executes on selection change in pre_processing_functions_list.
function pre_processing_functions_list_Callback(hObject, eventdata, handles)
handles.data.current_function_to_delete = get(hObject,'Value');
% Save the handles structure.
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function pre_processing_functions_list_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in delete_button.
function delete_button_Callback(hObject, eventdata, handles)
if isfield(handles.data,'current_function_to_delete')
    if ~isempty(handles.data.preprocessing_functions(:))
        handles.data.preprocessing_functions(handles.data.current_function_to_delete,:) = [];
        handles.data.data_status = 0;
    end
    load_handles(handles);
    guidata(hObject,handles)
end


% --- Executes on selection change in epoching_select_menu.
function epoching_select_menu_Callback(hObject, eventdata, handles)

handles.data.epoching_function = get_current_popup_string(hObject);
handles.data.data_status = min(1,handles.data.data_status);
% Save the handles structure.
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function epoching_select_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epoching_select_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject, 'String', read_file_by_lines('epoching/functions.txt'));
handles.data.epoching_function = get_current_popup_string(hObject);
% Save the handles structure.
guidata(hObject,handles)


% --- Executes on selection change in processing_select_menu.
function processing_select_menu_Callback(hObject, eventdata, handles)
handles.data.current_processing_function = get_current_popup_string(hObject);
% Save the handles structure.
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function processing_select_menu_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject, 'String', read_file_by_lines('processing/functions.txt'));

% --- Executes on button press in add_processing_function_button.
function add_processing_function_button_Callback(hObject, eventdata, handles)
handles.data.processing_functions = [handles.data.processing_functions; {handles.data.current_processing_function, strsplit(get(handles.processing_variables,'String'),',')}];
load_handles(handles);
handles.data.data_status = min(2,handles.data.data_status);
guidata(hObject,handles)

% --- Executes on selection change in processing_functions_list.
function processing_functions_list_Callback(hObject, eventdata, handles)
handles.data.current_processing_function_to_delete = get(hObject,'Value');
% Save the handles structure.
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function processing_functions_list_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in remove_processing_function_button.
function remove_processing_function_button_Callback(hObject, eventdata, handles)
if isfield(handles.data, 'current_processing_function_to_delete')
    handles.data.processing_functions(handles.data.current_processing_function_to_delete, :) = [];
    load_handles(handles);
    handles.data.data_status = min(2,handles.data.data_status);
    guidata(hObject,handles)
end


function preprocessing_variables_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function preprocessing_variables_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function epoching_variables_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function epoching_variables_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function processing_variables_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function processing_variables_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function plot_preprocessing_Callback(hObject, eventdata, handles)
    if handles.data.data_status < 1
        handles = run_preprocessing(hObject, handles);
    end
    figure
    plot(handles.data.preprocessed_data);



% --------------------------------------------------------------------
function plot_processing_Callback(hObject, eventdata, handles)
    if handles.data.data_status < 3
        handles = run_processing(hObject, handles);
    end
    figure
    plot(handles.data.processed_data);

% --------------------------------------------------------------------
function plot_epoching_Callback(hObject, eventdata, handles)
    if handles.data.data_status < 2
        handles = run_epoching(hObject, handles);
    end
    figure
    plot(handles.data.epoched_data);


% --- Executes on key press with focus on epoching_variables and none of its controls.
function epoching_variables_KeyPressFcn(hObject, eventdata, handles)
handles.data.data_status = min(1,handles.data.data_status);


% --------------------------------------------------------------------
function run_processing_Callback(hObject, eventdata, handles)
    run_processing(hObject, handles);

% --------------------------------------------------------------------
function run_epoching_Callback(hObject, eventdata, handles)
    run_epoching(hObject, handles);

% --------------------------------------------------------------------
function run_preprocessing_Callback(hObject, eventdata, handles)
    run_preprocessing(hObject, handles);

function [handles] = run_preprocessing(hObject, handles)
    t = 0:1/5:20;
    handles.data.data = sin(2*pi*t*300);
    result = execute_preprocessing(handles);
    handles.data.preprocessed_data = result;
    handles.data.data_status = 1;
    guidata(hObject,handles)

function [handles] = run_epoching(hObject, handles)
    if handles.data.data_status < 1
        handles = run_preprocessing(hObject, handles);
    end
    handles.data.epoched_data = execute_epoching(handles);
    handles.data.data_status = 2;
    guidata(hObject,handles)

function [handles] = run_processing(hObject, handles)
    if handles.data.data_status < 2
        handles = run_epoching(hObject, handles);
    end
    handles.data.processed_data = execute_processing(handles);
    handles.data.data_status = 3;
    guidata(hObject,handles)


% --------------------------------------------------------------------
function load_project_Callback(hObject, eventdata, handles)
[file_name, path] = uigetfile;
if file_name
    handles = load_file( file_name, path, handles);
    load_handles(handles);
    guidata(hObject,handles)
end

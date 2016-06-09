function [ output_args ] = load_handles( handles )
%LOAD_HANDLES Summary of this function goes here
%   Detailed explanation goes here
if isfield(handles.data,'file_name')
    set(handles.project_label, 'String', handles.data.file_name);
end
if isfield(handles.data,'preprocessing_functions')
    if isempty(handles.data.preprocessing_functions)
        set(handles.pre_processing_functions_list,'String',[]);
    else
        set(handles.pre_processing_functions_list,'String',handles.data.preprocessing_functions(:,1));
    end
    set(handles.pre_processing_functions_list,'Value', 1);
end
if isfield(handles.data,'processing_functions')
    if isempty(handles.data.processing_functions)
        set(handles.processing_functions_list,'String',[]);
    else
        set(handles.processing_functions_list,'String',handles.data.processing_functions(:,1));
    end
    set(handles.processing_functions_list,'Value', 1);
end

end


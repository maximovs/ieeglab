function [ output_args ] = load_handles( handles )
%LOAD_HANDLES Summary of this function goes here
%   Detailed explanation goes here
if isfield(handles,'file_name')
    set(handles.project_label, 'String', handles.file_name);
end
if isfield(handles,'preprocessing_functions')
    if isempty(handles.preprocessing_functions)
        set(handles.pre_processing_functions_list,'String',[]);
    else
        set(handles.pre_processing_functions_list,'String',handles.preprocessing_functions(:,1));
    end
    set(handles.pre_processing_functions_list,'Value', 1);
end
if isfield(handles,'processing_functions')
    if isempty(handles.processing_functions)
        set(handles.processing_functions_list,'String',[]);
    else
        set(handles.processing_functions_list,'String',handles.processing_functions(:,1));
    end
    set(handles.processing_functions_list,'Value', 1);
end

end


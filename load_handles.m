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
        set(handles.pre_processing_functions_list,'String', cellfun(@(x) x.str, handles.data.preprocessing_functions, 'UniformOutput', false));
    end
    set(handles.pre_processing_functions_list,'Value', 1);
end
if isfield(handles.data,'processing_functions')
    if isempty(handles.data.processing_functions)
        set(handles.processing_functions_list,'String',[]);
    else
        set(handles.processing_functions_list,'String',cellfun(@(x) x.str, handles.data.processing_functions, 'UniformOutput', false));
    end
    set(handles.processing_functions_list,'Value', 1);
end

end


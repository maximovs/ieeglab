function [ output ] = execute_epoching( handles)
%GET_FIRST_COINCIDENCE Summary of this function goes here
%   Detailed explanation goes here
    addpath('epoching/');
    output = handles.data.preprocessed_data;

    f = str2func(handles.data.epoching_function.str);
    if ~isfield(handles.data.epoching_function,'params')
        input = handles.data.epoching_input{handles.data.epoching_function.pos};
        if ~isempty(input(:,1))
            answer = inputdlg(input(:,1),'Epoching Parameters', 1, input(:,2));
            if ~isempty(answer)
                handles.data.epoching_function.params = answer;
                guidata(handles.epoching_select_menu,handles);
            else
                return
            end
        else
            handles.data.epoching_function.params = {};
            guidata(hObject,handles);
        end
    end
    arguments = handles.data.epoching_function.params;
    if ~isempty([arguments{:}])
        arguments{end+1} = output;
        output = f(arguments{:});
    else
        output = f(output);
    end

end


function [ output ] = execute_epoching( handles)
%GET_FIRST_COINCIDENCE Summary of this function goes here
%   Detailed explanation goes here
    addpath('epoching/');
    output = handles.preprocessed_data;

    f = str2func(handles.epoching_function);
    arguments = strsplit(get(handles.epoching_variables,'String'),',');
    if ~isempty([arguments{:}])
        arguments{end+1} = output;
        output = f(arguments{:});
    else
        output = f(output);
    end

end


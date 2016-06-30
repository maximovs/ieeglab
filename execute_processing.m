function [ output ] = execute_processing( handles)
%GET_FIRST_COINCIDENCE Summary of this function goes here
%   Detailed explanation goes here
    addpath('processing/');
    output = handles.data.epoched_data;
    for i = 1:length(handles.data.processing_functions)
        processing_function = handles.data.processing_functions{i};
        f = str2func(processing_function.str);
        arguments = processing_function.params;
        if ~isempty([arguments{:}])
            arguments{end+1} = output;
            output = f(arguments{:});
        else
            output = f(output);
        end
    end
end


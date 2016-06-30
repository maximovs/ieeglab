function [ output ] = execute_preprocessing( handles)
%GET_FIRST_COINCIDENCE Summary of this function goes here
%   Detailed explanation goes here
    addpath('preprocessing/');
    output = handles.data.data;
    for i = 1:length(handles.data.preprocessing_functions)
        preprocessing_function = handles.data.preprocessing_functions{i};
        f = str2func(preprocessing_function.str);
        arguments = preprocessing_function.params;
        if ~isempty([arguments{:}])
            arguments{end+1} = output;
            output = f(arguments{:});
        else
            output = f(output);
        end
    end
end


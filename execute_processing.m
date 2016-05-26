function [ output ] = execute_processing( handles)
%GET_FIRST_COINCIDENCE Summary of this function goes here
%   Detailed explanation goes here
    addpath('processing/');
    output = handles.epoched_data;
    for i = 1:length(handles.processing_functions(:,1))
        f = str2func([handles.processing_functions{i,1}]);
        arguments = handles.processing_functions{i,2,:};
        if ~isempty([arguments{:}])
            arguments{end+1} = output;
            output = f(arguments{:});
        else
            output = f(output);
        end
    end
end


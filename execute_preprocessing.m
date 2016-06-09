function [ output ] = execute_preprocessing( handles)
%GET_FIRST_COINCIDENCE Summary of this function goes here
%   Detailed explanation goes here
    addpath('preprocessing/');
    output = handles.data.data;
    for i = 1:length(handles.data.preprocessing_functions(:,1))
        f = str2func([handles.data.preprocessing_functions{i,1}]);
        arguments = handles.data.preprocessing_functions{i,2,:};
        if ~isempty([arguments{:}])
            arguments{end+1} = output;
            output = f(arguments{:});
        else
            output = f(output);
        end
    end
end


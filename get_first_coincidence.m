function [ output_args ] = get_first_coincidence( list , str)
%GET_FIRST_COINCIDENCE Summary of this function goes here
%   Detailed explanation goes here
    output_args = 0;
    for i = 1:length(list)
        if strcmp(list(i,1), str)
            output_args = i;
            break;
        end
    end
    
end


function [ str ] = read_file_by_lines( filename )
%READ_FILE_BY_LINES Reads a multilined file and returns a string with the
%file lines.
%   Reads a multilined file and returns a string with the
%   file lines.
    fileID = fopen(filename,'r');
    str = '';
    tline = fgetl(fileID);
    while ischar(tline)
        disp(tline)
        if isequal(str,'')
            str = tline;
        else
            str = [str char(10) tline];
        end
        tline = fgetl(fileID);
    end
    fclose(fileID);

end


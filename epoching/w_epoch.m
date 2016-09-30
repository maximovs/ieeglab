function [ EEG, data ] = w_epoch(epoch_window, base_window,file2save, EEG, data)
types = unique({EEG.event.type});
str = '';
for i=1:length(types)
    if isequal(str,'')
        str = types{i};
    else
        str = [str ' ' types{i}];
    end
end
answer = inputdlg('Types','Types', 1, {str});
if ~isempty(answer)
    types = strsplit(answer{1}, ' ');
end
epoch_window = str2num(epoch_window);
base_window = str2num(base_window);
EEG = pop_epoch(EEG, types, epoch_window, 'newname', '', 'epochinfo', 'yes');

if epoch_window(1) ~= 0
    display('Baseline Removal')
    EEG = pop_rmbase(EEG, base_window);
end

if ~isequal(file2save,'')
    file_to_save = fullfile(data.path, [file2save '.mat']);
    old_data = data;
    data = EEG.data;
    str = ['save ' file_to_save ' data;'];
    eval(str)
    data = old_data;
end
end


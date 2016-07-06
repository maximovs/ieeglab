function [ EEG, data ] = w_preprocess( file_name, notchHz, notchWidth, bandpassRange,bad_chans1, bad_chans2, EEG, data )
%PREPROC Summary of this function goes here
%   Detailed explanation goes here
notchHz = str2num(notchHz);
notchWidth = str2num(notchWidth);
bandpassRange = str2num(bandpassRange);
bad_chans1 = str2num(bad_chans1);
bad_chans2 = str2num(bad_chans2);
% notchHz = [50 100];
% notchWidth = 1;
% bandpassRange = [1 200];

%%

%paso manual para ver qu? canales descartar
% [channels2Discard prechannels2Discard jumps nr_jumps]  = get_channels_to_discard(EEG.data, 200); %bad channels by scripts + markers
%%
% bad_chans2 = []; %bad channels due to epileptic activity + markers
% bad_chans1 = [1 2 7 48 67 73 75 78 79 91 92 93 94 95 96 97 98 99 100 101 105 106 120 121 122 125 127];
% file_name = 'Ignacio2';
labelFileName = [file_name 'labels'];
filteredFileName = [file_name 'filtered'];
referencedFileName = [file_name 'referenced'];
%
channels2Delete = union(bad_chans1,bad_chans2);

[EEG, data] = preprocess(labelFileName,channels2Delete,notchHz,notchWidth,bandpassRange,filteredFileName,referencedFileName, EEG, data);

%To run next step it is necessary to have electrode localization
%PreprocessChannelLocation('Hernandez1_LocalizacionElectrodos.txt',channels2Delete,'Hernandez1_Preprocessed');

display('DONE')

end


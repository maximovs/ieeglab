function [ EEG, data ] = w_erps_diff_2_conditions( condition_1, condition_2, roi_struct_filename, roi_struct_name, files_prefix, tlimits, cycles, frequency_range, alpha, fdr_correct, weighted_significance, surroundings_weight, scale, basenorm, tlimits_for_baseline, erps_max, mark_times, path_to_save, EEG, data )

%CONDITION SELECTION!!!!!! - AC� TENGO QUE ELEGIR LOS TRIALS QUE INCLUYO
%BASADO EN LOS REMARCADOS ----- COMO HACEMOS PARA TENER ESTO???
% load 'Faces.mat'
% cond1 = data;
% load 'Words.mat'
% cond2 = data;

% condition_1 = 'Faces';
% condition_2 = 'Words';

% files_prefix = 'P9';

if isequal(path_to_save,'')
    path_to_save = fullfile(data.path, 'ERPS', 'FFTComplete');
end
% roi_struct = load('ERPS\DVT_P9_Anatomic.mat');

f = load(fullfile(data.path,'ERPS',roi_struct_filename), roi_struct_name);
roi_struct = f.(roi_struct_name);

tlimits = str2num(tlimits);%[-250 1000];
cycles = str2num(cycles);%0; %FFT
frequency_range = str2num(frequency_range);%[0 150];
alpha = str2num(alpha);%0.05;
fdr_correct = str2num(fdr_correct);%0;
%si quiero reduccion de significancia = 1 sino = 0;
weighted_significance = str2num(weighted_significance);%0;
surroundings_weight = str2num(surroundings_weight);%0.5;
% scale = 'abs';
basenorm = str2num(basenorm);%1; % 0: divisive baseline; 1: standard deviation
tlimits_for_baseline = str2num(tlimits_for_baseline);%[-250 0];
erps_max = str2num(erps_max);%[-15 15];
mark_times = str2num(mark_times);%[];

%----RUN-------------------------------------------------------------------

% eeglab %NO SE SI ES NECESARIO
plot_ERPS_for_2_conditions_and_difference(condition_1,condition_2,files_prefix, path_to_save,roi_struct,tlimits,cycles,frequency_range,alpha,fdr_correct,weighted_significance,surroundings_weight,scale,tlimits_for_baseline,basenorm,erps_max,mark_times, EEG, data)

display('DONE Faces and Words')
close all

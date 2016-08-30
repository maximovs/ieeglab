function [EEG, data] = w_process_erps(cycles, frequencyRange, alpha, scale, basenorm, tlimits, tlimitsForBaseline, fdrCorrect, weightedSignificance, surroundingsWeight, erpsmax, marktimes, roi_struct_filename, title_name_prefix, EEG, data)
epoched_EEG = EEG;
if isfield(data,'selected_epoched_EEG')
    epoched_EEG = data.selected_epoched_EEG;
end
% tlimits = str2num(tlimits); %time limits in ms
% frequencyRange = str2num(frequencyRange);
% alpha = str2num(alpha);
% 
% %si quiero false detection rate correction = 1 sino = 0;
% fdrCorrect = str2num(fdrCorrect);
% %si quiero reduccion de significancia = 1 sino = 0;
% weightedSignificance = str2num(weightedSignificance);
% surroundingsWeight = str2num(surroundingsWeight);
% load([data.path empathy_for_pain])
% baseline = str2num(baseline);

path2save = fullfile(data.path,'ERPS2');
cycles = str2num(cycles); %FFT
%cycles = [3 0.5]; %para usar wavelets
frequencyRange = str2num(frequencyRange);
%alpha = 0.05;
alpha = str2num(alpha);
basenorm = str2num(basenorm); % 0: divisive baseline; 1: standard deviation
tlimits = str2num(tlimits);
tlimitsForBaseline = str2num(tlimitsForBaseline);
 
%si quiero false detection rate correction = 1 sino = 0;
fdrCorrect = str2num(fdrCorrect);
%si quiero reduccion de significancia = 1 sino = 0;
weightedSignificance = str2num(weightedSignificance);
surroundingsWeight = str2num(surroundingsWeight);

%erpsmaxForTipo = [4 4 4 3 3 3 3 3 3];
erpsmax = str2num(erpsmax);
marktimes = str2num(marktimes);

load(fullfile(data.path,'ERPS',roi_struct_filename));
roiStruct = DVT_P10_Anatomic(1);



titleName = [path2save title_name_prefix];
[erpsMapsByTrialByROIs,erpsByROIs, meanERPSMap, R, Pboot, Rboot, ERP, freqs, timesout, mbase, maskersp, maskitc, g,Pboottrials] = PlotERPSByROI2(roiStruct,EEG,tlimits,cycles,frequencyRange,alpha,fdrCorrect,titleName,weightedSignificance,surroundingsWeight,scale,tlimitsForBaseline,basenorm,erpsmax,marktimes);        

eval(['save ' path2save title_name_prefix 'ERPS_Complete.mat erpsMapsByTrialByROIs erpsByROIs']);
eval(['save ' path2save title_name_prefix 'ERPSOutputs_Complete.mat freqs timesout mbase g']);

display('DONE')
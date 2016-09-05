function plot_ERPS_for_2_conditions_and_difference(condition_1,condition_2, files_prefix, path_to_save,roi_struct,tlimits,cycles,frequency_range,alpha,fdr_correct,weighted_significance,surroundings_weight,scale,tlimits_for_baseline,basenorm,erps_max,mark_times, EEG, data)
%Calculates ERPS for three conditions and saves to output files.
%Then calculates ERPS difference between all combinations of the three
%conditions (1 vs 2, 1 vs 3 and 2 vs 3).

%INPUTS:
%fileName: name of .set file
%filePath: path to the .set file

%cond1: 3D matrix of condition 1: freq x times x trials (of condition1
%            only)
%cond2: 3D matrix of condition 2: freq x times x trials (of condition2
%            only)
%cond3: 3D matrix of condition 3: freq x times x trials (of condition3
%            only)
%condname1: string - name of condition 1
%condname2: string - name of condition 2
%condname3: string - name of condition 3

%prefix2save: string - prefix that will be appended to the condition and
%                     type of comparison as file name

%path2save: string - path where files will be saved
%roiStruct: struct of anatomic rois
%frequency analysis inputs:
%tlimits: vector of 2 values that indicate epoch temporal value in ms
%cycles: if wavelet analysis is to be used - vector of two values, e.g. [3
%           0.5]; if FFT is to be used then assign 0.
%frequencyRange: vector of two values that indicate lowest frequency and
%                           highest frequency values of the range to be considered, e.g. [1 150]
%alpha: statistical significance value to be considered, e.g. p = 0.01. If
%           p = 0 no statistical analysis will be performed
%fdrCorrect: 1: for false detection rate to be used, 0: no to perform false
%                  detection rate
%weightedSignificance: 0: if no weighted significance is to be used, 1: if
%                                   it will be used
%surroundingsWeight: weight of surrounding significance to be considered
%                                 (only valid if weightedSignificance = 1)
%scale: string - 'abs' for absolute scale, 'log' for logarithmic scale
%tlimitsForBaseline: vector of two values that indicate time limits in ms for
%                               baseline, e.g. [-500 0]
%basenorm: type of basenormalization 0: divisive baseline; 1:standard deviation
%erpsmax: vector of limits in colormap, e.g. [-15 15]
%marktimes: vector with times that showed be marked in plot

%OUTPUTS:
%files with the time frequency calculation for the three conditions, the
%figures and the comparison of every combination of pairs of conditions

%eeglab needs to be loaded already

%Condition1
%load EEGs
EEG_condition_1 = filter_epochs(condition_1, EEG, data);
EEG_condition_2 = filter_epochs(condition_2, EEG, data);


%calculate ERPS
% titleName = [path_to_save files_prefix '-' condition_1];
titleName = fullfile(path_to_save, [files_prefix '-' condition_1]);
[erpsMapsByTrialByROIsCond1,erpsByROIsCond1, meanERPSMapCond1, RCond1, PbootCond1, RbootCond1, ERPCond1, freqsCond1, timesoutCond1, mbaseCond1, maskerspCond1, maskitcCond1, gCond1,PboottrialsCond1] = plot_ERPS_by_ROI_2(roi_struct,EEG_condition_1,tlimits,cycles,frequency_range,alpha,fdr_correct,titleName,weighted_significance,surroundings_weight,scale,tlimits_for_baseline,basenorm,erps_max,mark_times);
%save outputs
eval(['save ' titleName 'ERPS.mat erpsMapsByTrialByROIsCond1 erpsByROIsCond1']);
eval(['save ' titleName 'ERPSOutputs.mat freqsCond1 timesoutCond1 mbaseCond1 gCond1']); 

%calculate ERPS
% titleName = [path_to_save files_prefix '-' condname2];
titleName = fullfile(path_to_save, [files_prefix '-' condition_2]);
[erpsMapsByTrialByROIsCond2,erpsByROIsCond2, meanERPSMapCond2, RCond2, PbootCond2, RbootCond2, ERPCond2, freqsCond2, timesoutCond2, mbaseCond2, maskerspCond2, maskitcCond2, gCond2,PboottrialsCond2] = plot_ERPS_by_ROI_2(roi_struct,EEG_condition_2,tlimits,cycles,frequency_range,alpha,fdr_correct,titleName,weighted_significance,surroundings_weight,scale,tlimits_for_baseline,basenorm,erps_max,mark_times);        

eval(['save ' titleName 'ERPS.mat erpsMapsByTrialByROIsCond2 erpsByROIsCond2']);   
eval(['save ' titleName 'ERPSOutputs.mat freqsCond2 timesoutCond2 mbaseCond2 gCond2']); 

%Diff
% file_2_save = [files_prefix '-' condname1 '-' condname2];
file_2_save = fullfile(path_to_save, [files_prefix '-' condition_1 '-' condition_2]);
PlotERPSForDiffConditions(erpsByROIsCond1,erpsByROIsCond2,file_2_save,path_to_save,gCond2,PbootCond2,ERPCond2,mbaseCond2,freqsCond2,timesoutCond2,roi_struct);
                          
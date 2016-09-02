function [ EEG, data ] = w_plot_average_erps_band( condition_1, condition_2, roi_struct_filename, tf_maps_filename, tf_variables_filename, frequency_bands, title_names, p_value, colorPvalue, color1, color2, statmethod, prefix_file_name, EEG, data )
% addpath(genpath('C:\Program Files\MATLAB\R2010a\toolbox\stats'))

% w_ PARAMETERS
roi_struct_filename = 'EmpathyForPain_P9_Bipolar.mat';
tf_maps_filename = 'RetentionFacesInputsNewFFTBaseline.mat'; %Calculated time frequency charts from other function (w_process_erps)
tf_variables_filename = 'ERPS\NEWFFT_baseline\Retention_Faceserps.mat'; % Calculted parameters from time frequency analysis from other function (w_process_erps)

frequency_bands = [1 4; 4 8; 8 13; 13 30; 30 45; 45 80; 80 150];
title_names = {'delta','theta','alpha','beta','lowgamma','highgamma','broadband'};

%FUNCTION PARAMETERS
condition_1 = 'Binding';
condition_2 = 'Features';

p_value = 0.05;
colorPvalue = 'g';
color1 = [1 0 0]; %red         
color2 = [0 0 1]; %blue  

% prefixFileName = 'G:\Ineco Transicion\Procesamiento de Señales\Resultados\Paciente9_AlfredoFarinelli\Integracion\CollapsedERPS\NewFFT0.05\';
if isequal(prefix_file_name,'')
    prefix_file_name = data.path;
end
statmethod = 'boot';

%----------RUN------------------------------------------------------------
roi_struct = load(roi_struct_filename); 

%loads erpsMapsByTrialByROIs erpsByROIs from calculated time frequency charts from other function (w_process_erps)
load(tf_maps_filename)  

%loads freqs timesout mbase g from calculted parameters from time frequency analysis from other function (w_process_erps)
load(tf_variables_filename) 

%CONDITION SELECTION!!!!!! - ACÁ TENGO QUE ELEGIR LOS TRIALS QUE INCLUYO
%BASADO EN LOS REMARCADOS ----- COMO HACEMOS PARA TENER ESTO???
totalERPSBinding = erps.Binding.erpsMapsByTrialByROIs;
totalERPSFeatures = erps.Features.erpsMapsByTrialByROIs;

roiNr  = size(roi_struct,2);
%epochLine = -4200;
for i = 1 : roiNr

    nr = roi_struct(i).channels;
    roiERPSBinding = totalERPSBinding(nr).erpsByTrial;
    roiERPSFeatures = totalERPSFeatures(nr).erpsByTrial;
    
    for f = 1 : size(frequency_bands,1)    
        
        cond1mat = roiERPSBinding(1:4,:,:);
        cond2mat = roiERPSFeatures(1:4,:,:);

        titleName = [title_names{f} '-' roi_struct(i).name];
        PlotCollapsedERPSBySubject(cond1mat,cond2mat,condition_1,condition_2,timesout,statmethod,p_value,prefix_file_name,titleName,color1,color2,colorPvalue);

%         yL = get(gca,'YLim');
%         line([epochLine epochLine],yL,'Color','m','LineWidth', 2,'LineStyle','-');
    end
end

display('DONE')


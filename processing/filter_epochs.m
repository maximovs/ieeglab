function result_EEG = filter_epochs(epochs, EEG, data)
results = calculate_epochs_mask(epochs, EEG, data);
EEG.data = EEG.data(:,:,results);
EEG.epoch = EEG.epoch(results);
result_EEG = EEG;
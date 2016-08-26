function result_EEG = filter_epochs(epochs, EEG, data)
results = 0;
for i = 1:length(epochs(1,:))
    epoch = epochs(i,:);
    mask = arrayfun(@(x)strcmp(x, epoch), {EEG.epoch.eventtype});
    results = results | mask;
end
EEG.data = EEG.data(:,:,results);
EEG.epoch = EEG.epoch(results);
result_EEG = EEG;
EEaux = 1;
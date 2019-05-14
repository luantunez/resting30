addpath('C:\Users\lucía\Documents\eeglab14_1_1b')
eeglab;

ppal = 'direccion ppal';
filepathIN  = 'C:\Users\lucía\Dropbox\datosFiltrados\';
        
for i=1:1:34
    if i ~= 18 && i ~= 28 && i ~= 30
        NOMBRE=['s',num2str(i)];

        EEG = pop_loadset('filename',[NOMBRE,'_ICA_removed.set'], 'filepath', filepathIN);
        EEG = eeg_checkset( EEG );

        datos=EEG.data;
        times =EEG.times;
        save(['D:\EEG\matrices\s',num2str(i)],'datos','times')
    end

end
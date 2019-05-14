addpath('C:\Users\lucía\Documents\eeglab14_1_1b')
eeglab;

ppal = 'direccion ppal';
filepathIN  = 'D:\EEG\resting48hs\datosFiltrados\ICA2\';
        
%for i=1:1:23
    %if i ~= 18 && i ~= 28 && i ~= 30
    i=2
    
        NOMBRE=['s',num2str(i)];

        EEG = pop_loadset('filename',[NOMBRE,'_ICA_removed.set'], 'filepath', filepathIN);
        EEG = eeg_checkset( EEG );

        datos=EEG.data;
        times =EEG.times;
        save(['D:\EEG\resting48hs\datosMAT\s',num2str(i)],'datos','times')
    %end

%end
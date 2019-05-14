
% Abrir los datos como txt
close all
clear all
clc

    fileIn        =   'D:\EEG\resting48hs\datosTXT\faltantes\';
    fileOut       =   'D:\EEG\resting48hs\datosSET\';
    addpath('C:\Users\lucía\Documents\eeglab14_1_1b\');
    eeglab
    localizacion  = 'D:\EEG\resting48hs\info\30locations.xyz';


nombre        = 'mdp-02112017';
suj='s23';

freq          = 256;
Externo       = 1; %Puede der 1 o  2


%% Levanta los datos
EEG         = pop_importdata('dataformat','ascii','nbchan',0,'data',[fileIn,nombre,'.TXT'],'srate',freq,'pnts',0,'xmin',0);
EEG.setname = nombre;
EEG         = eeg_checkset( EEG );
ChExt       = EEG.data(19+Externo,:);
tiempos     = (1:size(EEG.data,2))*1/freq;

%% saca los canales externos

EEG = pop_select( EEG,'channel',[1:19 22:32] );
EEG = eeg_checkset( EEG );


% EEG.event.matriz = matriz;
% guarda localizaciÃ³n de canales
EEG=pop_chanedit(EEG, 'load',{ localizacion 'filetype' 'autodetect'});
EEG = eeg_checkset( EEG );
% Guarda los datos como .set
EEG = pop_saveset( EEG, 'filename',[suj,'.set'],'filepath',fileOut);
EEG = eeg_checkset( EEG );
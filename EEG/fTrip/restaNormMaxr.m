clear all
close all

i=6

if i==1
    banda=1;
    colorBar=[0 0.6]
elseif i==2
    banda=2;
    colorBar=[0 0.3]
elseif i==3
    banda=3;
    colorBar=[0 0.4]
elseif i==4
    banda=4;
    colorBar=[0 0.35]
elseif i==5
    banda=5;
    colorBar=[-0.2 0.2]
elseif i==6
    banda=6;
    colorBar=[0 0.5]
end
    
sujField=load(['F:\pasantías Luchi\resting\tppltEEGlabFieldtrip\fieldtrip',num2str(banda)]);
sujField=sujField.totNomNorm;

sujEeg=load(['F:\pasantías Luchi\resting\tppltEEGlabFieldtrip\eeglab',num2str(banda)]);
sujEeg=sujEeg.pmedioTotNorm;

resta=sujEeg-sujField;  %al reves me dan negativos

maxResta=max(resta)
minResta=min(resta)

%%

addpath('C:\Users\lucía\Documents\eeglab14_1_1b');
eeglab;

NOMBRE='s1';

ppal = 'direccion ppal';

filepathIN  = 'C:\Users\lucía\Dropbox\datos\';

EEG = pop_loadset('filename',[NOMBRE,'.set'], 'filepath', filepathIN);
EEG = eeg_checkset( EEG );
localizacion=EEG.chanlocs;


figure();
topoplot(resta',localizacion,'maplimits',colorBar);

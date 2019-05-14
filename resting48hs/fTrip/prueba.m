clear all
close all

addpath('C:\Users\lucía\Documents\eeglab14_1_1b')
eeglab;

ppal = 'direccion ppal';
filepathIN  = 'D:\EEG\resting48hs\datosFiltrados\ICA2\';

i=1;             
        NOMBRE=['s',num2str(i)];

        EEG = pop_loadset('filename',[NOMBRE,'_ICA_removed.set'], 'filepath', filepathIN);
        EEG = eeg_checkset( EEG );

        data=eeglab2fieldtrip(EEG, 'preprocessing');
         
rmpath('C:\Users\lucía\Documents\eeglab14_1_1b');

addpath C:\Users\lucía\Documents\MATLAB\fieldtrip-20180815
%ft_defaults;
%fieldtrip;

%%

%[data] = ft_preprocessing(suj.cfg, suj)

%[data] = ft_mvaranalysis(data.cfg, data)
 
% 
 %data.cfg.method='channel';
% data.cfg.statistic='indepsamplesT'; 
% data.cfg.numrandomization ='all'
% data.cfg.taper='dpss';
% data.cfg.design=size(data.trial);

%%

%  [timelock] = ft_timelockanalysis(data.cfg,data)  
% 
%  timelock.cfg.method='montecarlo';
% 
% %[grandavg] = ft_timelockgrandaverage(timelock.cfg, timelock)
% 
% timelock.cfg.statistic   = 'indepsamplesT'   
% 
% timelock.cfg.numrandomization = 'all';
% 
% Nsub=88064;
%  
% timelock.cfg.design(1,1:2*Nsub)  = [ones(1,Nsub) 2*ones(1,Nsub)];
% %timelock.cfg.design(2,1:2*Nsub)  = [1:Nsub 1:Nsub];
% timelock.cfg.ivar                = 1; % the 1st row in cfg.design contains the independent variable
% %timelock.cfg.uvar                = 2; % the 2nd row in cfg.design contains the subject number
%  
% %stat = ft_timelockstatistics(cfg,allsubjFIC{:},allsubjFC{:})
% 
% [stat] = ft_timelockstatistics(timelock.cfg,timelock);

%%

%data.cfg.taper='dpss';
%data.cfg.design=size(data.trial);

%global polyorder 
%polyorder=data.cfg.polyorder;

%%especificar en  ft_specest_mtmfft polyorder=2 %buscar como: esto agregaría porque no e lo sabe leer

data.cfg.method='mtmfft';
data.cfg.taper='hanning';
data.cfg.foi=1:2:30;    %ventanas de frecuencia
data.cfg.toi=1:0.5:343;  %ventanas de tiempo (Centro de la ventana):  desde 1 hata 343 segundos(el tiempo final segun 88064 numero de mustras) con pasos de a 2 segundos segun el avance de ejeX
data.cfg.t_ftimwin = ones(size(data.cfg.toi));  %length of time window (in seconds) -> 1 segundo cada ventana para que se superpongan ->ventanas de 1 segundo co pasos de 0.5
data.cfg.tapsmofrq = 0.4; %number, the amount of spectral smoothing through multi-tapering

[freq] = ft_freqanalysis(data.cfg, data);
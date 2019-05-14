clear all
close all

addpath('C:\Users\lucía\Documents\eeglab14_1_1b')
eeglab;

%% levanto los datos de excel

 nombre=xlsread('C:\EEG\pasantias\compRest48.xlsx', 'C3:C25');  %levanto datos de excel
 nombre(17)=nan;    %falta suj 17 tal
 definicion=xlsread('C:\EEG\pasantias\compRest48.xlsx', 'D3:D25');
 definicion(17)=nan;    %falta suj 17 tal
 
%% divido en buenos y malos aprendedores para nombres y definiciones

nombreMedia=nombre;
definicionMedia=definicion;

%para hacer el promedio:
nombreMedia([17 3 14 16 18 15])=[];
definicionMedia([17 3 14 16 18 15])=[];

medNom=median(nombreMedia);  %para nombre
medDef=median(definicionMedia);  %para definicion

%despues de hacer la mediana vuelvo a levatar para que me queden ordenados

 nombre([17 3 14 16 18 15])=nan;    %falta suj 17 tal
 definicion([17 3 14 16 18 15])=nan;    %falta suj 17 tal

sujBuenosNom=[];   %inicializo
numSujBuenosNom=[];
sujMalosNom=[];
numSujMalosNom=[];
sujBuenosDef=[];
numSujBuenosDef=[];
sujMalosDef=[];
numSujMalosDef=[];


ppal = 'direccion ppal';
filepathIN  = 'D:\EEG\resting48hs\datosFiltrados\ICA2\';

%guardo sujetos divididos en buenos y malos aprendedores de nombres y
%definiciones

for i=1:23     
     if i~=3 && i ~= 14 && i ~= 16 && i ~= 18  && i ~= 15 && i~=17    %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es igual a alguno no entra                 
             
        NOMBRE=['s',num2str(i)];

        EEG = pop_loadset('filename',[NOMBRE,'_ICA_removed.set'], 'filepath', filepathIN);
        EEG = eeg_checkset( EEG );

        suj=eeglab2fieldtrip(EEG, 'preprocessing', 'none')
         
        if nombre(i)>medNom            %para nombre
            save(['D:\EEG\resting48hs\datosFieldtrip\sujBuenosNom\s',num2str(i)], 'suj');
        elseif nombre(i)<=medNom 
           save(['D:\EEG\resting48hs\datosFieldtrip\sujMalosNom\s',num2str(i)], 'suj');
        end

        if definicion(i)>medDef        %para definicion
            save(['D:\EEG\resting48hs\datosFieldtrip\sujBuenosDef\s',num2str(i)], 'suj');
        elseif definicion(i)<=medDef    
            save(['D:\EEG\resting48hs\datosFieldtrip\sujMalosDef\s',num2str(i)]', 'suj');
        end         
     end
end

close all

addpath C:\Users\lucía\Documents\MATLAB\fieldtrip-20180815
ft_defaults;
%fieldtrip;

%%

[data] = ft_preprocessing(suj.cfg, suj)
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
data.cfg.tapsmofrq = data.cfg.foi*0.4; %number, the amount of spectral smoothing through multi-tapering

[freq] = ft_freqanalysis(data.cfg, data);


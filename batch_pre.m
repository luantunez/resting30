
close all; clear all; clc
%addpath('/home/usuario/matlab/eeglab13_5_4b')

      
 addpath ('C:\Users\Usuario\Documents\MATLAB\eeglab13_5_4b')%compu lab
eeglab

sujname = 'clh';

%% Datos continuos
% clear all
close all
EEG = preanalisis_lab(sujname,'1'); % Open BDF, delete unsued channels, and save as SET

%% Mirar los datos y decidir que canales sacars08
eeglab redraw;
figure; 
    pop_eegplot( EEG, 1, 1, 1);
figure; 
    pop_spectopo(EEG, 1, [EEG.xmin EEG.xmax], 'EEG' , 'percent', 15, 'freqrange',[1 60],'electrodes','off');

%% Datos continuos
% clear all
close all; clc
EEG = preanalisis_lab(sujname,'2'); % Interpolate


%% Datos en epocas
% clear all

close all

for co=1:4                 
   EEG = preanalisis_lab(sujname,'3',co); % cortar
end

%% Limpia datos por máximo
% clear all
close all

for co=1:4                 
   EEG = preanalisis_lab(sujname,'4',co); % cortar
end
%% Limpia datos por ica
% calcula ICA
% correr de a uno
               
EEG = preanalisis_lab(sujname,'5',1); % cortar1
%%
clc
EEG = preanalisis_lab(sujname,'5',2); % cortar

%%
clc
EEG = preanalisis_lab(sujname,'5',3); % cortar
%%
clc
EEG = preanalisis_lab(sujname,'5',4); % cortar
%%
% remueve icas
close all

for co=1:4                 
   EEG =preanalisis_lab(sujname,'6',co); % cortar
end

%%
disp('termino')


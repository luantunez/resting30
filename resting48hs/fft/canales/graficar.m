close all
clear all
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');

%% Saco la mínima dimensión de tiempos (del sujeto registrado durante menos tiempo)



FRANGE=[1:0.2:3];  %delta
%FRANGE=[4:0.2:8];  %theta
%FRANGE=[8:0.2:12]; %alfa
%FRANGE=[12:1:35]; %beta
%FRANGE=[12:0.5:22]; %beta1
%FRANGE=[22:0.5:35]; %beta2
%FRANGE=[1:1:35]; %total

largos=zeros(1,34);

for i=1:34
     if i ~= 18 && i ~= 28 && i ~= 30    %los sujetos que no sirven, si es distinto de estos, guardar el largo, sino poer un valor alto, no sirven
        load(['D:\EEG\resting48hs\fft\total\RhoNorm\s',num2str(i),'.mat']); 
        largos(i)=length(RhoP);
     else
         largos(i)=nan; %a estos, que no sirven, les asigno un valor largo
     end
end

[largoMin,sujetoMin]=min(largos);

%% Saco  el promedio de los RhoP de todos los canales para todos los sujetos en el tiempo min 



suj=zeros(30,largoMin,length(FRANGE));

for i=1:34
    if i ~=18 && i ~= 28 && i ~= 30   %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es iguala a alguno no entra
        load(['D:\EEG\resting48hs\fft\total\RhoNorm\s',num2str(i),'.mat']); 
        %pmedioCh=mean(RhoP,1);  %promedio de todos los canales para cada sujeto;

        RhoP=RhoP(:,1:largoMin,:);  %me quedo hasta el tiempo del sujeto mas corto
        pmedioCh=mean(RhoP,3); %promedio en frecuencias
        pmedioCh=mean(pmedioCh,2); %promedio en tiempos
        pmedioCh=mean(pmedioCh,1); %promedio en canales
        pmedioCh=squeeze(pmedioCh);
        sujNorm=RhoP/pmedioCh; %normalizo cada sujeto respecto a si mismo
        
        suj=suj+sujNorm; %sumo todos los sujetos

    end
end

suj=suj/31; %divido por la cantidad de sujetos -> tengo promedio de todos los sujetos
suj=squeeze(suj);

suj=mean(suj,3); %promedio en frecuencias
suj=mean(suj,2); %promedio en tiempos
%suj=mean(suj,1); %promedio en canales
% pmedioTot=squeeze(pmedioTot);
% suj=suj/pmedioTot; %normalizo total de sujetos
suj=squeeze(suj);



%% Grafico el promedio

addpath('C:\Users\lucía\Documents\eeglab14_1_1b');
eeglab;

NOMBRE='s1';

ppal = 'direccion ppal';

filepathIN  = 'C:\Users\lucía\Dropbox\datos\';

EEG = pop_loadset('filename',[NOMBRE,'.set'], 'filepath', filepathIN);
EEG = eeg_checkset( EEG );
localizacion=EEG.chanlocs;

%colorBar=[0 1.4]; %delta
%colorBar=[0 1.4]; %theta
%colorBar=[0 1.4]; %alfa
%colorBar=[0 1.4]; %beta
%colorBar=[0 1.4]; %beta1
%colorBar=[0 1.4]; %beta2
colorBar=[0 1.3]; %total

figure();
topoplot(suj',localizacion,'maplimits',colorBar);
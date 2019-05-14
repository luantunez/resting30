close all
clear all
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');

%%

banda=2;

    if(banda==1) %delta
        frec='delta';
        FRANGE=[1:0.2:3];
        direc='F:\pasantías Luchi\resting48hs\fft\delta\RhoNorm\s';
        colorBar=[2 3.8];
    elseif(banda==2) %theta
         frec='theta';
        FRANGE=[4:0.2:8];
        direc='F:\pasantías Luchi\resting48hs\fft\theta\RhoNorm\s';
        colorBar=[1 1.7]; 
    elseif(banda==3) %alfa
        frec='alfa';
        FRANGE=[8:0.2:12];
        direc='F:\pasantías Luchi\resting48hs\fft\alfa\RhoNorm\s';
        colorBar=[0.8 1.8]; 
    elseif(banda==4) %beta
        frec='beta';
        FRANGE=[12:1:35];
        direc='F:\pasantías Luchi\resting48hs\fft\beta\RhoNorm\s';
        colorBar=[0.45 0.65];
    elseif(banda==5) %beta1
         frec='beta1';
        FRANGE=[12:0.5:22];
        direc='F:\pasantías Luchi\resting48hs\fft\beta1\RhoNorm\s';
        colorBar=[0.6 0.9];
    elseif(banda==6) %beta2
         frec='beta2';
        FRANGE=[22:0.5:35];
        direc='F:\pasantías Luchi\resting48hs\fft\beta2\RhoNorm\s';
        colorBar=[0.33 0.45];
    elseif(banda==7) %total
         frec='total';
        FRANGE=[1:1:35];
        direc='F:\pasantías Luchi\resting48hs\fft\total\RhoNorm\s';
        colorBar=[0.75 1.05];
    elseif banda==8
        FRANGE=[4:1:35]; %totalCut
        direc='F:\pasantías Luchi\resting48hs\fft\totalCut\RhoNorm\s';
        colorBar=[0.6 0.87];
    end  
    
%% Saco  el promedio de los RhoP de todos los canales para todos los sujetos en el tiempo min 

total=[];

for i=1:23
    if i ~=3 && i ~= 14 && i ~= 16 && i ~= 18  && i ~= 15   %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es iguala a alguno no entra
        load([direc,num2str(i),'.mat']); 
        sujP=mean(Rho,3); %promedio en frecuencias
        sujP=mean(sujP,2); %promedio en tiempos
        sujP=squeeze(sujP);
        total=[total sujP]; %(:,1:largoMin,:);
    end
end

pmedioTot=squeeze(mean(total,2)); %promedio en sujetos (se pusieron como columnas)


%% Grafico el promedio

addpath('C:\Users\lucía\Documents\eeglab14_1_1b');
eeglab;

NOMBRE='s1';

ppal = 'direccion ppal';

filepathIN  = 'C:\Users\lucía\Dropbox\datos\';

EEG = pop_loadset('filename',[NOMBRE,'.set'], 'filepath', filepathIN);
EEG = eeg_checkset( EEG );
localizacion=EEG.chanlocs;


figure();
topoplot(pmedioTot',localizacion,'maplimits',colorBar);
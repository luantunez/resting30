close all
clear all
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');

%%

banda=7;

    if(banda==1) %delta
        frec='delta';
        FRANGE=[1:0.2:3];
        direc='D:\EEG\resting48hs\fft\delta\RhoNorm\s';
        colorBar=[2 3.8];
        colorBar=[0.4 1];
    elseif(banda==2) %theta
         frec='theta';
        FRANGE=[4:0.2:8];
        direc='D:\EEG\resting48hs\fft\theta\RhoNorm\s';
        colorBar=[1 1.7]; 
        colorBar=[0.4 1];
    elseif(banda==3) %alfa
        frec='alfa';
        FRANGE=[8:0.2:12];
        direc='D:\EEG\resting48hs\fft\alfa\RhoNorm\s';
        colorBar=[0.8 1.8]; 
        colorBar=[0.4 1];
    elseif(banda==4) %beta1
         frec='beta1';
        FRANGE=[12:0.5:22];
        direc='D:\EEG\resting48hs\fft\beta1\RhoNorm\s';
        colorBar=[0.6 0.9];
        colorBar=[0.4 1];
    elseif(banda==5) %beta2
         frec='beta2';
        FRANGE=[22:0.5:35];
        direc='D:\EEG\resting48hs\fft\beta2\RhoNorm\s';
        colorBar=[0.33 0.45];
        colorBar=[0.4 1.1];
        colorBar=[0.6 1];
    elseif(banda==6) %total
         frec='total';
        FRANGE=[1:1:35];
        direc='D:\EEG\resting48hs\fft\total\Rho\s';
        colorBar=[100 160];
        colorBar= [0.4 1.1];
        colorBar=[0.5 1];
    elseif banda==7
        FRANGE=[4:1:35]; %totalCut
        direc='D:\EEG\resting48hs\fft\totalCut\RhoNorm\s';
        colorBar=[0.6 0.87];
        colorBar= [0.4 1.1];
        colorBar=[0.5 1];
    end
    
    
 %colorBar=[ 0 1 ];  %%%
    
%% Saco  el promedio de los RhoP de todos los canales para todos los sujetos en el tiempo min 

total=[];

for i=1:23
    if i ~=3 && i ~= 14 && i ~= 16 && i ~= 18  && i ~= 15 && i~=17 && i~=10  %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es iguala a alguno no entra
        load([direc,num2str(i),'.mat']); 
        
        Rho=Rho(:,1:495,:); %lo corto hasta el minimo
        
        sujP=mean(Rho,3); %promedio en frecuencias
        sujP=mean(sujP,2); %promedio en tiempos
        sujP=squeeze(sujP);
        total=[total sujP]; %(:,1:largoMin,:);
    end
end

pmedioTot=squeeze(mean(total,2)); %promedio en sujetos (se pusieron como columnas)

maxE=max(pmedioTot);

pmedioTotNorm=pmedioTot/maxE;


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
topoplot(pmedioTotNorm',localizacion,'maplimits',colorBar);


save(['D:\EEG\resting48hs\tppltEEGlabFieldtrip\eeglab',num2str(banda)],'pmedioTotNorm');
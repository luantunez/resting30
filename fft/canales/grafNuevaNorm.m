close all
clear all
addpath('C:\Users\luc�a\Documents\MATLAB\EEG\EEG2\fft');

%% Saco la m�nima dimensi�n de tiempos (del sujeto registrado durante menos tiempo)

banda=6;   

    if(banda==1) %delta
        frec='delta';
        FRANGE=[1:0.2:3];
        direc='F:\pasant�as Luchi\resting\fft\bandas\delta\sujNormTot\s';
        %colorBar=[0 3.8];
        colorBar=[2 3]; %nueva
        %colorBar=[2 3.8]; %misma ROI 48
    elseif(banda==2) %theta
         frec='theta';
        FRANGE=[4:0.2:8];
        direc='F:\pasant�as Luchi\resting\fft\bandas\theta\sujNormTot\s';
        %colorBar=[0 2]; 
        colorBar=[1 1.7]; %nueva
        %colorBar=[1 1.7]; %misma ROI 48
    elseif(banda==3) %alfa
        frec='alfa';
        FRANGE=[8:0.2:12];
        direc='F:\pasant�as Luchi\resting\fft\bandas\alfa\sujNormTot\s';
        %colorBar=[0 2.7]; 
        colorBar=[1.3 2.3]; %nueva
        %colorBar=[0.8 1.8];%misma ROI 48
    elseif(banda==4) %beta
        frec='beta';
        FRANGE=[12:1:35];
        direc='F:\pasant�as Luchi\resting\fft\bandas\beta\sujNormTot\s';
        %colorBar=[0 0.75];
        colorBar=[0.4 0.6]; %nueva
        %colorBar=[0.45 0.65]; %misma ROI 48
    elseif(banda==5) %beta1
         frec='beta1';
        FRANGE=[12:0.5:22];
        direc='F:\pasant�as Luchi\resting\fft\bandas\beta1\sujNormTot\s';
        %colorBar=[0 1.1];
        colorBar=[0.6 0.9]; %nueva
        %colorBar=[0.6 0.9]; %misma ROI 48
    elseif(banda==6) %beta2
         frec='beta2';
        FRANGE=[22:0.5:35];
        direc='F:\pasant�as Luchi\resting\fft\bandas\beta2\sujNormTot\s';
        %colorBar=[0 0.48];
        colorBar=[0.28 0.38]; %nueva
        %colorBar=[0.33 0.45]; %misma ROI 48
    elseif(banda==7) %total
         frec='total';
        FRANGE=[1:1:35];
        direc='F:\pasant�as Luchi\resting\fft\bandas\total\sujNormTot\s';
        %colorBar=[0 1.3];
        colorBar=[0.75 1.05]; %nueva
        %colorBar=[0.75 1.05]; %misma ROI 48
    end  

%% Saco  el promedio de los RhoP de todos los canales para todos los sujetos en el tiempo min 


total=[];

for i=1:34
    if i ~=[18    28    30     4    16    32    16]   %los sujetos que no sirven y los que contestaron 0 bien, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es iguala a alguno no entra
        load([direc,num2str(i),'.mat']); 
        sujP=mean(suj,3); %promedio en frecuencias
        sujP=mean(sujP,2); %promedio en tiempos
        sujP=squeeze(sujP);
        total=[total sujP]; %(:,1:largoMin,:);
    end
end

pmedioTot=squeeze(mean(total,2)); %promedio en sujetos (se pusieron como columnas)


%% Grafico el promedio

addpath('C:\Users\luc�a\Documents\eeglab14_1_1b');
eeglab;

NOMBRE='s1';

ppal = 'direccion ppal';

filepathIN  = 'C:\Users\luc�a\Dropbox\datos\';

EEG = pop_loadset('filename',[NOMBRE,'.set'], 'filepath', filepathIN);
EEG = eeg_checkset( EEG );
localizacion=EEG.chanlocs;


figure();
topoplot(pmedioTot',localizacion,'maplimits',colorBar);
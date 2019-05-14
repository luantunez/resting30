close all
clear all
clc
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');

%%

banda=4;

if(banda==1) %theta
    frec='theta3';
    direccion={'F:\pasantías Luchi\resting\fft\bandas\theta\sujNormTot\s'};
    FRANGE=[4:0.2:8];
    colorBar=[0.6 1.8];
elseif(banda==2) %alfa
    frec='alfa';
    direccion={'F:\pasantías Luchi\resting\fft\bandas\alfa\sujNormTot\s'};
    FRANGE=[8:0.2:12];
    colorBar=[0.6 1.8];
elseif(banda==3) %betaLow
    frec='betaLow';
    direccion={'F:\pasantías Luchi\resting\fft\bandas\beta1\sujNormTot\s'};
    FRANGE=[12:0.5:22];
    colorBar=[0.4 0.9];
elseif(banda==4) %betaHigh1
     frec='betaHigh1';
    direccion={'F:\pasantías Luchi\resting\fft\bandas\beta2\sujNormTot\s'};       
    FRANGE=[22:0.5:35];
    colorBar=[0.2 0.5];
end

ROI=[1:30];

for i=1:34 
    
     if i~=[18 28 30 4 16 32]  %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es igual a alguno no entra
         suj=load(char(strcat(direccion,num2str(i),'.mat')));
        
        suj=suj.suj;
        suj=cast(suj,'double');
        
        suj=mean(suj,3); %promedio en frecuencias
        suj=mean(suj,2); %promedio en tiempos
        %suj=mean(suj(ROI),1);
        suj=squeeze(suj);
        
        clust(i)=mean(suj(ROI));  %hago un clust con el promedio de las energías de los canales de ese ROI para cada sujeto para el grafico de puntos     
     end
end

clust=clust';
clust([18 28 30 4 16 32])=[];

mean(clust)
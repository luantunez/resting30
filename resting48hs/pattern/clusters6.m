close all
clear all
clc
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');

%%

banda=4;

if(banda==1) %theta
    %ROI=[28,2,17,10, 22, 20, 21, 23, 18];
    frec='theta3';
    direccion={'D:\EEG\resting48hs\fft\theta\RhoNorm\s'};
    FRANGE=[4:0.2:8];
    colorBar=[0.6 1.8];
elseif(banda==2) %alfa
    %ROI=[18, 24, 25, 4, 19, 12, 29];
    frec='alfa';
    direccion={'D:\EEG\resting48hs\fft\alfa\RhoNorm\s'};
    FRANGE=[8:0.2:12];
    colorBar=[0.6 1.8];
elseif(banda==3) %betaLow
    %ROI=[29,19,4,12];
    frec='betaLow';
    direccion={'D:\EEG\resting48hs\fft\beta1\RhoNorm\s'};
    FRANGE=[12:0.5:22];
    colorBar=[0.4 0.9];
elseif(banda==4) %betaHigh1
     %ROI=[5, 13, 29];
     frec='betaHigh1';
    direccion={'D:\EEG\resting48hs\fft\beta2\RhoNorm\s'};       
    FRANGE=[22:0.5:35];
    colorBar=[0.2 0.5];
end

ROI=[1:30];

for i=1:23 
    
     if i~=3 && i ~= 14 && i ~= 16 && i ~= 18  && i ~= 15 && i~=17    %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es igual a alguno no entra
      
        suj=load(char(strcat(direccion,num2str(i),'.mat')));
        suj=suj.Rho;
        suj=cast(suj,'double');
        
        suj=mean(suj,3); %promedio en frecuencias
        suj=mean(suj,2); %promedio en tiempos
        %suj=mean(suj(ROI),1);
        suj=squeeze(suj);
        
        clust(i)=mean(suj(ROI));  %hago un clust con el promedio de las energías de los canales de ese ROI para cada sujeto para el grafico de puntos
        
     end
end

clust=clust';
clust([3 14 16 17 18 15])=[];

mean(clust)

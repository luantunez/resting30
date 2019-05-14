
close all
clear all
clc
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');

%%

banda=1;

if(banda==1) %theta
    ROI=[28,2,17,10, 22, 20, 21, 23, 18];
    frec='theta3';
    direccion={'F:\pasantías Luchi\resting\fft\bandas\theta\sujNormTot\s'};
    FRANGE=[4:0.2:8];
    colorBar=[0.6 1.8];
elseif(banda==2) %alfa
    ROI=[18, 24, 25, 4, 19, 12, 29];
    frec='alfa';
    direccion={'F:\pasantías Luchi\resting\fft\bandas\alfa\sujNormTot\s'};
    FRANGE=[8:0.2:12];
    colorBar=[0.6 1.8];
elseif(banda==3) %betaLow
    ROI=[29,19,4,12];
    frec='betaLow';
    direccion={'F:\pasantías Luchi\resting\fft\bandas\beta1\sujNormTot\s'};
    FRANGE=[12:0.5:22];
    colorBar=[0.4 0.9];
elseif(banda==4) %betaHigh1
     ROI=[5, 13, 29];
     frec='betaHigh1';
    direccion={'F:\pasantías Luchi\resting\fft\bandas\beta2\sujNormTot\s'};       
    FRANGE=[22:0.5:35];
    colorBar=[0.2 0.5];
end


%% saco clust de ROI

for i=1:34 
    
     if i~=18 && i ~= 28 && i ~= 30    %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es igual a alguno no entra

        
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


%% los divido random

clust=clust';
clust([18 28 30])=[];

for i=1:10000
    
    ordr=randperm(31);  %obtengo 31 elemetnos ordenados al azar que van a ser mis indices    
    
    pmedio1(i)=mean(clust(ordr(1:15)));    %me quedo con el promedio de los elementos de clust sub los primeros 15 indices random
    pmedio2(i)=mean(clust(ordr(16:31)));    %me quedo con el promedio de los elementos de clust sub los ultimos 15 indices random
    
    restPmedio(i)=pmedio1(i)-pmedio2(i);
    
end

pmedioFinal=mean(restPmedio);

hist(restPmedio);

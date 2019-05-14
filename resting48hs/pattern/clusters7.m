%comparar 30 min con 48 hs

close all
clear all
clc
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');

%%

banda=4;

if(banda==1) %theta
    %ROI=[28,2,17,10, 22, 20, 21, 23, 18];
    frec='theta3';
    direccion48hs={'D:\EEG\resting48hs\fft\theta\RhoNorm\s'};
    direccion30min={'F:\pasantías Luchi\resting\fft\bandas\theta\sujNormTot\s'};
    FRANGE=[4:0.2:8];
    colorBar=[0.6 1.8];
elseif(banda==2) %alfa
    %ROI=[18, 24, 25, 4, 19, 12, 29];
    frec='alfa';
    direccion48hs={'D:\EEG\resting48hs\fft\alfa\RhoNorm\s'};
    direccion30min={'F:\pasantías Luchi\resting\fft\bandas\alfa\sujNormTot\s'};
    FRANGE=[8:0.2:12];
    colorBar=[0.6 1.8];
elseif(banda==3) %betaLow
    %ROI=[29,19,4,12];
    frec='betaLow';
    direccion48hs={'D:\EEG\resting48hs\fft\beta1\RhoNorm\s'};
    direccion30min={'F:\pasantías Luchi\resting\fft\bandas\beta1\sujNormTot\s'};
    FRANGE=[12:0.5:22];
    colorBar=[0.4 0.9];
elseif(banda==4) %betaHigh1
     %ROI=[5, 13, 29];
     frec='betaHigh1';
    direccion48hs={'D:\EEG\resting48hs\fft\beta2\RhoNorm\s'};     
    direccion30min={'F:\pasantías Luchi\resting\fft\bandas\beta2\sujNormTot\s'};    
    FRANGE=[22:0.5:35];
    colorBar=[0.2 0.5];
end

ROI=[1:30];

%% 48 hs

for i=1:23 
    
     if i~=3 && i ~= 14 && i ~= 16 && i ~= 18  && i ~= 15 && i~=17    %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es igual a alguno no entra
      
        suj=load(char(strcat(direccion48hs,num2str(i),'.mat')));
        suj=suj.Rho;
        suj=cast(suj,'double');
        
        suj=mean(suj,3); %promedio en frecuencias
        suj=mean(suj,2); %promedio en tiempos
        %suj=mean(suj(ROI),1);
        suj=squeeze(suj);
        
        clust48hs(i)=mean(suj(ROI));  %hago un clust con el promedio de las energías de los canales de ese ROI para cada sujeto para el grafico de puntos
        
     end
end

clust48hs=clust48hs';
clust48hs([3 14 16 17 18 15])=[];

pmedio48hs=mean(clust48hs);
err48hs=std(clust48hs)/sqrt(length(clust48hs));

%% 30 min

for i=1:34 
    
     if i~=[18 28 30 4 16 32]  %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es igual a alguno no entra
         suj=load(char(strcat(direccion30min,num2str(i),'.mat')));
        
        suj=suj.suj;
        suj=cast(suj,'double');
        
        suj=mean(suj,3); %promedio en frecuencias
        suj=mean(suj,2); %promedio en tiempos
        %suj=mean(suj(ROI),1);
        suj=squeeze(suj);
        
        clust30min(i)=mean(suj(ROI));  %hago un clust con el promedio de las energías de los canales de ese ROI para cada sujeto para el grafico de puntos     
     end
end

clust30min=clust30min';
clust30min([18 28 30 4 16 32])=[];

pmedio30min=mean(clust30min);
err30min=std(clust30min)/sqrt(length(clust30min));

%% grafico de barras y ttest

bar([1,2], [pmedio30min,pmedio48hs]);
hold on
errorbar([1,2], [pmedio30min,pmedio48hs],[err30min,err48hs],'r.');
hold on
set(gca,'xticklabel',{'30 min','48 hs'});

[h,p,ci,stats]=ttest2(clust30min,clust48hs,'tail','left');
p
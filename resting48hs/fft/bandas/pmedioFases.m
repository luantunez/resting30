% modificado para nueva normalizacion

close all    
clear all
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');
 
   banda =7;
   
if banda==1
    colorBar=[-1 1]; %mismo colorbar que en 30 min
    FRANGE=[1:0.2:3];  %delta
    direcc={'D:\EEG\resting48hs\fft\delta\PhiDesc\s'};
    direcc2={'D:\EEG\resting48hs\fft\delta\PhiCut\s'};
elseif banda==2
    %colorBar=[0 3]; %mismo colorbar que en 30 min
    colorBar=[0.8 2.2]; %nueva colorbar
    FRANGE=[4:0.2:8];  %theta
    direcc={'D:\EEG\resting48hs\fft\theta\PhiDesc\s'};
    direcc2={'D:\EEG\resting48hs\fft\theta\PhiCut\s'};
elseif banda==3
    %colorBar=[0 3]; %mismo colorbar que en 30 min
    colorBar=[0.8 2]; %nueva colorbar
    FRANGE=[8:0.2:12]; %alfa
    direcc={'D:\EEG\resting48hs\fft\alfa\PhiDesc\s'};
    direcc2={'D:\EEG\resting48hs\fft\alfa\PhiCut\s'};
elseif banda==4
    colorBar=[0 1.2];
     FRANGE=[12:1:35]; %beta
    direcc={'D:\EEG\resting48hs\fft\beta\PhiDesc\s'};
    direcc2={'D:\EEG\resting48hs\fft\beta\PhiCut\s'};
elseif banda==5
    %colorBar=[0 1.7]; %mismo colorbar que en 30 min
    colorBar=[0.2 1.5];  %nueva colorbar
     FRANGE=[12:0.5:22]; %beta1
    direcc={'D:\EEG\resting48hs\fft\beta1\PhiDesc\s'};
    direcc2={'D:\EEG\resting48hs\fft\beta1\PhiCut\s'};
elseif banda==6
    %colorBar=[0 0.6]; %mismo colorbar que en 30 min
    colorBar=[0.2 0.6]; %nueva colorbar
    FRANGE=[22:0.5:35]; %beta2
    direcc={'D:\EEG\resting48hs\fft\beta2\PhiDesc\s'};
    direcc2={'D:\EEG\resting48hs\fft\beta2\PhiCut\s'};
elseif banda==7
    colorBar=[-1 2]; %mismo colorbar que en 30 min
    colorBar=[-1 1]; %nueva colorbar
    FRANGE=[1:1:35]; %total
    direcc={'D:\EEG\resting48hs\fft\total\PhiDesc\s'};
    direcc2={'D:\EEG\resting48hs\fft\total\PhiCut\s'};
elseif banda==8
    colorBar=[-0.2 2.2];
    FRANGE=[4:1:35]; %totalCut
    direcc={'D:\EEG\resting48hs\fft\totalCut\PhiDesc\s'};
    direcc2={'D:\EEG\resting48hs\fft\totalCut\PhiCut\s'};
end

%% Saco  el promedio de los RhoP de todos los canales para todos los sujetos en el tiempo min 

total=[];

for i=1:23
     if i ~=3 && i ~= 14 && i ~= 16 && i ~= 18 && i ~= 15 && i~=17   %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es iguala a alguno no entra
        load(char(strcat(direcc,num2str(i),'.mat'))); 
        pmedioCh=mean(Ang,1);  %promedio de todos los canales para cada sujeto;
        total=[total; pmedioCh]; %(:,1:largoMin,:);
        suj=load(char(strcat(direcc2,num2str(i),'.mat')));
    end
end

pmedioTot=squeeze(mean(total,1));

%% Grafico el promedio

imagesc(suj.EjeX/1000,suj.EjeF,pmedioTot',colorBar);
xlabel('tiempo (s)');
ylabel('frecuencia (Hz)');

[X,Y]   = meshgrid(1:size(pmedioTot,1), 1:length(FRANGE));

[X2,Y2] = meshgrid(1:0.05:size(pmedioTot,1), 1:0.1:length(FRANGE));

 sujFilt = interp2(X, Y, pmedioTot', X2, Y2, 'linear');
 
 figure();
 
 imagesc(suj.EjeX/1000,suj.EjeF,sujFilt,colorBar);
xlabel('tiempo (s)');
ylabel('frecuencia (Hz)');
 

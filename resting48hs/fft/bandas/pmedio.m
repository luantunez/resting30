% modificado para nueva normalizacion

close all    
clear all
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');
 
   banda =7;
   
if banda==1
    colorBar=[0 5]; %mismo colorbar que en 30 min
    FRANGE=[1:0.2:3];  %delta
    direcc={'F:\pasantías Luchi\resting48hs\fft\delta\RhoNorm\s'};
elseif banda==2
    %colorBar=[0 3]; %mismo colorbar que en 30 min
    colorBar=[0.8 2.2]; %nueva colorbar
    FRANGE=[4:0.2:8];  %theta
    direcc={'F:\pasantías Luchi\resting48hs\fft\theta\RhoNorm\s'};
elseif banda==3
    %colorBar=[0 3]; %mismo colorbar que en 30 min
    colorBar=[0.8 2]; %nueva colorbar
    FRANGE=[8:0.2:12]; %alfa
    direcc={'F:\pasantías Luchi\resting48hs\fft\alfa\RhoNorm\s'};
elseif banda==4
    colorBar=[0 1.2];
     FRANGE=[12:1:35]; %beta
    direcc={'F:\pasantías Luchi\resting48hs\fft\beta\RhoNorm\s'};
elseif banda==5
    %colorBar=[0 1.7]; %mismo colorbar que en 30 min
    colorBar=[0.2 1.5];  %nueva colorbar
     FRANGE=[12:0.5:22]; %beta1
    direcc={'F:\pasantías Luchi\resting48hs\fft\beta1\RhoNorm\s'};
elseif banda==6
    %colorBar=[0 0.6]; %mismo colorbar que en 30 min
    colorBar=[0.2 0.6]; %nueva colorbar
    FRANGE=[22:0.5:35]; %beta2
    direcc={'F:\pasantías Luchi\resting48hs\fft\beta2\RhoNorm\s'};
elseif banda==7
    colorBar=[0 3]; %mismo colorbar que en 30 min
    %colorBar=[-1 2]; %nueva colorbar
    FRANGE=[1:1:35]; %total
    direcc={'F:\pasantías Luchi\resting48hs\fft\total\RhoNorm\s'};
elseif banda==8
    colorBar=[-0.2 2.2];
    FRANGE=[4:1:35]; %totalCut
    direcc={'F:\pasantías Luchi\resting48hs\fft\totalCut\RhoNorm\s'};    
end

%% Saco  el promedio de los RhoP de todos los canales para todos los sujetos en el tiempo min 

total=[];

for i=1:23
    if i ~=3 && i ~= 14 && i ~= 16 && i ~= 18  && i ~= 15   %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es iguala a alguno no entra
        load(char(strcat(direcc,num2str(i),'.mat'))); 
        pmedioCh=mean(Rho,1);  %promedio de todos los canales para cada sujeto;
        total=[total; pmedioCh]; %(:,1:largoMin,:);
    end
end

pmedioTot=squeeze(mean(total,1));

%% Grafico el promedio

imagesc(EjeX/1000,EjeF,pmedioTot',colorBar);
xlabel('tiempo (s)');
ylabel('frecuencia (Hz)');

[X,Y]   = meshgrid(1:size(pmedioTot,1), 1:length(FRANGE));

[X2,Y2] = meshgrid(1:0.05:size(pmedioTot,1), 1:0.1:length(FRANGE));

 sujFilt = interp2(X, Y, pmedioTot', X2, Y2, 'linear');
 
 figure();
 
 imagesc(EjeX/1000,EjeF,sujFilt,colorBar);
xlabel('tiempo (s)');
ylabel('frecuencia (Hz)');
 

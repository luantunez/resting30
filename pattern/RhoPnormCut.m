close all
clear all
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');

addpath('C:\Users\lucía\Documents\eeglab14_1_1b');
eeglab;

NOMBRE='s1';

ppal = 'direccion ppal';

filepathIN  = 'C:\Users\lucía\Dropbox\datos\';

EEG = pop_loadset('filename',[NOMBRE,'.set'], 'filepath', filepathIN);
EEG = eeg_checkset( EEG );
localizacion=EEG.chanlocs;



%% Saco la mínima dimensión de tiempos (del sujeto registrado durante menos tiempo)

FRANGE=[1:0.2:3];  %delta
colorBar=[1.4 3];
%FRANGE=[4:0.2:8];  %theta
%FRANGE=[8:0.2:12]; %alfa
%FRANGE=[12:1:35]; %beta
%FRANGE=[12:0.5:22]; %beta1
%FRANGE=[22:0.5:35]; %beta2
%FRANGE=[1:1:35]; %total

largos=zeros(1,34);

for i=1:34
     if i ~= 18 && i ~= 28 && i ~= 30    %los sujetos que no sirven, si es distinto de estos, guardar el largo, sino poner un valor nulo, no sirven
        load(['F:\pasantías Luchi\resting\fft\bandas\total\RhoP\s',num2str(i),'.mat']); 
        largos(i)=length(RhoP);
     else
         largos(i)=nan; %a estos, que no sirven, les asigno un valor nulo
     end
end

[largoMin,sujetoMin]=min(largos);

%% normalizo sujetos y los corto

suj=zeros(30,largoMin,length(FRANGE));

for i=1:34
    if i ~=18 && i ~= 28 && i ~= 30   %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es iguala a alguno no entra
        load(['F:\pasantías Luchi\resting\fft\bandas\delta\RhoP\s',num2str(i),'.mat']); 
        %pmedioCh=mean(RhoP,1);  %promedio de todos los canales para cada sujeto;
        
        RhoP=RhoP(:,1:largoMin,:);  %me quedo hasta el tiempo del sujeto mas corto
        
        pmedioCh=squeeze(mean(RhoP,3)); %promedio en frecuencias
        pmedioCh=squeeze(mean(pmedioCh,2)); %promedio en tiempos
        pmedioCh=mean(pmedioCh,1); %promedio en canales
        suj=RhoP/pmedioCh; %normalizo cada sujeto respecto a si mismo
        
        EjeX=EjeX(1:largoMin);
        
        save(['F:\pasantías Luchi\resting\fft\bandas\delta\suj\s',num2str(i),'.mat'],'suj','EjeX','EjeF'); 
    end 
end


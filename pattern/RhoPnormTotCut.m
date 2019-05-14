close all
clear all
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');


%% Saco la mínima dimensión de tiempos (del sujeto registrado durante menos tiempo)

banda =7;

if banda==1
    FRANGE=[1:0.2:3];  %delta
    direccion={'D:\EEG\fft\bandas\delta\RhoP\s'};
    direccion2={'D:\EEG\fft\bandas\delta\sujNormTot\s'};
elseif banda==2
    FRANGE=[4:0.2:8];  %theta
    direccion={'D:\EEG\fft\bandas\theta\RhoP\s'};
    direccion2={'D:\EEG\fft\bandas\theta\sujNormTot\s'};
elseif banda==3
    FRANGE=[8:0.2:12]; %alfa
    direccion={'D:\EEG\fft\bandas\alfa\RhoP\s'};
    direccion2={'D:\EEG\fft\bandas\alfa\sujNormTot\s'};
elseif banda==4
     FRANGE=[12:1:35]; %beta
    direccion={'D:\EEG\fft\bandas\beta\RhoP\s'};
    direccion2={'D:\EEG\fft\bandas\beta\sujNormTot\s'};
elseif banda==5
     FRANGE=[12:0.5:22]; %beta1
    direccion={'D:\EEG\fft\bandas\beta1\RhoP\s'};
    direccion2={'D:\EEG\fft\bandas\beta1\sujNormTot\s'};
elseif banda==6
    FRANGE=[22:0.5:35]; %beta2
    direccion={'D:\EEG\fft\bandas\beta2\RhoP\s'};
    direccion2={'D:\EEG\fft\bandas\beta2\sujNormTot\s'};
elseif banda==7
    FRANGE=[1:1:35]; %total
    direccion={'D:\EEG\fft\bandas\total\RhoP\s'};
    direccion2={'D:\EEG\fft\bandas\total\sujNormTot\s'};
end

largos=zeros(1,34);

for i=1:34
     if i ~= 18 && i ~= 28 && i ~= 30    %los sujetos que no sirven, si es distinto de estos, guardar el largo, sino poner un valor nulo, no sirven
        suj=load(['D:\EEG\fft\bandas\total\RhoP\s',num2str(i),'.mat']); 
        largos(i)=length(suj.RhoP);
     else
         largos(i)=nan; %a estos, que no sirven, les asigno un valor nulo
     end
end

[largoMin,sujetoMin]=min(largos);

%% normalizo sujetos y los corto

suj=zeros(30,largoMin,length(FRANGE));

for i=1:34
    if i ~=18 && i ~= 28 && i ~= 30   %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es iguala a alguno no entra
        suj=load(['D:\EEG\fft\bandas\total\RhoP\s',num2str(i),'.mat']); 
        %pmedioCh=mean(RhoP,1);  %promedio de todos los canales para cada sujeto;
        %RhoP=RhoP.RhoP;
        
        sujTmin=suj.RhoP(:,1:largoMin,:);  %me quedo hasta el tiempo del sujeto mas corto
        
        pmedioCh=squeeze(mean(sujTmin,3)); %promedio en frecuencias
        pmedioCh=squeeze(mean(pmedioCh,2)); %promedio en tiempos
        pmedioCh=mean(pmedioCh,1); %promedio en canales
        % saque el promedio de todas las frecuencias para ese sujeto
        
        load(char(strcat(direccion,num2str(i),'.mat')));
        %RhoP=RhoP.RhoP;
        RhoP=RhoP(:,1:largoMin,:);  %me quedo hasta el tiempo del sujeto mas corto
        suj=RhoP/pmedioCh; %normalizo cada sujeto respecto a si mismo (al total de las frecuencias)
        
        EjeX=EjeX(1:largoMin);
        
        save(char(strcat(direccion2,num2str(i),'.mat')),'suj','EjeX','EjeF'); 
    end 
end
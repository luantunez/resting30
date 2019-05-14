close all
clear all
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');


%% 

banda =8;

if banda==1
    FRANGE=[1:0.2:3];  %delta
    direccion={'F:\pasantías Luchi\resting48hs\fft\delta\Rho\s'};
    direccion2={'F:\pasantías Luchi\resting48hs\fft\delta\RhoNorm\s'};
elseif banda==2
    FRANGE=[4:0.2:8];  %theta
    direccion={'F:\pasantías Luchi\resting48hs\fft\theta\Rho\s'};
    direccion2={'F:\pasantías Luchi\resting48hs\fft\theta\RhoNorm\s'};
elseif banda==3
    FRANGE=[8:0.2:12]; %alfa
    direccion={'F:\pasantías Luchi\resting48hs\fft\alfa\Rho\s'};
    direccion2={'F:\pasantías Luchi\resting48hs\fft\alfa\RhoNorm\s'};
elseif banda==4
     FRANGE=[12:1:35]; %beta
    direccion={'F:\pasantías Luchi\resting48hs\fft\beta\Rho\s'};
    direccion2={'F:\pasantías Luchi\resting48hs\fft\beta\RhoNorm\s'};
elseif banda==5
     FRANGE=[12:0.5:22]; %beta1
    direccion={'F:\pasantías Luchi\resting48hs\fft\beta1\Rho\s'};
    direccion2={'F:\pasantías Luchi\resting48hs\fft\beta1\RhoNorm\s'};
elseif banda==6
    FRANGE=[22:0.5:35]; %beta2
    direccion={'F:\pasantías Luchi\resting48hs\fft\beta2\Rho\s'};
    direccion2={'F:\pasantías Luchi\resting48hs\fft\beta2\RhoNorm\s'};
elseif banda==7
    FRANGE=[1:1:35]; %total
    direccion={'F:\pasantías Luchi\resting48hs\fft\total\Rho\s'};
    direccion2={'F:\pasantías Luchi\resting48hs\fft\total\RhoNorm\s'};
elseif banda==8
    FRANGE=[4:1:35]; %totalCut
    direccion={'F:\pasantías Luchi\resting48hs\fft\totalCut\Rho\s'};
    direccion2={'F:\pasantías Luchi\resting48hs\fft\totalCut\RhoNorm\s'};    
end

%% Saco la mínima dimensión de tiempos (del sujeto registrado durante menos tiempo)

largos=zeros(1,23);

% for i=1:23
%     % if i ~= 18 && i ~= 28 && i ~= 30    %los sujetos que no sirven, si es distinto de estos, guardar el largo, sino poner un valor nulo, no sirven
%         load(['D:\EEG\resting48hs\fft\total\Rho\s',num2str(i),'.mat']); 
%         largos(i)=size(EjeX,2);
%      %else
%          %largos(i)=nan; %a estos, que no sirven, les asigno un valor nulo
%      %end
% end
% 
% [largoMin,sujetoMin]=min(largos);

largoMin=495;  %igual al largoMin del resting de 30 min

%% normalizo sujetos y los corto

suj=zeros(30,largoMin,length(FRANGE));

for i=1:23
    if i ~=3 && i ~= 14 && i ~= 16 && i ~= 18 && i ~= 15   %los sujetos que no sirven (y 15 que es demasiado corto), si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es iguala a alguno no entra
        suj=load(['F:\pasantías Luchi\resting48hs\fft\total\Rho\s',num2str(i),'.mat']); 
        %pmedioCh=mean(RhoP,1);  %promedio de todos los canales para cada sujeto;
        %RhoP=RhoP.RhoP;
        
        sujTmin=suj.Rho(:,1:largoMin,:);  %me quedo hasta el tiempo del sujeto mas corto
        
        pmedioCh=squeeze(mean(sujTmin,3)); %promedio en frecuencias
        pmedioCh=squeeze(mean(pmedioCh,2)); %promedio en tiempos
        pmedioCh=mean(pmedioCh,1); %promedio en canales
        % saque el promedio de todas las frecuencias para ese sujeto
        
        load(char(strcat(direccion,num2str(i),'.mat')));
        %RhoP=RhoP.RhoP;
        Rho=Rho(:,1:largoMin,:);  %me quedo hasta el tiempo del sujeto mas corto
        Rho=Rho/pmedioCh; %normalizo cada sujeto respecto a si mismo (al total de las frecuencias)
        
        EjeX=EjeX(1:largoMin);
        
        save(char(strcat(direccion2,num2str(i),'.mat')),'Rho','EjeX','EjeF'); 
    end 
end
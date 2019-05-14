close all
clear all
addpath('C:\Users\luc�a\Documents\MATLAB\EEG\EEG2\fft');


%% Saco la m�nima dimensi�n de tiempos (del sujeto registrado durante menos tiempo)

%FRANGE=[1:0.2:3];  %delta
%FRANGE=[4:0.2:8];  %theta
%FRANGE=[8:0.2:12]; %alfa
%FRANGE=[12:1:35]; %beta
%FRANGE=[12:0.5:22]; %beta1
%FRANGE=[22:0.5:35]; %beta2
FRANGE=[1:1:35]; %total

largos=zeros(1,34);

for i=1:34
     if i ~= 18 && i ~= 28 && i ~= 30    %los sujetos que no sirven, si es distinto de estos, guardar el largo, sino poer un valor alto, no sirven
        load(['D:\EEG\fft\bandas\total\RhoP\s',num2str(i),'.mat']); 
        largos(i)=length(RhoP);
     else
         largos(i)=nan; %a estos, que no sirven, les asigno un valor largo
     end
end

[largoMin,sujetoMin]=min(largos);

%% Saco  el promedio de los RhoP de todos los canales para todos los sujetos en el tiempo min 

suj=zeros(30,largoMin,length(FRANGE));

for i=1:34
    if i ~=18 && i ~= 28 && i ~= 30   %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es iguala a alguno no entra
        load(['D:\EEG\fft\bandas\total\RhoP\s',num2str(i),'.mat']); 
        %pmedioCh=mean(RhoP,1);  %promedio de todos los canales para cada sujeto;

        RhoP=RhoP(:,1:largoMin,:);  %me quedo hasta el tiempo del sujeto mas corto
        pmedioCh=mean(RhoP,3); %promedio en frecuencias
        pmedioCh=mean(pmedioCh,2); %promedio en tiempos
        pmedioCh=mean(pmedioCh,1); %promedio en canales
        pmedioCh=squeeze(pmedioCh);
        sujNorm=RhoP/pmedioCh; %normalizo cada sujeto respecto a si mismo
        
        suj=suj+sujNorm; %sumo todos los sujetos

    end
end

suj=suj/31; %divido por la cantidad de sujetos -> tengo promedio de todos los sujetos
suj=squeeze(suj);

% pmedioTot=mean(suj,3); %promedio en frecuencias
% pmedioTot=mean(pmedioTot,2); %promedio en tiempos
suj=mean(suj,1); %promedio en canales
% pmedioTot=squeeze(pmedioTot);
% suj=suj/pmedioTot; %normalizo total de sujetos
suj=squeeze(suj);



%% Grafico el promedio

%colorBar=[-1 800]; %delta
%colorBar=[-1 450]; %theta
%colorBar=[-1 500]; %alfa
%colorBar=[-1 150]; %beta
%colorBar=[-1 150]; %beta2
%colorBar=[-1 375]; %total
%colorBar=[-1 400]; %comun

%colorBar=[-1 2]; % delta pmedioTot
colorBar=[-1 2]; %theta pmedioTot
%colorBar=[-1 2]; %alfa pmedioTot%
%colorBar=[-1 2]; %beta pmedioTot
%colorBar=[-1 150]; %beta2 pmedioTot
%colorBar=[-1 2]; %total pmedioTot
%colorBar=[-1 400]; %comun pmedioTot

imagesc(EjeX/1000,EjeF,suj',colorBar);
xlabel('tiempo (s)');
ylabel('frecuencia (Hz)');

[X,Y]   = meshgrid(1:largoMin, 1:length(FRANGE));

[X2,Y2] = meshgrid(1:0.05:largoMin, 1:0.1:length(FRANGE));

 sujFilt = interp2(X, Y, suj', X2, Y2, 'linear');
 
 figure();
 
 imagesc(EjeX/1000,EjeF,sujFilt,colorBar);
xlabel('tiempo (s)');
ylabel('frecuencia (Hz)');
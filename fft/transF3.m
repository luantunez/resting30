close all
clear all
 addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft\bandas');
 
%% Hago esto sólo para sacar EjeX y EjeF
i=1;
j=1;
load(['C:\Users\lucía\Dropbox\datosFiltrados\sujetos\s',num2str(i),'mat.mat']);
ind=find(times<800000);
FE=256;
FRANGE=[1:0.5:8];
TRANGE=[0:800000];
WinSig=256;
step=WinSig-WinSig/2;
SIG=datos(j,ind);
[Rho, Phi, EjeX, EjeF] = espectrograma2( SIG, FE, FRANGE, TRANGE, WinSig, step);

%% Saco la mínima dimensión de tiempos (del sujeto registrado durante menos tiempo)

load(['C:\Users\lucía\Dropbox\fft\Rho\S',num2str(i),'\s',num2str(i),'Ch',num2str(j),'.mat']); 

largos=zeros(1,34);

for i=1:34
     if i ~= 18 && i ~= 28 && i ~= 30    %los sujetos que no sirven, si es distinto de estos, guardar el largo, sino poer un valor alto, no sirven
        for j=1:30
            load(['C:\Users\lucía\Dropbox\fft\Rho\S',num2str(i),'\s',num2str(i),'Ch',num2str(j),'.mat']); 
            largos(i)=length(RhoP);
        end
     else
         largos(i)=nan; %a estos, que no sirven, les asigno un valor largo
     end
end

[largoMin,sujetoMin]=min(largos);

%% Saco  el promedio de los RhoP de todos los canales para todos los sujetos en el tiempo min 

Ch=zeros(largoMin,15);

for i=1:34
    if i ~=18 && i ~= 28 && i ~= 30   %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es iguala a alguno no entra
        for j=1:30
            load(['C:\Users\lucía\Dropbox\fft\Rho\S',num2str(i),'\s',num2str(i),'Ch',num2str(j),'.mat']); 
            Ch=Ch+RhoP(1:largoMin,:);
        end
        Ch=Ch/30;
    end
end

Ch=Ch/34;

%% Grafico el promedio

imagesc(EjeX,EjeF,Ch',[-1 20]);
xlabel('tiempo');
ylabel('frecuencia');
close all
clear all
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');


%% Saco la mínima dimensión de tiempos (del sujeto registrado durante menos tiempo)

banda =7;

if banda==1
    FRANGE=[1:0.2:3];  %delta
    direccion={'F:\pasantías Luchi\resting\fft\bandas\delta\RhoP\s'};
    direccion2={'F:\pasantías Luchi\resting\fft\bandas\delta\sujCut495\s'};
elseif banda==2
    FRANGE=[4:0.2:8];  %theta
    direccion={'F:\pasantías Luchi\resting\fft\bandas\theta\RhoP\s'};
    direccion2={'F:\pasantías Luchi\resting\fft\bandas\theta\sujCut495\s'};
elseif banda==3
    FRANGE=[8:0.2:12]; %alfa
    direccion={'F:\pasantías Luchi\resting\fft\bandas\alfa\RhoP\s'};
    direccion2={'F:\pasantías Luchi\resting\fft\bandas\alfa\sujCut495\s'};
elseif banda==4
     FRANGE=[12:1:35]; %beta
    direccion={'F:\pasantías Luchi\resting\fft\bandas\beta\RhoP\s'};
    direccion2={'F:\pasantías Luchi\resting\fft\bandas\beta\sujCut495\s'};
elseif banda==5
     FRANGE=[12:0.5:22]; %beta1
    direccion={'F:\pasantías Luchi\resting\fft\bandas\beta1\RhoP\s'};
    direccion2={'F:\pasantías Luchi\resting\fft\bandas\beta1\sujCut495\s'};
elseif banda==6
    FRANGE=[22:0.5:35]; %beta2
    direccion={'F:\pasantías Luchi\resting\fft\bandas\beta2\RhoP\s'};
    direccion2={'F:\pasantías Luchi\resting\fft\bandas\beta2\sujCut495\s'};
elseif banda==7
    FRANGE=[1:1:35]; %total
    direccion={'F:\pasantías Luchi\resting\fft\bandas\total\RhoP\s'};
    direccion2={'F:\pasantías Luchi\resting\fft\bandas\total\sujCut495\s'};
end

largos=zeros(1,34);

largoMin=495;

%% normalizo sujetos y los corto

suj=zeros(30,largoMin,length(FRANGE));

for i=1:34
    if i ~=18 && i ~= 28 && i ~= 30   %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es iguala a alguno no entra
                
        load(char(strcat(direccion,num2str(i),'.mat')));
        %RhoP=RhoP.RhoP;
        RhoP=RhoP(:,1:largoMin,:);  %me quedo hasta el tiempo del sujeto mas corto
        
        EjeX=EjeX(1:largoMin);
        
        save(char(strcat(direccion2,num2str(i),'.mat')),'RhoP','EjeX','EjeF'); 
        
    end 
end
banda=3

for banda=7:8

close all
clearvars -except banda
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');


%% 

if banda==1
    FRANGE=[1:0.2:3];  %delta
    direccion={'D:\EEG\resting48hs\fft\delta\RhoFase\s'};
    direccion2={'D:\EEG\resting48hs\fft\delta\PhiCut\s'};
elseif banda==2
    FRANGE=[4:0.2:8];  %theta
    direccion={'D:\EEG\resting48hs\fft\theta\RhoFase\s'};
    direccion2={'D:\EEG\resting48hs\fft\theta\PhiCut\s'};
elseif banda==3
    FRANGE=[8:0.2:12]; %alfa
    direccion={'D:\EEG\resting48hs\fft\alfa\RhoFase\s'};
    direccion2={'D:\EEG\resting48hs\fft\alfa\PhiCut\s'};
elseif banda==4
     FRANGE=[12:1:35]; %beta
    direccion={'D:\EEG\resting48hs\fft\beta\RhoFase\s'};
    direccion2={'D:\EEG\resting48hs\fft\beta\PhiCut\s'};
elseif banda==5
     FRANGE=[12:0.5:22]; %beta1
    direccion={'D:\EEG\resting48hs\fft\beta1\RhoFase\s'};
    direccion2={'D:\EEG\resting48hs\fft\beta1\PhiCut\s'};
elseif banda==6
    FRANGE=[22:0.5:35]; %beta2
    direccion={'D:\EEG\resting48hs\fft\beta2\RhoFase\s'};
    direccion2={'D:\EEG\resting48hs\fft\beta2\PhiCut\s'};
elseif banda==7
    FRANGE=[1:1:35]; %total
    direccion={'D:\EEG\resting48hs\fft\total\RhoFase\s'};
    direccion2={'D:\EEG\resting48hs\fft\total\PhiCut\s'};
elseif banda==8
    FRANGE=[4:1:35]; %totalCut
    direccion={'D:\EEG\resting48hs\fft\totalCut\RhoFase\s'};
    direccion2={'D:\EEG\resting48hs\fft\totalCut\PhiCut\s'};    
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
    if i ~=3 && i ~= 14 && i ~= 16 && i ~= 18 && i ~= 15 && i~=17   %los sujetos que no sirven (y 15 que es demasiado corto), si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es iguala a alguno no entra
        
        load(char(strcat(direccion,num2str(i),'.mat')));
        %RhoP=RhoP.RhoP;
        CumMatdif=CumMatdif(:,1:largoMin,:);  %me quedo hasta el tiempo del sujeto mas corto
        
        CumPhi=CumPhi(:,1:largoMin,:);
        CumRho=CumRho(:,1:largoMin,:);      
        EjeX=EjeX(1:largoMin);
        
        save(char(strcat(direccion2,num2str(i),'.mat')),'CumMatdif','CumPhi','CumRho','EjeX','EjeF','ParElec'); 
    end 
end

end
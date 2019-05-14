for banda=1:8
    
    banda

close all
clearvars -except banda
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');


%% 

if banda==1
    FRANGE=[1:0.2:3];  %delta
    direccion={'D:\EEG\resting48hs\fft\delta\PhiCut\s'};
    direccion2={'D:\EEG\resting48hs\fft\delta\PhiDesc\s'};
elseif banda==2
    FRANGE=[4:0.2:8];  %theta
    direccion={'D:\EEG\resting48hs\fft\theta\PhiCut\s'};
    direccion2={'D:\EEG\resting48hs\fft\theta\PhiDesc\s'};
elseif banda==3
    FRANGE=[8:0.2:12]; %alfa
    direccion={'D:\EEG\resting48hs\fft\alfa\PhiCut\s'};
    direccion2={'D:\EEG\resting48hs\fft\alfa\PhiDesc\s'};
elseif banda==4
     FRANGE=[12:1:35]; %beta
    direccion={'D:\EEG\resting48hs\fft\beta\PhiCut\s'};
    direccion2={'D:\EEG\resting48hs\fft\beta\PhiDesc\s'};
elseif banda==5
     FRANGE=[12:0.5:22]; %beta1
    direccion={'D:\EEG\resting48hs\fft\beta1\PhiCut\s'};
    direccion2={'D:\EEG\resting48hs\fft\beta1\PhiDesc\s'};
elseif banda==6
    FRANGE=[22:0.5:35]; %beta2
    direccion={'D:\EEG\resting48hs\fft\beta2\PhiCut\s'};
    direccion2={'D:\EEG\resting48hs\fft\beta2\PhiDesc\s'};
elseif banda==7
    FRANGE=[1:1:35]; %total
    direccion={'D:\EEG\resting48hs\fft\total\PhiCut\s'};
    direccion2={'D:\EEG\resting48hs\fft\total\PhiDesc\s'};
elseif banda==8
    FRANGE=[4:1:35]; %totalCut
    direccion={'D:\EEG\resting48hs\fft\totalCut\PhiCut\s'};
    direccion2={'D:\EEG\resting48hs\fft\totalCut\PhiDesc\s'};
end

for i=1:23
    if i ~=3 && i ~= 14 && i ~= 16 && i ~= 18 && i ~= 15 && i~=17   %los sujetos que no sirven (y 15 que es demasiado corto), si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es iguala a alguno no entra
        
        load(char(strcat(direccion,num2str(i),'.mat')));
        
        Mod=abs(CumPhi);
        Ang=angle(CumPhi);
        
        save(char(strcat(direccion2,num2str(i),'.mat')),'Mod', 'Ang'); 
    end 
end

end
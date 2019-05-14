for banda=1:8
    
    banda

close all
clearvars -except banda
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');


%% 

if banda==1
    FRANGE=[1:0.2:3];  %delta
    direccion={'F:\pasantías Luchi\resting\fft\bandas\delta\PhiCut\s'};
    direccion2={'F:\pasantías Luchi\resting\fft\bandas\delta\PhiDesc\s'};
elseif banda==2
    FRANGE=[4:0.2:8];  %theta
    direccion={'F:\pasantías Luchi\resting\fft\bandas\theta\PhiCut\s'};
    direccion2={'F:\pasantías Luchi\resting\fft\bandas\theta\PhiDesc\s'};
elseif banda==3
    FRANGE=[8:0.2:12]; %alfa
    direccion={'F:\pasantías Luchi\resting\fft\bandas\alfa\PhiCut\s'};
    direccion2={'F:\pasantías Luchi\resting\fft\bandas\alfa\PhiDesc\s'};
elseif banda==4
     FRANGE=[12:1:35]; %beta
    direccion={'F:\pasantías Luchi\resting\fft\bandas\beta\PhiCut\s'};
    direccion2={'F:\pasantías Luchi\resting\fft\bandas\beta\PhiDesc\s'};
elseif banda==5
     FRANGE=[12:0.5:22]; %beta1
    direccion={'F:\pasantías Luchi\resting\fft\bandas\beta1\PhiCut\s'};
    direccion2={'F:\pasantías Luchi\resting\fft\bandas\beta1\PhiDesc\s'};
elseif banda==6
    FRANGE=[22:0.5:35]; %beta2
    direccion={'F:\pasantías Luchi\resting\fft\bandas\beta2\PhiCut\s'};
    direccion2={'F:\pasantías Luchi\resting\fft\bandas\beta2\PhiDesc\s'};
elseif banda==7
    FRANGE=[1:1:35]; %total
    direccion={'F:\pasantías Luchi\resting\fft\bandas\total\PhiCut\s'};
    direccion2={'F:\pasantías Luchi\resting\fft\bandas\total\PhiDesc\s'};
elseif banda==8
    FRANGE=[4:1:35]; %totalCut
    direccion={'F:\pasantías Luchi\resting\fft\bandas\totalCut\PhiCut\s'};
    direccion2={'F:\pasantías Luchi\resting\fft\bandas\totalCut\PhiDesc\s'};
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
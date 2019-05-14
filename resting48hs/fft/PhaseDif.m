for banda=1:8
    
    banda

close all
clearvars -except banda
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');
   
if banda==1
    colorBar=[-1 1]; %mismo colorbar que en 30 min
    FRANGE=[1:0.2:3];  %delta
    direcc={'D:\EEG\resting48hs\fft\delta\PhiDesc\s'};
    direcc2={'F:\pasantías Luchi\resting48hs\fft\delta\difPh\s'};
elseif banda==2
    %colorBar=[0 3]; %mismo colorbar que en 30 min
    colorBar=[0.8 2.2]; %nueva colorbar
    FRANGE=[4:0.2:8];  %theta
    direcc={'D:\EEG\resting48hs\fft\theta\PhiDesc\s'};
    direcc2={'F:\pasantías Luchi\resting48hs\fft\theta\difPh\s'};
elseif banda==3
    %colorBar=[0 3]; %mismo colorbar que en 30 min
    colorBar=[0.8 2]; %nueva colorbar
    FRANGE=[8:0.2:12]; %alfa
    direcc={'D:\EEG\resting48hs\fft\alfa\PhiDesc\s'};
    direcc2={'F:\pasantías Luchi\resting48hs\fft\alfa\difPh\s'};
elseif banda==4
    colorBar=[0 1.2];
     FRANGE=[12:1:35]; %beta
    direcc={'D:\EEG\resting48hs\fft\beta\PhiDesc\s'};
    direcc2={'F:\pasantías Luchi\resting48hs\fft\beta\difPh\s'};
elseif banda==5
    %colorBar=[0 1.7]; %mismo colorbar que en 30 min
    colorBar=[0.2 1.5];  %nueva colorbar
     FRANGE=[12:0.5:22]; %beta1
    direcc={'D:\EEG\resting48hs\fft\beta1\PhiDesc\s'};
    direcc2={'F:\pasantías Luchi\resting48hs\fft\beta1\difPh\s'};
elseif banda==6
    %colorBar=[0 0.6]; %mismo colorbar que en 30 min
    colorBar=[0.2 0.6]; %nueva colorbar
    FRANGE=[22:0.5:35]; %beta2
    direcc={'D:\EEG\resting48hs\fft\beta2\PhiDesc\s'};
    direcc2={'F:\pasantías Luchi\resting48hs\fft\beta2\difPh\s'};
elseif banda==7
    colorBar=[-1 2]; %mismo colorbar que en 30 min
    colorBar=[-1 1]; %nueva colorbar
    FRANGE=[1:1:35]; %total
    direcc={'D:\EEG\resting48hs\fft\total\PhiDesc\s'};
    direcc2={'F:\pasantías Luchi\resting48hs\fft\total\difPh\s'};
elseif banda==8
    colorBar=[-0.2 2.2];
    FRANGE=[4:1:35]; %totalCut
    direcc={'D:\EEG\resting48hs\fft\totalCut\PhiDesc\s'};
    direcc2={'F:\pasantías Luchi\resting48hs\fft\totalCut\difPh\s'};
end

%% Saco  el promedio de los RhoP de todos los canales para todos los sujetos en el tiempo min 

for i=1:23
     if i ~=3 && i ~= 14 && i ~= 16 && i ~= 18 && i ~= 15 && i~=17   %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es iguala a alguno no entra
       difPh=zeros(30,30,495,size(FRANGE,2)); %canal1,canal2,tiempo,frecuencia
         for freq=1:size(FRANGE,2) %para cada frecuencia
            for time=1:495  %para cada tiempo
                suj=load(char(strcat(direcc,num2str(i),'.mat'))); 
                for ch1=1:30 %para 1 canal a restar
                    for ch2=1:30   %para el otro canal a restar
                difPh(ch1,ch2,time)=[suj.Ang(ch1,time,freq)-suj.Ang(ch2,time,freq)];
                %mat=difPh(:,:,:,1);  %para visualizacion  
                    end
                end
            end
        end        
     end
    save(char(strcat(direcc2,num2str(i),'.mat')),'difPh'); 
end

end
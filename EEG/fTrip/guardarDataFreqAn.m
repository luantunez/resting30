clear all
close all

banda=7



%elijo frecuencia
if banda==1
frange=[1:0.2:3];  %delta
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\delta';
elseif banda==2
    frange=[4:0.2:8];  %theta
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\theta';
elseif banda==3
    frange=[8:0.2:12]; %alfa
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\alfa';
elseif banda==4
     frange=[12:0.5:22]; %beta1
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\beta1';
elseif banda==5
    frange=[22:0.5:35]; %beta2
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\beta2';
elseif banda==6
    frange=[1:1:35]; %total
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\total';
elseif banda==7
    frange=[4:1:35]; %total
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\totalCut';
end   

addpath('C:\Users\lucía\Documents\eeglab14_1_1b')
eeglab;

%% levanto los datos de excel

 nombre=xlsread('F:\pasantías Luchi\resting\clusters\datos.xlsx', 'T2:T35');  %levanto datos de excel
 definicion=xlsread('F:\pasantías Luchi\resting\clusters\datos.xlsx', 'U2:U35');
 
%% divido en buenos y malos aprendedores para nombres y definiciones

indNom=find(nombre==0);  
indDef=find(definicion==0);  %saco los que no adivinaron nada


nombre2=nombre;
nombre2([18,28,30,indNom',indDef'])=[];
definicion2=definicion;
definicion2([18,28,30,indNom',indDef'])=[];

medNom=median(nombre2);  %para nombre
medDef=median(definicion2);  %para definicion

nombre([18,28,30,indNom',indDef'])=nan;
definicion([18,28,30,indNom',indDef'])=nan;

% nombreMedia=nombre;
% definicionMedia=definicion;
%
% %para hacer el promedio:
% nombreMedia([17 3 14 16 18 15])=[];
% definicionMedia([17 3 14 16 18 15])=[];
% 
% medNom=median(nombreMedia);  %para nombre
% medDef=median(definicionMedia);  %para definicion
% 
% %despues de hacer la mediana vuelvo a levatar para que me queden ordenados
% 
%  nombre([17 3 14 16 18 15])=nan;    %falta suj 17 tal
%  definicion([17 3 14 16 18 15])=nan;    %falta suj 17 tal

sujBuenosNom=[];   %inicializo
sujMalosNom=[];
sujBuenosDef=[];
sujMalosDef=[];

buenosNom=[];
malosNom=[];
buenosDef=[];
malosDef=[];
        
ppal = 'direccion ppal';
filepathIN  = 'F:\pasantías Luchi\resting\datosFiltrados\ICA2\';

%guardo sujetos divididos en buenos y malos aprendedores de nombres y
%definiciones

for i=1:34 
     if i~=[18 28 30 indNom' indDef']     %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es igual a alguno no entra                 
             
        NOMBRE=['s',num2str(i)];

        EEG = pop_loadset('filename',[NOMBRE,'_ICA_removed.set'], 'filepath', filepathIN);
        EEG = eeg_checkset( EEG );

        data=eeglab2fieldtrip(EEG, 'preprocessing');  %convierto
        
        close all

        addpath C:\Users\lucía\Documents\MATLAB\fieldtrip-20180815
        ft_defaults;
        
        cfg              = [];
        cfg.output       = 'pow';
        cfg.channel      = 'all';
        cfg.method       = 'mtmconvol';
        cfg.taper        = 'hanning';
        cfg.pad          = 'nextpow2';
        cfg.foi          = frange;   % Todas las bandas de frecuencia
        cfg.t_ftimwin    = ones(length(cfg.foi),1);   %length of time window (in seconds) -> 1 segundo cada ventana para que se superpongan ->ventanas de 1 segundo co pasos de 0.5
        cfg.toi          = 0.5:0.5:343;                  %ventanas de tiempo (Centro de la ventana):  desde 1 hata 343 segundos(el tiempo final segun 88064 numero de mustras) con pasos de a 2 segundos segun el avance de ejeX
        
%         data.cfg              = [];
%         data.cfg.output       = 'pow';
%         data.cfg.channel      = 'all';
%         data.cfg.method       = 'mtmconvol';
%         data.cfg.taper        = 'hanning';
%         
%         data.cfg.pad          = 'nextpow2';
%          data.cfg.foi           =frange;    
%         data.cfg.t_ftimwin    = ones(length(data.cfg.foi),1);   %length of time window (in seconds) -> 1 segundo cada ventana para que se superpongan ->ventanas de 1 segundo co pasos de 0.5
%         data.cfg.toi          = 0.5:0.5:343;                 %ventanas de tiempo (Centro de la ventana):  desde 1 hata 343 segundos(el tiempo final segun 88064 numero de mustras) con pasos de a 2 segundos segun el avance de ejeX
        
%         data.cfg.method='mtmfft';
%         data.cfg.taper='hanning';
%         data.cfg.foi=1:2:30;    %ventanas de frecuencia
%         data.cfg.toi=1:0.5:343;  %ventanas de tiempo (Centro de la ventana):  desde 1 hata 343 segundos(el tiempo final segun 88064 numero de mustras) con pasos de a 2 segundos segun el avance de ejeX
%         data.cfg.t_ftimwin = ones(size(data.cfg.toi));  %length of time window (in seconds) -> 1 segundo cada ventana para que se superpongan ->ventanas de 1 segundo co pasos de 0.5
%         data.cfg.tapsmofrq = data.cfg.foi*0.4; %number, the amount of spectral smoothing through multi-tapering

        [freq] = ft_freqanalysis(cfg, data);
        
        %[data] = ft_preprocessing(suj.cfg, suj)
         
        if nombre(i)>medNom            %para nombre
            save([direcc,'\freqAnalysis\sujBuenosNom\s',num2str(i)], 'freq');
            buenosNom= [buenosNom i];
        elseif nombre(i)<=medNom 
           save([direcc,'\freqAnalysis\sujMalosNom\s',num2str(i)], 'freq');
           malosNom= [malosNom i];
        end

        if definicion(i)>medDef        %para definicion
            save([direcc,'\freqAnalysis\sujBuenosDef\s',num2str(i)], 'freq');
            buenosDef= [buenosDef i];
        elseif definicion(i)<=medDef    
            save([direcc,'\freqAnalysis\sujMalosDef\s',num2str(i)], 'freq');
            malosDef= [malosDef i];
        end         
     end
end

%% me guardo que cantidad hay en cada subgrupo
save([direcc,'\freqAnalysis\sujBuenosNom\buenosNom'], 'buenosNom');
save([direcc,'\freqAnalysis\sujMalosNom\malosNom'], 'malosNom');
save([direcc,'\freqAnalysis\sujBuenosDef\buenosDef'], 'buenosDef');
save([direcc,'\freqAnalysis\sujMalosDef\malosDef'],'malosDef');


% %%
% 
% charBuenosNom=[];
% charMalosNom=[];
% charBuenosDef=[];
% charMalosDef=[];
% 
% %convierto a un char con las estructuras de los sujetos de cada categoria
% %(buenos nombres, malos nombres, buenos definiciones, malos definiciones)
% 
% for i=1:23     
%      if i~=3 && i ~= 14 && i ~= 16 && i ~= 18  && i ~= 15 && i~=17    %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es igual a alguno no entra                 
%         if find(i==buenosNom) ~=0
%             sujF(i)=load(['D:\EEG\resting48hs\datosFieldtrip\datosFieldTripFreq\sujBuenosNom\s',num2str(i),'.mat']);
%             if i~=buenosNom(end)
%                 charBuenosNom=[charBuenosNom,'sujF(',num2str(i),').freq,'];
%             else
%                 charBuenosNom=[charBuenosNom,'sujF(',num2str(i),').freq'];
%             end
%         elseif find(i==malosNom) ~=0
%             sujF(i)=load(['D:\EEG\resting48hs\datosFieldtrip\datosFieldTripFreq\sujMalosNom\s',num2str(i),'.mat']);
%              if i~=malosNom(end)
%                 charMalosNom=[charMalosNom,'sujF(',num2str(i),').freq,'];
%             else
%                 charMalosNom=[charMalosNom,'sujF(',num2str(i),').freq'];
%              end
%         end
%         if find(i==buenosDef) ~=0
%             sujF(i)=load(['D:\EEG\resting48hs\datosFieldtrip\datosFieldTripFreq\sujBuenosDef\s',num2str(i),'.mat']);
%             if i~=buenosDef(end)
%                 charBuenosDef=[charBuenosDef 'sujF(',num2str(i),').freq,'];
%             else
%                 charBuenosDef=[charBuenosDef 'sujF(',num2str(i),').freq'];
%             end
%         elseif find(i==malosDef) ~=0
%             sujF(i)=load(['D:\EEG\resting48hs\datosFieldtrip\datosFieldTripFreq\sujMalosDef\s',num2str(i),'.mat']);
%             if i~=malosDef(end)
%                 charMalosDef=[charMalosDef,'sujF(',num2str(i),').freq,'];
%             else
%                 charMalosDef=[charMalosDef,'sujF(',num2str(i),').freq'];
%             end
%         end
%      end
% end  
% 
% freq.cfg.ivar                = 1; % the 1st row in cfg.design contains the independent variable
% freq.cfg.uvar               =[];
% freq.cfg.method='montecarlo';
% freq.cfg.statistic='indepsamplesT'; 
% freq.cfg.numrandomization ='all';
% freq.cfg.taper='hanning';
% freq.dimord='chan_freq';
% % data.cfg.design=size(data.trial);
% 
% Nsub=size(buenosNom,2); %defino el cfg.design
% sujF(buenosNom(1)).freq.cfg.design= [ones(1,Nsub)];
% 
% avgBn = ['ft_freqstatistics(sujF(buenosNom(1)).freq.cfg,',charBuenosNom,');'];  %corro todos los struct de buenos en nombres
% avgBuenosNom=eval(avgBn);
% 
% Nsub=size(malosNom,2); %defino el cfg.design
% sujF(malosNom(1)).cfg.freq.design= [ones(1,Nsub)];
% 
% avgMn = ['ft_freqstatistics(sujF(malosNom(1)).freq.cfg,',charMalosNom,');'];
% avgMalosNom=eval(avgMn);
% 
% Nsub=size(buenosDef,2); %defino el cfg.design
% sujF(buenosDef(1)).cfg.freq.design= [ones(1,Nsub)];
% 
% avgBd = ['ft_freqstatistics(sujF(buenosDef(1)).freq.cfg,',charBuenosDef,');'];
% avgBuenosDef=eval(avgBd);
% 
% Nsub=size(malosDef,2); %defino el cfg.design
% sujF(malosDef(1)).cfg.freq.design= [ones(1,Nsub)];
% 
% avgMd = ['ft_freqstatistics(sujF(malosDef(1)).freq.cfg,',charMalosDef,');'];
% avgMalosDef=eval(avgMd);
% 
% % %% hago freqstatistics
% % 
% % Nsub=17;
% % freq.cfg.design(1,1:2*Nsub)  = [ones(1,Nsub) 2*ones(1,Nsub)];
% % freq.cfg.ivar                = 1; % the 1st row in cfg.design contains the independent variable
% % freq.cfg.uvar                = 2; % the 2nd row in cfg.design contains the subject number
% % freqBn = ft_freqstatistics(avgBuenosNom.cfg,avgBuenosNom);  %corro todos los struct de buenos en nombres
% % 
% % 
% % freqMn = ['ft_freqstatistics(avgMalosNom.cfg,',charMalosNom,');'];
% % freqMalosNom=eval(freqMn);
% % 
% % freqBd = ['ft_freqstatistics(avgBuenosNom.cfg,',charBuenosDef,');'];
% % freqBuenosDef=eval(freqBd);
% % 
% % freqMd = ['ft_freqstatistics(avgMalosDef.cfg,',charMalosDef,');'];
% % freqMalosDef=eval(freqMd);
% %  
% % 
%  %data.cfg.method='channel';
% % data.cfg.statistic='indepsamplesT'; 
% % data.cfg.numrandomization ='all'
% % data.cfg.taper='dpss';
% % data.cfg.design=size(data.trial);
% 
% %%
% 
% %  [timelock] = ft_timelockanalysis(data.cfg,data)  
% % 
% %  timelock.cfg.method='montecarlo';
% % 
% % %[grandavg] = ft_timelockgrandaverage(timelock.cfg, timelock)
% % 
% % timelock.cfg.statistic   = 'indepsamplesT'   
% % 
% % timelock.cfg.numrandomization = 'all';
% % 
% % Nsub=88064;
% %  
% % timelock.cfg.design(1,1:2*Nsub)  = [ones(1,Nsub) 2*ones(1,Nsub)];
% % %timelock.cfg.design(2,1:2*Nsub)  = [1:Nsub 1:Nsub];
% % timelock.cfg.ivar                = 1; % the 1st row in cfg.design contains the independent variable
% % %timelock.cfg.uvar                = 2; % the 2nd row in cfg.design contains the subject number
% %  
% % %stat = ft_timelockstatistics(cfg,allsubjFIC{:},allsubjFC{:})
% % 
% % [stat] = ft_timelockstatistics(timelock.cfg,timelock);
% 
% %%
% 
% %data.cfg.taper='dpss';
% %data.cfg.design=size(data.trial);
% 
% %global polyorder 
% %polyorder=data.cfg.polyorder;
% 
% %%especificar en  ft_specest_mtmfft polyorder=2 %buscar como: esto agregaría porque no e lo sabe leer
% 



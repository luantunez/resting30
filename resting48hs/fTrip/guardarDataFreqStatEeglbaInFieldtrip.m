clear all
close all

%dir()

banda=6

%elijo frecuencia
if banda==1
frange=[1:0.2:3];  %delta
    direcc='D:\EEG\resting48hs\datosFieldtrip\delta';
elseif banda==2
    frange=[4:0.2:8];  %theta
    direcc='D:\EEG\resting48hs\datosFieldtrip\theta';
elseif banda==3
    frange=[8:0.2:12]; %alfa
    direcc='D:\EEG\resting48hs\datosFieldtrip\alfa';
elseif banda==4
     frange=[12:0.5:22]; %beta1
    direcc='D:\EEG\resting48hs\datosFieldtrip\beta1';
elseif banda==5
    frange=[22:0.5:35]; %beta2
    direcc='F:\pasantías Luchi\resting48hs\datosFieldtrip\beta2';
elseif banda==6
    frange=[1:1:35]; %total
    direcc='F:\pasantías Luchi\resting48hs\datosFieldtrip\total';
elseif banda==7
    frange=[4:1:35]; %totalCut
    direcc='F:\pasantías Luchi\resting48hs\datosFieldtrip\totalCut';
end 

addpath C:\Users\lucía\Documents\MATLAB\fieldtrip-20180815

charBuenosNom=[];
charMalosNom=[];
charBuenosDef=[];
charMalosDef=[];

buenosNom=load([direcc,'\freqAnalysis\sujBuenosNom\buenosNom'], 'buenosNom');
buenosNom=buenosNom.buenosNom;
malosNom=load([direcc,'\freqAnalysis\sujMalosNom\malosNom'], 'malosNom');
malosNom=malosNom.malosNom;
buenosDef=load([direcc,'\freqAnalysis\sujBuenosDef\buenosDef'], 'buenosDef');
buenosDef=buenosDef.buenosDef;
malosDef=load([direcc,'\freqAnalysis\sujMalosDef\malosDef'],'malosDef');
malosDef=malosDef.malosDef;

%convierto a un char con las estructuras de los sujetos de cada categoria
%(buenos nombres, malos nombres, buenos definiciones, malos definiciones)

for i=1:23     
     if i~=3 && i ~= 14 && i ~= 16 && i ~= 18  && i ~= 15 && i~=17    %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es igual a alguno no entra                 
        if find(i==buenosNom) ~=0
            sujF(i)=load([direcc,'\sujNormalizados\buenosNom\s',num2str(i),'.mat']);
            if i~=buenosNom(end)
                charBuenosNom=[charBuenosNom,'sujF(',num2str(i),').suj.sujFinE.freq,'];
            else
                charBuenosNom=[charBuenosNom,'sujF(',num2str(i),').suj.sujFinE.freq'];
            end
        elseif find(i==malosNom) ~=0
            sujF(i)=load([direcc,'\sujNormalizados\malosNom\s',num2str(i),'.mat']);
             if i~=malosNom(end)
                charMalosNom=[charMalosNom,'sujF(',num2str(i),').suj.sujFinE.freq,'];
            else
                charMalosNom=[charMalosNom,'sujF(',num2str(i),').suj.sujFinE.freq'];
             end
        end
        if find(i==buenosDef) ~=0
            sujF(i)=load([direcc,'\sujNormalizados\buenosDef\s',num2str(i),'.mat']);
            if i~=buenosDef(end)
                charBuenosDef=[charBuenosDef 'sujF(',num2str(i),').suj.sujFinE.freq,'];
            else
                charBuenosDef=[charBuenosDef 'sujF(',num2str(i),').suj.sujFinE.freq'];
            end
        elseif find(i==malosDef) ~=0
            sujF(i)=load([direcc,'\sujNormalizados\malosDef\s',num2str(i),'.mat']);
            if i~=malosDef(end)
                charMalosDef=[charMalosDef,'sujF(',num2str(i),').suj.sujFinE.freq,'];
            else
                charMalosDef=[charMalosDef,'sujF(',num2str(i),').suj.sujFinE.freq'];
            end
        end
     end
end  

%% hago freqgrandaverage para obtener los prmedios de las 4 categorias

% freq.cfg.ivar                = 1; % the 1st row in cfg.design contains the independent variable
% freq.cfg.uvar               =[];
% freq.cfg.method='montecarlo';
% freq.cfg.statistic='indepsamplesT'; 
% freq.cfg.numrandomization ='all';
% freq.cfg.taper='hanning';
% freq.dimord='subj_chan_freq_time';
% freq.cfg.keepindividual='yes';

cfg = [];
cfg.keepindividual     = 'yes';
cfg.foilim             = [frange(1) frange(end)];	

% data.cfg.design=size(data.trial);

Nsub=size(buenosNom,2); %defino el cfg.design
%sujF(buenosNom(1)).freq.cfg.design= [ones(1,Nsub)];
%cfg.design= [ones(1,Nsub)];

%% promedio en tiempos para hacer el freqgrandaverage

for i=1:23     
      if i~=3 && i ~= 14 && i ~= 16 && i ~= 18  && i ~= 15 && i~=17    
%      sujF(i).suj.freq.freq=mean(sujF(i).suj.freq.freq);
      sujF(i).suj.sujFinE.freq.time=mean(sujF(i).suj.sujFinE.freq.time);
      sujF(i).suj.sujFinE.freq.powspctrm=mean(sujF(i).suj.sujFinE.freq.powspctrm,3);
%      sujF(i).suj.freq.powspctrm=mean(sujF(i).suj.freq.powspctrm,2);
      sujF(i).suj.sujFinE.freq.powspctrm=squeeze(sujF(i).suj.sujFinE.freq.powspctrm);
      end
 end

avgBn = ['ft_freqgrandaverage(cfg,',charBuenosNom,');'];  %corro todos los struct de buenos en nombres
avgNom(1)=eval(avgBn);
%avgBuenosNom=eval(avgBn);

Nsub=size(malosNom,2); %defino el cfg.design
%sujF(malosNom(1)).cfg.freq.design= [ones(1,Nsub)];
%freq.cfg.design= [ones(1,Nsub)];

avgMn = ['ft_freqgrandaverage(cfg,',charMalosNom,');'];
avgNom(2)=eval(avgMn);
%avgMalosNom=eval(avgMn);

Nsub=size(buenosDef,2); %defino el cfg.design
%sujF(buenosDef(1)).cfg.freq.design= [ones(1,Nsub)];
%freq.cfg.design= [ones(1,Nsub)];

avgBd = ['ft_freqgrandaverage(cfg,',charBuenosDef,');'];
avgDef(1)=eval(avgBd);
% avgBuenosDef=eval(avgBd);

Nsub=size(malosDef,2); %defino el cfg.design
%sujF(malosDef(1)).cfg.freq.design= [ones(1,Nsub)];
%freq.cfg.design= [ones(1,Nsub)];

avgMd = ['ft_freqgrandaverage(cfg,',charMalosDef,');'];
avgDef(2)=eval(avgMd);
%avgMalosDef=eval(avgMd);

%% hago el freqstatistics para comparar buenos y malos

%nombres

cfg = [];

% prepare_neighbours determines what sensors may form clusters
cfg_neighb.method    = 'triangulation';
cfg_neighb.elec      = sujF(1).suj.sujFinE.freq.elec;
cfg.neighbours       = ft_prepare_neighbours(cfg_neighb, avgNom(1));
%  cfg.method          = 'triangulation';
%  cfg.elec            = elec;
%  neighbours = ft_neighbourselection(cfg, );
cfg.channel         = 'all';
cfg.latency         = 'all';
cfg.method          = 'montecarlo'; % use the Monte Carlo Method to calculate the significance probability
cfg.statistic       = 'ft_statfun_indepsamplesT';% use the independent samples T-statistic as a measure to evaluate 
%                      = ft_statfun_indepsamplesT                  % the effect at the sample level
cfg.frequency        = 'all';

cfg.correctm         = 'cluster';
cfg.clusteralpha     = 0.05;
cfg.clusterstatistic = 'maxsum';
cfg.minnbchan        = 2;
cfg.tail             = 0;
cfg.clustertail      = 0;
cfg.alpha            = 0.05;
cfg.numrandomization = 500;    %%%%%%%%%%%%
cfg.ivar            = 1;    

dsgn(1,:)=([ones(1,size(buenosNom,2)) ones(1,size(malosNom,2))*2]);
cfg.design=dsgn;

freqstNombres=ft_freqstatistics(cfg,avgNom(1),avgNom(2));   %uso cualquiera de los dos cfg
save([direcc,'\freqStatistics\freqstNombres'],'freqstNombres');

%definiciones

% avgBuenosDef.cfg.parameter='powspctrm';
% avgMalosDef.cfg.parameter='powspctrm';

dsgn(1,:)=([ones(1,size(buenosDef,2)) ones(1,size(malosDef,2))*2]);
cfg.design=dsgn;

%avgBuenosDef.cfg.design= [ones(1,Nsub)];
%avgMalosDef.cfg.design= [ones(1,Nsub)];

freqstDefiniciones=ft_freqstatistics(cfg,avgDef(1),avgDef(2)); 
save([direcc,'\freqStatistics\freqstDefiniciones'],'freqstDefiniciones');

%% poteo clusters con imagesc

if isfield(freqstNombres,'negclusters')
    imagesc(frange,[1:30],freqstNombres.posclusterslabelmat);
    title('Nombres posclusters');
    %set(gca,'xTickLabel',frange);
    figure()
    imagesc(frange,[1:30],freqstNombres.negclusterslabelmat);
    title('Nombres negclusters');
    %set(gca,'xTickLabel',frange);
    figure()
end

if isfield(freqstDefiniciones,'negclusters')
    imagesc(frange,[1:30],freqstDefiniciones.posclusterslabelmat);
    title('Definiciones posclusters');
    %set(gca,'xTickLabel',frange);
    figure()
    imagesc(frange,[1:30],freqstDefiniciones.negclusterslabelmat);
    title('Definiciones negclusters');
    %set(gca,'xTickLabel',frange);
end


% Nsub=88064;
% freq.cfg.design(1,1:2*Nsub)  = [ones(1,Nsub) 2*ones(1,Nsub)];
% freq.cfg.ivar                = 1; % the 1st row in cfg.design contains the independent variable
% freq.cfg.uvar               =2
% 
% avgBn = ['ft_freqstatistics(freq.cfg,',charBuenosNom,');'];  %corro todos los struct de buenos en nombres
% avgBuenosNom=eval(avgBn);
% 
% avgMn = ['ft_freqstatistics(freq.cfg,',charMalosNom,');'];
% avgMalosNom=eval(avgMn);
% 
% avgBd = ['ft_freqstatistics(freq.cfg,',charBuenosDef,');'];
% avgBuenosDef=eval(avgBd);
% 
% avgMd = ['ft_freqstatistics(freq.cfg,',charMalosDef,');'];
% avgMalosDef=eval(avgMd);
% 
% %% hago freqstatistics
% 
% Nsub=88064;
% avgBuenosNom.cfg.design(1,1:2*Nsub)  = [ones(1,Nsub) 2*ones(1,Nsub)];
% avgBuenosNom.cfg.ivar                = 1; % the 1st row in cfg.design contains the independent variable
% avgBuenosNom.cfg.uvar                = 2; % the 2nd row in cfg.design contains the subject number
% freqBn = ft_freqstatistics(avgBuenosNom.cfg,avgBuenosNom);  %corro todos los struct de buenos en nombres
% 
% 
% freqMn = ['ft_freqstatistics(avgMalosNom.cfg,',charMalosNom,');'];
% freqMalosNom=eval(freqMn);
% 
% freqBd = ['ft_freqstatistics(avgBuenosNom.cfg,',charBuenosDef,');'];
% freqBuenosDef=eval(freqBd);
% 
% freqMd = ['ft_freqstatistics(avgMalosDef.cfg,',charMalosDef,');'];
% freqMalosDef=eval(freqMd);
 
% 
 %data.cfg.method='channel';
% data.cfg.statistic='indepsamplesT'; 
% data.cfg.numrandomization ='all'
% data.cfg.taper='dpss';
% data.cfg.design=size(data.trial);

%%

%  [timelock] = ft_timelockanalysis(data.cfg,data)  
% 
%  timelock.cfg.method='montecarlo';
% 
% %[grandavg] = ft_timelockgrandaverage(timelock.cfg, timelock)
% 
% timelock.cfg.statistic   = 'indepsamplesT'   
% 
% timelock.cfg.numrandomization = 'all';
% 
% Nsub=88064;
%  
% timelock.cfg.design(1,1:2*Nsub)  = [ones(1,Nsub) 2*ones(1,Nsub)];
% %timelock.cfg.design(2,1:2*Nsub)  = [1:Nsub 1:Nsub];
% timelock.cfg.ivar                = 1; % the 1st row in cfg.design contains the independent variable
% %timelock.cfg.uvar                = 2; % the 2nd row in cfg.design contains the subject number
%  
% %stat = ft_timelockstatistics(cfg,allsubjFIC{:},allsubjFC{:})
% 
% [stat] = ft_timelockstatistics(timelock.cfg,timelock);

%%

%data.cfg.taper='dpss';
%data.cfg.design=size(data.trial);

%global polyorder 
%polyorder=data.cfg.polyorder;

%%especificar en  ft_specest_mtmfft polyorder=2 %buscar como: esto agregaría porque no e lo sabe leer


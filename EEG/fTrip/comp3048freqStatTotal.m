clear all
close all

%dir()

banda=6

%elijo frecuencia
if banda==1
frange=[1:0.2:3];  %delta
    direcc30='F:\pasantías Luchi\resting\datosFieldtrip\delta';
    direcc48='F:\pasantías Luchi\resting48hs\datosFieldtrip\delta';
elseif banda==2
    frange=[4:0.2:8];  %theta
    direcc30='F:\pasantías Luchi\resting\datosFieldtrip\theta';
    direcc48='F:\pasantías Luchi\resting48hs\datosFieldtrip\theta';
elseif banda==3
    frange=[8:0.2:12]; %alfa
    direcc30='F:\pasantías Luchi\resting\datosFieldtrip\alfa';
    direcc48='F:\pasantías Luchi\resting48hs\datosFieldtrip\alfa';
elseif banda==4
     frange=[12:0.5:22]; %beta1
    direcc30='F:\pasantías Luchi\resting\datosFieldtrip\beta1';
    direcc48='F:\pasantías Luchi\resting48hs\datosFieldtrip\beta1';
elseif banda==5
    frange=[22:0.5:35]; %beta2
    direcc30='F:\pasantías Luchi\resting\datosFieldtrip\beta2';
    direcc48='F:\pasantías Luchi\resting48hs\datosFieldtrip\beta2';
elseif banda==6
    frange=[1:1:35]; %total
    direcc30='F:\pasantías Luchi\resting\datosFieldtrip\total';
    direcc48='F:\pasantías Luchi\resting48hs\datosFieldtrip\total';
elseif banda==7
    frange=[4:1:35]; %total
    direcc30='F:\pasantías Luchi\resting\datosFieldtrip\totalCut';
    direcc48='F:\pasantías Luchi\resting48hs\datosFieldtrip\totalCut';
end   

addpath C:\Users\lucía\Documents\MATLAB\fieldtrip-20180815

char30=[];

buenosNom=load([direcc30,'\datosEeglab\sujBuenosNom\buenosNom'], 'buenosNom');
buenosNom=buenosNom.buenosNom;
buenosNom30=buenosNom;   %lo uso para el design
malosNom=load([direcc30,'\datosEeglab\sujMalosNom\malosNom'], 'malosNom');
malosNom=malosNom.malosNom;
malosNom30=malosNom;
buenosDef=load([direcc30,'\datosEeglab\sujBuenosDef\buenosDef'], 'buenosDef');
buenosDef=buenosDef.buenosDef;
buenosDef30=buenosDef;
malosDef=load([direcc30,'\datosEeglab\sujMalosDef\malosDef'],'malosDef');
malosDef=malosDef.malosDef;
malosDef30=malosDef;

%convierto a un char con las estructuras de los sujetos de cada categoria
%(buenos nombres, malos nombres, buenos definiciones, malos definiciones)

%% 30 minutos

for i=1:34 
     if i~=[18 28 30 4 16 32]     %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es igual a alguno no entra                 
     
         if find(i==buenosNom) ~=0
            sujF(i)=load([direcc30,'\sujNormalizados\buenosNom\s',num2str(i),'.mat']);
            if i~=buenosNom(end)
                char30=[char30,'sujF(',num2str(i),').suj.sujFinE.freq,'];
            else
                char30=[char30,'sujF(',num2str(i),').suj.sujFinE.freq'];   %vi que el ultimo sujeto esta aca
            end
        elseif find(i==malosNom) ~=0
            sujF(i)=load([direcc30,'\sujNormalizados\malosNom\s',num2str(i),'.mat']);
                char30=[char30,'sujF(',num2str(i),').suj.sujFinE.freq,'];
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

Nsub30=size(malosNom,2)+size(buenosNom,2); %defino el cfg.design
%sujF(buenosNom(1)).freq.cfg.design= [ones(1,Nsub)];
%cfg.design= [ones(1,Nsub)];

%% promedio en tiempos para hacer el freqgrandaverage

for i=1:34 
     if i~=[18 28 30 4 16 32]     %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es igual a alguno no entra                 
     
%      sujF(i).suj.freq.freq=mean(sujF(i).suj.freq.freq);
      sujF(i).suj.sujFinE.freq.time=mean(sujF(i).suj.sujFinE.freq.time);
      sujF(i).suj.sujFinE.freq.powspctrm=mean(sujF(i).suj.sujFinE.freq.powspctrm,3);
%      sujF(i).suj.freq.powspctrm=mean(sujF(i).suj.freq.powspctrm,2);
      sujF(i).suj.sujFinE.freq.powspctrm=squeeze(sujF(i).suj.sujFinE.freq.powspctrm);
      end
 end

avg30 = ['ft_freqgrandaverage(cfg,',char30,');'];  %corro todos los struct para 30 min
avg30=eval(avg30);
%avgBuenosNom=eval(avgBn);


%% 48 horas

char48=[];

buenosNom=load([direcc48,'\freqAnalysis\sujBuenosNom\buenosNom'], 'buenosNom');
buenosNom=buenosNom.buenosNom;
buenosNom48=buenosNom;
malosNom=load([direcc48,'\freqAnalysis\sujMalosNom\malosNom'], 'malosNom');
malosNom=malosNom.malosNom;
malosNom48=malosNom;
buenosDef=load([direcc48,'\freqAnalysis\sujBuenosDef\buenosDef'], 'buenosDef');
buenosDef=buenosDef.buenosDef;
buenosDef48=buenosDef;
malosDef=load([direcc48,'\freqAnalysis\sujMalosDef\malosDef'],'malosDef');
malosDef=malosDef.malosDef;
malosDef48=malosDef;

%convierto a un char con las estructuras de los sujetos de cada categoria
%(buenos nombres, malos nombres, buenos definiciones, malos definiciones)

for i=1:23     
     if i~=3 && i ~= 14 && i ~= 16 && i ~= 18  && i ~= 15 && i~=17    %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es igual a alguno no entra                 
        if find(i==buenosNom) ~=0
            sujF(i)=load([direcc48,'\sujNormalizados\buenosNom\s',num2str(i),'.mat']);
            if i~=buenosNom(end)
                char48=[char48,'sujF(',num2str(i),').suj.sujFinE.freq,'];
            else
                char48=[char48,'sujF(',num2str(i),').suj.sujFinE.freq'];    %vi que el ultimo sujeto esta aca
            end
        elseif find(i==malosNom) ~=0
            sujF(i)=load([direcc48,'\sujNormalizados\malosNom\s',num2str(i),'.mat']);
                char48=[char48,'sujF(',num2str(i),').suj.sujFinE.freq,'];
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

Nsub48=size(malosNom,2)+size(buenosNom,2); %defino el cfg.design
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

avg48= ['ft_freqgrandaverage(cfg,',char48,');'];  %corro todos los struct de buenos en nombres
avg48=eval(avg48);
%avgBuenosNom=eval(avgBn);

%% hago el freqstatistics para comparar 30 minutos y 48 horas

%nombres

cfg = [];

% prepare_neighbours determines what sensors may form clusters
cfg_neighb.method    = 'triangulation';
cfg_neighb.elec      = sujF(1).suj.sujFinE.freq.elec;
cfg.neighbours       = ft_prepare_neighbours(cfg_neighb, avg30);  %%%%%%%%%%%%%%%%%%%%%esta bien el neigh? 
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

dsgn(1,:)=([ones(1,Nsub30) ones(1,Nsub48)*2]);
cfg.design=dsgn;

freqst3048=ft_freqstatistics(cfg,avg30,avg48);   %uso cualquiera de los dos cfg
save([direcc30,'\freqStatistics\freqstTotal3048'],'freqst3048');

%% poteo clusters con imagesc

if isfield(freqst3048,'negclusters')
    imagesc(frange,[1:30],freqst3048.posclusterslabelmat);
    title('posclusters');
    %set(gca,'xTickLabel',frange);
    figure()
    imagesc(frange,[1:30],freqst3048.negclusterslabelmat);
    title('negclusters');
    %set(gca,'xTickLabel',frange);
    figure()
    imagesc(frange,[1:30],[freqst3048.posclusterslabelmat+freqst3048.negclusterslabelmat+freqst3048.negclusterslabelmat]);  %lo sumo para darle otro color
end
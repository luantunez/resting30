clear all
close all

%dir()

banda=6

%elijo frecuencia
if banda==1
frange=[1:0.2:3];  %delta
    direcc30='F:\pasantías Luchi\resting\datosFieldtrip\delta';
    direcc48='D:\EEG\resting48hs\datosFieldtrip\delta';
elseif banda==2
    frange=[4:0.2:8];  %theta
    direcc30='F:\pasantías Luchi\resting\datosFieldtrip\theta';
    direcc48='D:\EEG\resting48hs\datosFieldtrip\theta';
elseif banda==3
    frange=[8:0.2:12]; %alfa
    direcc30='F:\pasantías Luchi\resting\datosFieldtrip\alfa';
    direcc48='D:\EEG\resting48hs\datosFieldtrip\alfa';
elseif banda==4
     frange=[12:0.5:22]; %beta1
    direcc30='F:\pasantías Luchi\resting\datosFieldtrip\beta1';
    direcc48='D:\EEG\resting48hs\datosFieldtrip\beta1';
elseif banda==5
    frange=[22:0.5:35]; %beta2
    direcc30='F:\pasantías Luchi\resting\datosFieldtrip\beta2';
    direcc48='D:\EEG\resting48hs\datosFieldtrip\beta2';
elseif banda==6
    frange=[1:1:35]; %total
    direcc30='F:\pasantías Luchi\resting\datosFieldtrip\total';
    direcc48='F:\pasantías Luchi\resting48hs\datosFieldtrip\total';
elseif banda==7
    frange=[4:1:35]; %total
    direcc30='F:\pasantías Luchi\resting\datosFieldtrip\totalCut';
    direcc48='D:\EEG\resting48hs\datosFieldtrip\totalCut';
end   

addpath C:\Users\lucía\Documents\MATLAB\fieldtrip-20180815

charBuenosNom=[];
charMalosNom=[];
charBuenosDef=[];
charMalosDef=[];

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
                charBuenosNom=[charBuenosNom,'sujF(',num2str(i),').suj.sujFinE.freq,'];
            else
                charBuenosNom=[charBuenosNom,'sujF(',num2str(i),').suj.sujFinE.freq'];
            end
        elseif find(i==malosNom) ~=0
            sujF(i)=load([direcc30,'\sujNormalizados\malosNom\s',num2str(i),'.mat']);
             if i~=malosNom(end)
                charMalosNom=[charMalosNom,'sujF(',num2str(i),').suj.sujFinE.freq,'];
            else
                charMalosNom=[charMalosNom,'sujF(',num2str(i),').suj.sujFinE.freq'];
             end
        end
        if find(i==buenosDef) ~=0
            sujF(i)=load([direcc30,'\sujNormalizados\buenosDef\s',num2str(i),'.mat']);
            if i~=buenosDef(end)
                charBuenosDef=[charBuenosDef 'sujF(',num2str(i),').suj.sujFinE.freq,'];
            else
                charBuenosDef=[charBuenosDef 'sujF(',num2str(i),').suj.sujFinE.freq'];
            end
        elseif find(i==malosDef) ~=0
            sujF(i)=load([direcc30,'\sujNormalizados\malosDef\s',num2str(i),'.mat']);
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

for i=1:34 
     if i~=[18 28 30 4 16 32]     %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es igual a alguno no entra                 
     
%      sujF(i).suj.freq.freq=mean(sujF(i).suj.freq.freq);
      sujF(i).suj.sujFinE.freq.time=mean(sujF(i).suj.sujFinE.freq.time);
      sujF(i).suj.sujFinE.freq.powspctrm=mean(sujF(i).suj.sujFinE.freq.powspctrm,3);
%      sujF(i).suj.freq.powspctrm=mean(sujF(i).suj.freq.powspctrm,2);
      sujF(i).suj.sujFinE.freq.powspctrm=squeeze(sujF(i).suj.sujFinE.freq.powspctrm);
      end
 end

avgBn = ['ft_freqgrandaverage(cfg,',charBuenosNom,');'];  %corro todos los struct de buenos en nombres
avgNom30(1)=eval(avgBn);
%avgBuenosNom=eval(avgBn);

Nsub=size(malosNom,2); %defino el cfg.design
%sujF(malosNom(1)).cfg.freq.design= [ones(1,Nsub)];
%freq.cfg.design= [ones(1,Nsub)];

avgMn = ['ft_freqgrandaverage(cfg,',charMalosNom,');'];
avgNom30(2)=eval(avgMn);
%avgMalosNom=eval(avgMn);

Nsub=size(buenosDef,2); %defino el cfg.design
%sujF(buenosDef(1)).cfg.freq.design= [ones(1,Nsub)];
%freq.cfg.design= [ones(1,Nsub)];

avgBd = ['ft_freqgrandaverage(cfg,',charBuenosDef,');'];
avgDef30(1)=eval(avgBd);
% avgBuenosDef=eval(avgBd);

Nsub=size(malosDef,2); %defino el cfg.design
%sujF(malosDef(1)).cfg.freq.design= [ones(1,Nsub)];
%freq.cfg.design= [ones(1,Nsub)];

avgMd = ['ft_freqgrandaverage(cfg,',charMalosDef,');'];
avgDef30(2)=eval(avgMd);
%avgMalosDef=eval(avgMd);

%% 48 horas

charBuenosNom=[];
charMalosNom=[];
charBuenosDef=[];
charMalosDef=[];

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
                charBuenosNom=[charBuenosNom,'sujF(',num2str(i),').suj.sujFinE.freq,'];
            else
                charBuenosNom=[charBuenosNom,'sujF(',num2str(i),').suj.sujFinE.freq'];
            end
        elseif find(i==malosNom) ~=0
            sujF(i)=load([direcc48,'\sujNormalizados\malosNom\s',num2str(i),'.mat']);
             if i~=malosNom(end)
                charMalosNom=[charMalosNom,'sujF(',num2str(i),').suj.sujFinE.freq,'];
            else
                charMalosNom=[charMalosNom,'sujF(',num2str(i),').suj.sujFinE.freq'];
             end
        end
        if find(i==buenosDef) ~=0
            sujF(i)=load([direcc48,'\sujNormalizados\buenosDef\s',num2str(i),'.mat']);
            if i~=buenosDef(end)
                charBuenosDef=[charBuenosDef 'sujF(',num2str(i),').suj.sujFinE.freq,'];
            else
                charBuenosDef=[charBuenosDef 'sujF(',num2str(i),').suj.sujFinE.freq'];
            end
        elseif find(i==malosDef) ~=0
            sujF(i)=load([direcc48,'\sujNormalizados\malosDef\s',num2str(i),'.mat']);
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
avgNom48(1)=eval(avgBn);
%avgBuenosNom=eval(avgBn);

Nsub=size(malosNom,2); %defino el cfg.design
%sujF(malosNom(1)).cfg.freq.design= [ones(1,Nsub)];
%freq.cfg.design= [ones(1,Nsub)];

avgMn = ['ft_freqgrandaverage(cfg,',charMalosNom,');'];
avgNom48(2)=eval(avgMn);
%avgMalosNom=eval(avgMn);

Nsub=size(buenosDef,2); %defino el cfg.design
%sujF(buenosDef(1)).cfg.freq.design= [ones(1,Nsub)];
%freq.cfg.design= [ones(1,Nsub)];

avgBd = ['ft_freqgrandaverage(cfg,',charBuenosDef,');'];
avgDef48(1)=eval(avgBd);
% avgBuenosDef=eval(avgBd);

Nsub=size(malosDef,2); %defino el cfg.design
%sujF(malosDef(1)).cfg.freq.design= [ones(1,Nsub)];
%freq.cfg.design= [ones(1,Nsub)];

avgMd = ['ft_freqgrandaverage(cfg,',charMalosDef,');'];
avgDef48(2)=eval(avgMd);
%avgMalosDef=eval(avgMd);

%% hago el freqstatistics para comparar 30 minutos y 48 horas

%nombres

cfg = [];

% prepare_neighbours determines what sensors may form clusters
cfg_neighb.method    = 'triangulation';
cfg_neighb.elec      = sujF(1).suj.sujFinE.freq.elec;
cfg.neighbours       = ft_prepare_neighbours(cfg_neighb, avgNom30(1));  %%%%%%%%%%%%%%%%%%%%%esta bien el neigh? 
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

dsgn(1,:)=([ones(1,size(buenosNom30,2)) ones(1,size(buenosNom48,2))*2]);
cfg.design=dsgn;

freqstBuenosNombres3048=ft_freqstatistics(cfg,avgNom30(1),avgNom48(1));   %uso cualquiera de los dos cfg
save([direcc30,'\freqStatistics\freqstBuenosNombres3048'],'freqstBuenosNombres3048');

clear dsgn;
dsgn(1,:)=([ones(1,size(malosNom30,2)) ones(1,size(malosNom48,2))*2]);
cfg.design=dsgn;

freqstMalosNombres3048=ft_freqstatistics(cfg,avgNom30(2),avgNom48(2));   %uso cualquiera de los dos cfg
save([direcc30,'\freqStatistics\freqstMalosNombres3048'],'freqstMalosNombres3048');

%definiciones

% avgBuenosDef.cfg.parameter='powspctrm';
% avgMalosDef.cfg.parameter='powspctrm';

clear dsgn;
dsgn(1,:)=([ones(1,size(buenosDef30,2)) ones(1,size(buenosDef48,2))*2]);
cfg.design=dsgn;

%avgBuenosDef.cfg.design= [ones(1,Nsub)];
%avgMalosDef.cfg.design= [ones(1,Nsub)];

freqstBuenosDefiniciones3048=ft_freqstatistics(cfg,avgDef30(1),avgDef48(1)); 
save([direcc30,'\freqStatistics\freqstBuenosDefiniciones3048'],'freqstBuenosDefiniciones3048');

clear dsgn;
dsgn(1,:)=([ones(1,size(malosDef30,2)) ones(1,size(malosDef48,2))*2]);
cfg.design=dsgn;

freqstMalosDefiniciones3048=ft_freqstatistics(cfg,avgDef30(2),avgDef48(2)); 
save([direcc30,'\freqStatistics\freqstMalosDefiniciones3048'],'freqstMalosDefiniciones3048');

%% poteo clusters con imagesc

if isfield(freqstBuenosNombres3048,'negclusters')
    imagesc(freqstBuenosNombres3048.posclusterslabelmat);
    title('Buenos Nombres posclusters');
    set(gca,'xTickLabel',frange);
    figure()
    imagesc(freqstBuenosNombres3048.negclusterslabelmat);
    title('Buenos Nombres negclusters');
    set(gca,'xTickLabel',frange);
    figure()
end

if isfield(freqstMalosNombres3048,'negclusters')
    imagesc(freqstMalosNombres3048.posclusterslabelmat);
    title('Malos Nombres posclusters');
    set(gca,'xTickLabel',frange);
    figure()
    imagesc(freqstMalosNombres3048.negclusterslabelmat);
    title('Malos Nombres negclusters');
    set(gca,'xTickLabel',frange);
    figure()
end


if isfield(freqstBuenosDefiniciones3048,'negclusters')
    imagesc(freqstBuenosDefiniciones3048.posclusterslabelmat);
    title('Buenos Definiciones posclusters');
    set(gca,'xTickLabel',frange);
    figure()
    imagesc(freqstBuenosDefiniciones3048.negclusterslabelmat);
    title('Buenos Definiciones negclusters');
    set(gca,'xTickLabel',frange);
    figure()
end

if isfield(freqstMalosDefiniciones3048,'negclusters')
    imagesc(freqstMalosDefiniciones3048.posclusterslabelmat);
    title('Malos Definiciones posclusters');
    set(gca,'xTickLabel',frange);
    figure()
    imagesc(freqstMalosDefiniciones3048.negclusterslabelmat);
    title('Malos Definiciones negclusters');
    set(gca,'xTickLabel',frange);
end


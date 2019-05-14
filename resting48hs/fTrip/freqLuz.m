close all
clear all
clc
cond       = 2;
numsu      = [3 4];
carpeta    = '/media/usuario/90F430A9F4309386/Documents and Settings/Usuario/Documents/Lucia/sujetos/';


%% configuración
cfg = [];
cfg.keepindividual     = 'yes';
cfg.foilim             = [8 12];	
% cfgplot.zlim         = [-50 500];	
%cfgplot.channel      = 'all';
addpath('/home/usuario/matlab/fieldtrip/')
% addpath('/home/usuario/matlab/fieldtrip/private')
for c=1:cond
    str = [];
    for ss=1: numsu(c)  
        s=(c-1)*numsu(1)+ss;
       load(['D:\EEG\resting48hs\datosFieldtrip\delta\freqAnalysis\luz','/','s',num2str(s),'.mat'])
       %energias = TFRdata.powspctrm; 
       temp = TFRdata; 
       str=[str temp];     
       canales = TFRdata.elec;
       clear TFRdata temp
       
    end
   if c==1
        grandavg(c)=ft_freqgrandaverage(cfg,str(1),str(2),str(3));
   elseif c==2
        grandavg(c)=ft_freqgrandaverage(cfg,str(1),str(2),str(3),str(4));
    end
end


%% Defino parámetros para la estadística

cfg = [];

% Esto me gusta mas ahora 
% prepare_neighbours determines what sensors may form clusters
cfg_neighb.method    = 'triangulation';
cfg_neighb.elec      = canales;
cfg.neighbours       = ft_prepare_neighbours(cfg_neighb, grandavg(1));
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
cfg.alpha            = 0.025;
cfg.numrandomization = 500;

design = zeros(1,sum(numsu));
% design(1,:)          = 1: sum(numsu);
design(1,1:numsu(1))          = 1;
design(1,numsu(1)+1:numsu(2)+numsu(1)) = 2;
cfg.design          = design;
cfg.ivar            = 1;      
freq1=grandavg(1);freq2=grandavg(2);
[stat] = ft_freqstatistics(cfg, freq1, freq2);

%% Grafica

newalpha =  0.05; %stat.cfg.alpha;
% Make a vector of all p-values associated with the clusters from ft_timelockstatistics.
pos_cluster_pvals = [stat.posclusters(:).prob];
    % Then, find which clusters are significant, outputting their indices as held in stat.posclusters
pos_signif_clust = sum(pos_cluster_pvals < newalpha)
% size(pos_signif_clust )
    % (stat.cfg.alpha is the alpha level we specified earlier for cluster comparisons; In this case, 0.025)
    % make a boolean matrix of which (channel,time)-pairs are part of a significant cluster
pos = ismember(stat.posclusterslabelmat, pos_signif_clust);
pos2 = stat.posclusterslabelmat;
media    = squeeze(mean(pos2,2));
mediaPos = squeeze(mean(pos,2));
 media(mediaPos==0)=0;
    figure;
        imagesc(media) % matriz de canales por tiempos con el numero de cluster al que pertence cada sample
    colorbar
%%
% cfg = [];
% cfg.alpha  = 0.025;
% cfg.parameter = 'avg';
% cfg.zlim   = [-1e-27 1e-27];
% cfg.elec = canales;
% temp = stat;
% ft_clusterplot(cfg, stat);


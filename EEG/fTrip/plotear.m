close all
clear all

banda=6

%elijo frecuencia
if banda==1
frange=[1:0.2:3];  %delta
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\delta';
    scal= [-10 10];
elseif banda==2
    frange=[4:0.2:8];  %theta
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\theta';
    scal= [-10 10];
elseif banda==3
    frange=[8:0.2:12]; %alfa
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\alfa';
    scal= [-10 10];
elseif banda==4
     frange=[12:0.5:22]; %beta1
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\beta1';
    scal= [-10 10];
elseif banda==5
    frange=[22:0.5:35]; %beta2
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\beta2';
    scal= [-10 10];
elseif banda==6
    frange=[1:1:35]; %total
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\total';
    scal= [-10 10];
elseif banda==7
    frange=[4:1:35]; %total
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\totalCut';
    scal= [-10 10];
end   

addpath C:\Users\lucía\Documents\MATLAB\fieldtrip-20180815
addpath C:\Users\lucía\Documents\MATLAB\fieldtrip-20180815\plotting

statNom=load([direcc,'\freqStatistics\freqstNombres'],'freqstNombres');
statNom=statNom.freqstNombres;
statDef=load([direcc,'\freqStatistics\freqstDefiniciones'],'freqstDefiniciones');
statDef=statDef.freqstDefiniciones;

% cfg = [];
% cfg.alpha  = 0.025;
% cfg.parameter = 'stat';
% cfg.zlim   = [-4 4];
% cfg.layout = 'CTF151_helmet.mat';
% 
% %statNom.dimord='powspctrm';
% 
% statNom.freq=mean(statNom.freq,2)
% 
% newalpha =  0.05; %stat.cfg.alpha;
% % Make a vector of all p-values associated with the clusters from ft_timelockstatistics.
% pos_cluster_pvals = [statNom.posclusters(:).prob];
%     % Then, find which clusters are significant, outputting their indices as held in stat.posclusters
% pos_signif_clust = sum(pos_cluster_pvals < newalpha)
% % size(pos_signif_clust )
%     % (stat.cfg.alpha is the alpha level we specified earlier for cluster comparisons; In this case, 0.025)
%     % make a boolean matrix of which (channel,time)-pairs are part of a significant cluster
% pos = ismember(statNom.posclusterslabelmat, pos_signif_clust);
% pos2 = statNom.posclusterslabelmat;
% media    = squeeze(mean(pos2,2));
% mediaPos = squeeze(mean(pos,2));
%  media(mediaPos==0)=0;
%     figure;
%         imagesc(media) % matriz de canales por tiempos con el numero de cluster al que pertence cada sample
%     colorbar
%     
  %%
  

cfg = [];
cfg.alpha  = 0.05;
cfg.parameter = 'stat';    %%en internet me marca stat, pero igual no me toma el dimord
%cfg.xlim = [0.3 0.5];                
cfg.zlim =scal; 
cfg.layout = '30locations.lay';
cfg.layout = ft_prepare_layout(cfg);


%grad = ft_read_sens('30locations.mat');
    
%ft_plot_lay(cfg.layout)  
% cfg.baseline = [-0.5 -0.1];
% cfg.baselinetype = 'absolute';                            
% cfg.marker = 'numbers'; 
% %cfg.markersize=5;
% cfg.markerfontsize=6;
% %cfg.highlight='numbers';

cfg.highlightseries           = {'numbers' 'numbers' 'numbers' 'numbers' 'numbers'} ;
cfg.highlightsymbolseries     = ['o', 'o', 'o', 'o', 'o']; %marker symbol series
cfg.highlightsizeseries       = [6 6 6 6 6]; %marker size series  
cfg.highlightcolorpos         = [1 1 1]; %color of highlight marker for positive clusters 
cfg.highlightcolorneg         =  [2 2 2]; %color of highlight marker for negative clusters 
cfg.subplotsize               = [2 2];%layout of subplots ([h w])
cfg.saveaspng                 = 'rta';


% if isfield(statNom,'negclusters')
% figure('name', 'nombres');
% ft_clusterplot(cfg, statNom);
% %subtitle('nombres');
% end

if isfield(statDef,'negclusters')
figure('name', 'definiciones');
ft_clusterplot(cfg, statDef);
%subtitle('definiciones');
end
close all
clear all

banda=7

case2plot=4
%1=buenos en nombres
%2=malos en nombres
%3=buenos en definiciones
%4malos en definiciones

%elijo frecuencia
if banda==1
frange=[1:0.2:3];  %delta
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\delta';
    scal= [-5 1];
elseif banda==2
    frange=[4:0.2:8];  %theta
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\theta';
    scal= [-3 5];
elseif banda==3
    frange=[8:0.2:12]; %alfa
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\alfa';
    scal= [1 3];
elseif banda==4
     frange=[12:0.5:22]; %beta1
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\beta1';
    scal= [-10 10];
elseif banda==5
    frange=[22:0.5:35]; %beta2
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\beta2';
    scal= [-4 -1];
elseif banda==6
    frange=[1:1:35]; %total
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\total';
    scal= [-4 2];
elseif banda==7
    frange=[4:1:35]; %total
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\totalCut';
    scal= [-4 2];
end   

addpath C:\Users\lucía\Documents\MATLAB\fieldtrip-20180815
addpath C:\Users\lucía\Documents\MATLAB\fieldtrip-20180815\plotting

statBnom=load([direcc,'\freqStatistics\freqstBuenosNombres3048'],'freqstBuenosNombres3048');
statBnom=statBnom.freqstBuenosNombres3048;

statMnom=load([direcc,'\freqStatistics\freqstMalosNombres3048'],'freqstMalosNombres3048');
statMnom=statMnom.freqstMalosNombres3048;

statBdef=load([direcc,'\freqStatistics\freqstBuenosDefiniciones3048'],'freqstBuenosDefiniciones3048');
statBdef=statBdef.freqstBuenosDefiniciones3048;

statMdef=load([direcc,'\freqStatistics\freqstMalosDefiniciones3048'],'freqstMalosDefiniciones3048');
statMdef=statMdef.freqstMalosDefiniciones3048;


  %%
  

cfg = [];
cfg.alpha  = 0.05;
cfg.parameter = 'stat';    %%en internet me marca stat, pero igual no me toma el dimord
%cfg.xlim = [0.3 0.5];                
cfg.zlim =scal; 
cfg.layout = '30locations.lay';
cfg.layout = ft_prepare_layout(cfg);


cfg.highlightseries           = {'numbers' 'numbers' 'numbers' 'numbers' 'numbers'} ;
cfg.highlightsymbolseries     = ['o', 'o', 'o', 'o', 'o']; %marker symbol series
cfg.highlightsizeseries       = [6 6 6 6 6]; %marker size series  
cfg.highlightcolorpos         = [1 1 1]; %color of highlight marker for positive clusters 
cfg.highlightcolorneg         =  [2 2 2]; %color of highlight marker for negative clusters 
cfg.subplotsize               = [2 2];%layout of subplots ([h w])
cfg.saveaspng                 = 'rta';


if case2plot==1

    if isfield(statBnom,'negclusters')
    figure('name', 'nombres');
    ft_clusterplot(cfg, statBnom);
    %title('buenos nombres');
    end

elseif case2plot==2

    if isfield(statMnom,'negclusters')
    figure('name', 'nombres');
    ft_clusterplot(cfg, statMnom);
    %title('malos nombres');
    end

elseif case2plot==3

    if isfield(statBdef,'negclusters')
    figure('name', 'definiciones');
    ft_clusterplot(cfg, statBdef);
    %title('buenos definiciones');
    end

elseif case2plot==4

    if isfield(statMdef,'negclusters')
    figure('name', 'definiciones');
    ft_clusterplot(cfg, statMdef);
    %title('malos definiciones');
    end

end

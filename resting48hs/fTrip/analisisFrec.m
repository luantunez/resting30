freq.cfg.method='montecarlo';
freq.cfg.taper='hanning';
freq.cfg.statistic='indepsamplesT'; 
freq.cfg.numrandomization ='all'

%[grandavg] = ft_timelockgrandaverage(timelock.cfg, timelock)

%freq.cfg.statistic   = 'indepsamplesT'   

%freq.cfg.numrandomization = 'all';

Nsub=88064;
 
freq.cfg.design(1,1:2*Nsub)  = [ones(1,Nsub) 2*ones(1,Nsub)];
%timelock.cfg.design(2,1:2*Nsub)  = [1:Nsub 1:Nsub];
freq.cfg.ivar                = 1; % the 1st row in cfg.design contains the independent variable
%timelock.cfg.uvar                = 2; % the 2nd row in cfg.design contains the subject number

[stat] = ft_freqstatistics(freq.cfg, freq)
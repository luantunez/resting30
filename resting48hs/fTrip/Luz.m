close all
clear all
clc
cond  = {'RX' 'RXx2' 'RCTX'};
numsu = [13 15 13];
carpeta = '/media/usuario/90F430A9F4309386/Documents and Settings/Usuario/Documents/chile_silabas/DATA/';
%% Configuración
cfg              = [];
cfg.output       = 'pow';
cfg.channel      = 'all';
cfg.method       = 'mtmconvol';
cfg.taper        = 'hanning';
cfg.pad          = 'nextpow2';
cfg.foi          = [1:0.5:12 13:1:47 55:2:100];   % Todas las bandas de frecuencia
cfg.t_ftimwin    = ones(length(cfg.foi),1).*0.5;   % length of time window = 0.5 sec
cfg.toi          = 0:0.5:600;                  % time window "slides" from -0.5 to 1.5 sec in steps of 0.05 sec (50 ms)
%%
for c=1:length(cond)
    for s=1:numsu(c)
        for b=1:2
            clear EEG data TFRdata
            addpath('/home/usuario/matlab/eeglab13_5_4b/')
            eeglab
% Levanto un dato cualquiera para tenes la estructura de EEGLAB
            EEG = pop_loadset('filename', ['bl',num2str(b),'_suj',num2str(s),'_ICA_removed_end.set'],...
                'filepath', [carpeta,cond{c},'/set_preana']);
            EEG = eeg_checkset( EEG );
            rmpath('/home/usuario/matlab/eeglab13_5_4b/');
            addpath('/home/usuario/matlab/fieldtrip/')
            data=eeglab2fieldtrip(EEG,'preprocessing');           
            TFRdata = ft_freqanalysis(cfg, data);
            save([carpeta,cond{c},'/set_preana/TFRhann_suj',num2str(s),'_bl',num2str(b),'.mat'],'TFRdata')
            rmpath('/home/usuario/matlab/fieldtrip/');
        end
    end
end


function EEG = preanalisis_lab(sujname,whichstep,params)

%addpath('/home/usuario/matlab/eeglab13_5_4b')
 % addpath ('C:\Users\laura\Documents\MATLAB\eeglab13_6_5b');%compu casa
%eeglab
      
 addpath ('C:\Users\Usuario\Documents\MATLAB\eeglab13_5_4b')%compu lab
 eeglab
 clear cond
 
switch whichstep
        
%% STEP 1: Run filters
     case {'1'}
% 
filepathIN  = ['C:\Users\Usuario\Dropbox\EEG_laura\prea\'];%lab
               
filepathOUT = ['C:\Users\Usuario\Dropbox\EEG_laura\set_preana\'];

freqname    = '256';

EEG = pop_loadset('filename',[sujname,'.set'], 'filepath', filepathIN);
EEG = eeg_checkset( EEG );


% set highpass filter parameters
whichfilt = 'ellip';%'butter';
data        = EEG.data;
Nchans= size(EEG.data,1)-1;



band.lo_cutoff  = 0.5;%% =1 VER ESTE VALOR
    Wp      =   band.lo_cutoff*(2/EEG.srate); 
    Ws      = 0.25*Wp;
    Rp      = 0.1; 
    Rs      = 60;
    [n, Wp] = ellipord(Wp, Ws, Rp, Rs);
    [b,a] = ellip(n,Rp,Rs,Wp,'high');
    
    figure

%         
        freqz(b,a,256,256);
        print(gcf,'-dpng',[sujname,'_filter_performance_highpass_',num2str(band.lo_cutoff)])
    
    tic
    parfor i=1:Nchans
        data(i,:) = filtfilt(b,a,double(data(i,:)));

    end
    disp(['HighPass Filter: ',num2str(toc),'secs'])
  
        
        
band.hi_cutoff  = 40;
    Wp      = band.hi_cutoff*2/EEG.srate; 
    Ws      = 1.1*Wp;
    Rp      = 0.1; 
    Rs      = 60;
    
    [n, Wp] = ellipord(Wp, Ws, Rp, Rs);
    [b,a] = ellip(n,Rp,Rs,Wp,'low');
    figure
        freqz(b,a,256,256);
        print(gcf,'-dpng',[sujname,'_filter_performance_lowpass_',num2str(band.hi_cutoff)])    
        
    tic
    parfor i=1:Nchans
        data(i,:) = filtfilt(b,a,double(data(i,:))); 
    end
    disp(['LowPass Filter: ',num2str(toc),'secs'])

    
EEG.data    = data;
clear data
EEG.bandpass= band;
    
% downsample

EEG = eeg_checkset( EEG );
freqname    = num2str(EEG.srate);

% save dataset
EEG = pop_saveset( EEG,  'filename', [sujname,'_',freqname,'_',whichfilt,'_',num2str(band.hi_cutoff),'_',num2str(band.lo_cutoff),'.set'], 'filepath', filepathOUT);
EEG = eeg_checkset( EEG );


%% STEP 2: Interpolar
    case {'2'}
%Esta informacion sale de mirar los datos crudos
if strcmp(sujname,'clh')
   badchannels = [30];
elseif strcmp(sujname,'fm')
    badchannels = [];
elseif strcmp(sujname,'lux')
    badchannels = [16 29];
elseif strcmp(sujname,'sghf')
    badchannels = [25 30];
elseif strcmp(sujname,'SCB')
    badchannels = [6 8 30];
elseif strcmp(sujname,'mai')
    badchannels = [14 30];
elseif strcmp(sujname,'afr')
    badchannels = [30];
elseif strcmp(sujname,'jyt')
    badchannels = [16 30];
elseif strcmp(sujname,'alz')
    badchannels = [7 30];
elseif strcmp(sujname,'vim')
    badchannels = [30];

else
    disp('Definir canales a interpolar')
    return;
end

freqname    = '256';
whichfilt   = 'ellip';
band.lo_cutoff  = 0.5;
band.hi_cutoff  = 40;

% filepathIN  = [ 'C:\Users\laura\Dropbox\EEG_laura\prea'];%casa
%               
% filepathOUT = ['C:\Users\laura\Dropbox\EEG_laura\set_preana\'];%casa

filepathIN  = ['C:\Users\Usuario\Dropbox\EEG_laura\set_preana\'];
filepathOUT = ['C:\Users\Usuario\Dropbox\EEG_laura\set_preana\'];

% load dataset
    filename = [sujname,'_',freqname,'_',whichfilt,'_',num2str(band.hi_cutoff),'_',num2str(band.lo_cutoff)];
    EEG = pop_loadset('filename', [filename,'.set'], 'filepath', filepathIN);
    EEG = eeg_checkset( EEG );

% Interpolate bad channels (selected by visual inspection)
    if isempty(badchannels)
        str = [sujname,': No need to interpolate'];
    else
        str = [sujname,': Interpolate: ']; 
        for i=1:length(badchannels); 
            str = [str,EEG.chanlocs(badchannels(i)).labels,' (',num2str(badchannels(i)),'), '];
        end
        EEG = eeg_interp(EEG, badchannels, 'invdist'); % method = 'invdist' is also the default if nargin<3;
        EEG = eeg_checkset(EEG);
    end
    disp(str)
    
% Save temporal set...
    savename = [filename,'_interp'];
    EEG = pop_saveset(EEG, 'filename', [savename,'.set'], 'filepath', filepathIN);
    EEG = eeg_checkset( EEG );

        
%% STEP 3: cortar ??? VER
case {'3'}

%
filepathIN = ['C:\Users\Usuario\Dropbox\EEG_laura\set_preana\'];%lab
filepathOUT = ['C:\Users\Usuario\Dropbox\EEG_laura\set_epoched750\'];


freqname    = '256';
whichfilt   = 'ellip';
band.lo_cutoff  = 0.5;
band.hi_cutoff  = 40;
cond            = params; %%VER ESTO!!
%load dataset
filename = [sujname,'_',freqname, '_', whichfilt, '_', num2str(band.hi_cutoff), '_', num2str(band.lo_cutoff), '_interp'];
EEG = pop_loadset('filename',[filename,'.set'], 'filepath', filepathIN);
EEG = eeg_checkset( EEG );        
               
%% Redefinir las Marcas

stamp = EEG.event(cond);

% urevent=EEG.stamp.resp{cond}.tiempo;        

EEG = rmfield(EEG, 'event');
for i = 1:length(stamp.estim)        
    EEG.event(i).urevent   = i;% urevent(i);
    EEG.event(i).type      = 1;
    EEG.event(i).latency   = stamp.estim(i)*256;
    EEG.event(i).duration  = 0.030;
    
end
EEG = eeg_checkset(EEG);    

%% Cortar epochs
    

    % Definir propiedades de los epochs
    tmin        = 0.2; % secs
    tmax        = 0.75; % secs
    epochlimits = [-1*tmin tmax];                 % secs
    baseline    = [tmin 0]*(-1000);            % millisecs
    
    % Cortar
    EEG = pop_epoch( EEG, {  '1'  }, epochlimits, 'newname', 'epoched', 'epochinfo', 'yes');
%     EEG = pop_epoch( EEG, EEG.event, epochlimits);
    EEG = eeg_checkset( EEG );
    
% 

% Remove baseline
EEG = pop_rmbase( EEG, baseline);
EEG = eeg_checkset( EEG );

% save dataset
savename = [sujname,'_epochs_cond',num2str(cond),'.set'];
EEG = pop_saveset( EEG,  'filename', savename, 'filepath', filepathOUT);
EEG = eeg_checkset( EEG );

%% STEP 4: Remove artifacts DETE
% Saca artefactos por amplitud cuando los datos estan cortados en epocas

    case {'4'}
% disp('No esta terminado')
% return

freqname    = '256';
whichfilt   = 'ellip';
band.lo_cutoff  = 1;
band.hi_cutoff  = 40;
cond            = params;       %1 RF; 2:RI; 3: NF; 4: NI


filepathIN  = ['C:\Users\Usuario\Dropbox\EEG_laura\set_epoched750\'];
filepathOUT = ['C:\Users\Usuario\Dropbox\EEG_laura\set_epoched750\'];
% load dataset
filename = [sujname,'_epochs_cond',num2str(cond),'.set'];
EEG = pop_loadset('filename', filename, 'filepath', filepathIN);
EEG = eeg_checkset( EEG );
EEG.stamp = EEG.event;
% I run dete_marco with 30 electrodes


limites = [];           % En donde quiero mirar en busca de artefactos, si esta vacio mira todo el epoch
p1 = run_dete(EEG,limites);
EEG.p1 = p1;

% interpolate Bad Channels/Segments
% Here I use BCS matrix
segind  = find(sum(p1.BCS)>0 & sum(p1.BCS)<=p1.maxBadChan);
if ~isempty(segind)
     EEG = eeg_checkset(EEG);
    clear badchans
    badchans = cell(length(segind));
    for iseg = 1:length(segind)     
        badchans{iseg} = find(p1.BCS(:,segind(iseg)));
    end

    disp(['Segments to interpolate(',num2str(p1.tA),' uV, ',num2str(p1.maxBadChan),'): ',num2str(length(segind))])
    % badchans -    [integer array] indices of channels to interpolate.
    %               For instance, these channels might be bad.
    %               [chanlocs structure] channel location structure containing
    %               either locations of channels to interpolate or a full
    %               channel structure (missing channels in the current 
    %               dataset are interpolated).
    for iseg = 1:length(segind)    
        disp(['Interpolating segment ',num2str(segind(iseg)),': badchans: '])
        for ib = 1:length(badchans{iseg})
            disp(num2str(badchans{iseg}(ib)));
        end
        EEG2            = EEG;
        EEG2.trials     = 1;
        EEG2.data       = squeeze(EEG.data(:,:,segind(iseg)));

        EEG2 = eeg_interp(EEG2,badchans{iseg}');
 
        EEG.data(:,:,segind(iseg)) = EEG2.data;
    end
    EEG = eeg_checkset(EEG);

% Include reference channel (locations are deleted with the 
% eeg_checkset function)

else
    disp('No segments to interpolate')
end



% reject Bad Segments
% Here I use BS matrix
if sum(p1.BS)>0
    disp(['Bad Segments (',num2str(p1.maxBadChan),'): ',num2str(sum(p1.BS))])
    % trialrej: Array of 0s and 1s (depicting rejected trials) (size is number of trials)
    % confirm: Display rejections and ask for confirmation. (0=no. 1=yes; default is 1).
    trialrej    = p1.BS;
    confirm     = 0;
    EEG = pop_rejepoch(EEG, trialrej, confirm);
    EEG = eeg_checkset(EEG);
    %borra toda la información de las epocas que va a tirar.
    
%     EEG.stamp(trialrej).urevent    = [];        
%     EEG.stamp(trialrej).type       = [];
%     EEG.stamp(trialrej).duration   = [];
%     EEG.stamp(trialrej).latency    = [];
    EEG.stamp_rejected = trialrej;
        
else
    disp('No segments to reject')
end

% Average reference , excluding EOG and reference channels
EEG = pop_reref( EEG, [] );
EEG = eeg_checkset( EEG );
% 
% % Exclude EOG and reference channels
% EEG = pop_select( EEG, 'nochannel',129:135);
% EEG = eeg_checkset( EEG );

% save dataset
savename = [sujname,'_epochs_cond',num2str(cond),'_artidet','.set'];
EEG = pop_saveset( EEG,  'filename', savename, 'filepath', filepathOUT);
EEG = eeg_checkset( EEG );

%% STEP 5: Remove ICA.
% Saca artefactos por amplitud cuando los datos estan cortados en epocas

    case {'5'}
% disp('No esta terminado')
% return
freqname    = '256';
whichfilt   = 'ellip';
band.lo_cutoff  = 1;
band.hi_cutoff  = 40;
cond            = params;       %1 RF; 2:RI; 3: NF; 4: NI

filepathIN  = ['C:\Users\Usuario\Dropbox\EEG_laura\set_epoched750\'];
filepathOUT = ['C:\Users\Usuario\Dropbox\EEG_laura\set_epoched750\'];
% load dataset
filename = [sujname,'_epochs_cond',num2str(cond),'_artidet.set'];

EEG = pop_loadset('filename', filename, 'filepath', filepathIN);
EEG = eeg_checkset( EEG );

EEG = pop_runica(EEG, 'extended',1,'interupt','on');
EEG = eeg_checkset( EEG );
EEG = pop_selectcomps(EEG, [1:30] );
EEG = eeg_checkset( EEG );

savename = [sujname,'_epochs_cond',num2str(cond),'_ICA','.set'];
EEG = pop_saveset( EEG,  'filename', savename, 'filepath', filepathOUT);
EEG = eeg_checkset( EEG );

  case {'6'}
%%disp('No esta terminado')% return
freqname    = '256';
whichfilt   = 'ellip';
band.lo_cutoff  = 1;
band.hi_cutoff  = 40;
cond            = params;       %1 RF; 2:RI; 3: NF; 4: NI

filepathIN  = ['C:\Users\Usuario\Dropbox\EEG_laura\set_epoched750\'];
filepathOUT = ['C:\Users\Usuario\Dropbox\EEG_laura\set_epoched750\'];
% load dataset
filename = [sujname,'_epochs_cond',num2str(cond),'_ICA.set'];
EEG = pop_loadset('filename', filename, 'filepath', filepathIN);
EEG = eeg_checkset( EEG );
EEG = pop_subcomp( EEG);

savename = [sujname,'_epochs_cond',num2str(cond),'_ICA_removed','.set'];
EEG = pop_saveset( EEG,  'filename', savename, 'filepath', filepathOUT);
EEG = eeg_checkset( EEG );


end
end

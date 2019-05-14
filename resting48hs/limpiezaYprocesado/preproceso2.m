%for i=1:23
i=17;
    NOMBRE=['s',num2str(i)];
    % Para Lucía

    
    addpath('C:\Users\lucía\Documents\eeglab14_1_1b')
    eeglab;

    ppal = 'direccion ppal';
    % ppal = '/home/usuario/Dropbox/silabas/DATA/'

    %% STEP 1: Run filters
    % 
    filepathIN  = 'D:\EEG\resting48hs\datosSET\';
    filepathOUT = 'D:\EEG\resting48hs\datosFiltrados\F100\';

    freqname    = '256';

    % chan = 0; nfig = 200;


    EEG = pop_loadset('filename',[NOMBRE,'.set'], 'filepath', filepathIN);
    EEG = eeg_checkset( EEG );

    % d = fdesign.bandpass('N,F3dB1,F3dB2',10,0.1,100,freqname);
    % Hd = design(d,'butter');
    %    
    % fvtool(Hd);
    %    
    % data    = EEG.data;
    % dataOut = filter(Hd,data);
    %    
    [EEG,com,b]=pop_eegfiltnew(EEG,0.1,100); % ESTE ES UN POSIBLE FILTRO

    chan=0;
    nfig=1;

        z_periodogram(double(EEG.data),EEG.srate,chan,nfig,'b')
        legend('Raw data',...
                'HighPass',...
                'LowPass',...
                'Location','NorthEast')


    %     EEG.data    = data;
    %     tiempos     = EEG.times;


        % save dataset
        EEG = pop_saveset( EEG,  'filename',[NOMBRE,'_filt.set'], 'filepath', filepathOUT);
        EEG = eeg_checkset( EEG );



    %% STEP 2: Clean AC

    filepathIN  = 'D:\EEG\resting48hs\datosFiltrados\F100\';
    filepathOUT = 'D:\EEG\resting48hs\datosFiltrados\F50\';
    sujname=NOMBRE;


    % EEG = pop_loadset( 'filename', [sujname,'_',freqname,'_filt.set'],...
    EEG = pop_loadset( 'filename', [sujname,'_filt.set'],'filepath', filepathIN);
    EEG = eeg_checkset( EEG );

    matriz = EEG.data;
    F_LINE = 50;
    Fs     = EEG.srate;

    data     = cleanAC(matriz, F_LINE, Fs);
    EEG.data = data;

    EEG = pop_saveset( EEG,  'filename', [sujname,'_',freqname,'_filt_AC.set'], 'filepath', filepathOUT);
    EEG = eeg_checkset( EEG );
      %% STEP3: INTERPOLACION

    badchannels = buscaChanIntLucia(sujname);


    filepathIN  = 'D:\EEG\resting48hs\datosFiltrados\F50\';
    filepathOUT = 'D:\EEG\resting48hs\datosFiltrados\Interp\';

    % load dataset
        filename = [sujname,'_',freqname,'_filt_AC'];
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
            EEG = eeg_interp(EEG, badchannels, 'spherical'); % method = 'invdist' is also the default if nargin<3;
            EEG = eeg_checkset(EEG);
        end
        disp(str)


    % Save temporal set...
        savename = [filename,'_int'];
        EEG = pop_saveset(EEG, 'filename', [savename,'.set'], 'filepath', filepathOUT);
        EEG = eeg_checkset( EEG );



      %% step 4: ICA
          
    filepathIN  = 'D:\EEG\resting48hs\datosFiltrados\Interp\';
    filepathOUT = 'D:\EEG\resting48hs\datosFiltrados\ICA\';

    % load dataset
        filename = [sujname,'_256_filt_AC_int.set'];
        EEG = pop_loadset('filename', [filename], 'filepath', filepathIN);
        EEG = eeg_checkset( EEG );

        EEG = pop_runica(EEG, 'interupt','on');
        EEG = eeg_checkset( EEG );

        savename = [sujname,'_ICA','.set'];
        EEG = pop_saveset( EEG,  'filename', savename, 'filepath', filepathOUT);
        EEG = eeg_checkset( EEG );
        
      %end
      %% step 5: Saca ICA
                    
    quehacer = 'rej';

    filepathIN  = 'D:\EEG\resting48hs\datosFiltrados\ICA\';
    filepathOUT = 'D:\EEG\resting48hs\datosFiltrados\ICA2\';

    % load dataset
    filename = [sujname,'_ICA.set'];
    EEG = pop_loadset('filename', filename, 'filepath', filepathIN);
    EEG = eeg_checkset( EEG );

    EEG = pop_selectcomps(EEG, [1:30] );
    EEG = eeg_checkset( EEG );
    if strcmp(quehacer,'rej')
        EEG = pop_subcomp( EEG);
    end
    savename = [sujname,'_ICA_removed','.set'];
    EEG = pop_saveset( EEG,  'filename', savename, 'filepath', filepathOUT);
    EEG = eeg_checkset( EEG );
    
     


%end

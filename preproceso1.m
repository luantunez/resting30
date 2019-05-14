NOMBRE='s1';
    % Para LucÃ­a

    addpath('C:\Users\lucía\Documents\eeglab14_1_1b')
    eeglab;

    ppal = 'direcciÃ³n ppal';
    % ppal = '/home/usuario/Dropbox/silabas/DATA/'

    %% STEP 1: Run filters
    % 
    filepathIN  = 'C:\Users\lucía\Dropbox\datos\';
    filepathOUT = 'C:\Users\lucía\Dropbox\datosFiltrados\filtros\ellip\';

    freqname    = 256;

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
    %[EEG,com,b]=pop_eegfiltnew(EEG,0.1,100); % ESTE ES UN POSIBLE FILTRO
   
    %%%%%%%%%%%%%%%%%%%%%%%
    Wp = [0.1 100]/128; Ws = [0.05 120]/128;
    Rp = 1; Rs = 40;
    [n,Wp] = ellipord(Wp,Ws,Rp,Rs);
    [b,a] = ellip(n,Rp,Rs,Wp);
    freqz(b,a);
    title(sprintf('n = %d Elliptic Bandpass Filter',n));
    figure();
    EEGp=EEG.data(1,:);
    EEGp=EEGp';                     %EEGp=canal 1 del EEG en tiempo
    filtEEG=filter(b,a,double(EEGp));     %filtFEEG=transformada de fourier del canal 1 del EEG filtrada
    FEEG=fft(EEGp);                 %FEEG=transformada de fourier del canal 1 del EEG
    FEEG=abs(FEEG);
    filtFEEG=fft(filtEEG);         %transfomada de fourier del canal 1 filtrado del EEG
    filtFEEG=abs(filtFEEG);
    %filtEEG=ifft(filtEEG); %filtEEG= canal 1 del EEG en tiempo filtrado
    
    subplot(4,1,1);
    plot(EEGp); %grafico canal 1 del EEG
    title('canal 1 del EEG en tiempo sin filtro');
    subplot(4,1,2);
    plot(filtEEG);
    title('canal 1 del EEG en tiempo con filtro');
    subplot(4,1,3);
    plot(FEEG);
    title('transformada de fourier del canal 1 del EEG sin filtro');
    subplot(4,1,4);
    plot(filtFEEG);
    title('transformada de fourier del canal 1 del EEG filtrada');
    %%%%%%%%%%%%%%%%%%%%%%%%mucho ripple
    
%     Wp = [0.1 100]/128; Ws = [0.05 120]/128;
%     Rp = 1; Rs = 40;
%     [n,Wp] = buttord(Wp,Ws,Rp,Rs);
%     [b,a] = butter(n,Wp);
%     freqz(b,a);
%     title(sprintf('n = %d Elliptic Bandpass Filter',n));
%     figure();
%     subplot(4,1,1);
%     EEGp=EEG.data(1,:);
%     EEGp=EEGp'; %EEGp=canal 1 del EEG en tiempo
%     plot(EEGp); %grafico canal 1 del EEG
%     title('canal 1 del EEG en tiempo sin filtro');
%     FEEG=fft(EEGp); %FEEG=transformada de fourier del canal 1 del EEG
%     FEEG=abs(FEEG);
%     filtFEEG=filter(b,a,FEEG);  %filtFEEG=transformada de fourier del canal 1 del EEG filtrada
%     filtEEG=ifft(filtFEEG); %filtEEG= canal 1 del EEG en tiempo filtrado
%     subplot(4,1,2);
%     plot(filtEEG);
%     title('canal 1 del EEG en tiempo con filtro');
%     subplot(4,1,3);
%     plot(FEEG);
%     title('transformada de fourier del canal 1 del EEG sin filtro');
%     subplot(4,1,4);
%     plot(filtFEEG);
%     title('transformada de fourier del canal 1 del EEG filtrada');
    %%%%%%%%%%%%%%%%%%%%%%%%decrece muy lento
    
%     Wp = [0.1 100]/128; Ws = [0.05 120]/128;
%     Rp = 1; Rs = 40;
%     [n,Wp] = cheb1ord(Wp,Ws,Rp,Rs);
%     [b,a] = cheby1(n,Rp,Wp);
%     freqz(b,a);
%     title(sprintf('n = %d Elliptic Bandpass Filter',n));
%     figure();
%     subplot(4,1,1);
%     EEGp=EEG.data(1,:);
%     EEGp=EEGp'; %EEGp=canal 1 del EEG en tiempo
%     plot(EEGp); %grafico canal 1 del EEG
%     title('canal 1 del EEG en tiempo sin filtro');
%     FEEG=fft(EEGp); %FEEG=transformada de fourier del canal 1 del EEG
%     FEEG=abs(FEEG);
%     filtFEEG=filter(b,a,FEEG);  %filtFEEG=transformada de fourier del canal 1 del EEG filtrada
%     filtEEG=ifft(filtFEEG); %filtEEG= canal 1 del EEG en tiempo filtrado
%     subplot(4,1,2);
%     plot(filtEEG);
%     title('canal 1 del EEG en tiempo con filtro');
%     subplot(4,1,3);
%     plot(FEEG);
%     title('transformada de fourier del canal 1 del EEG sin filtro');
%     subplot(4,1,4);
%     plot(filtFEEG);
%     title('transformada de fourier del canal 1 del EEG filtrada');
    %%%%%%%%%%%%%%%%%%%%%%%%tarda mucho en caer

    chan=0;
    nfig=1;

       % z_periodogram(double(EEG.data),EEG.srate,chan,nfig,'b')
       % legend('Raw data',...
          %    'HighPass',...
           %    'LowPass',...
           %    'Location','NorthEast')


    %     EEG.data    = data;
    %     tiempos     = EEG.times;


        % save dataset
       %EEG = pop_saveset( EEG,  'filename',[NOMBRE,'_filt.set'], 'filepath', filepathOUT);
        %EEG = eeg_checkset( EEG );



    %% STEP 2: Clean AC

    filepathIN  = 'C:\Users\lucía\Dropbox\datosFiltrados\F100\';
    filepathOUT = 'C:\Users\lucía\Dropbox\datosFiltrados\F50\';
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


    filepathIN  = 'C:\Users\lucía\Dropbox\datosFiltrados\F50\';
    filepathOUT = 'C:\Users\lucía\Dropbox\datosFiltrados\Interp\';

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
% 
%     filepathIN  = 'C:\Users\lucía\Dropbox\datosFiltrados\Interp\';
%     filepathOUT = 'C:\Users\lucía\Dropbox\datosFiltrados\FICA\';
% 
%     % load dataset
%         filename = [sujname,'_',freqname,'_int'];
%         EEG = pop_loadset('filename', [filename,'.set'], 'filepath', filepathIN);
%         EEG = eeg_checkset( EEG );
% 
%         EEG = pop_runica(EEG, 'interupt','on');
%         EEG = eeg_checkset( EEG );
% 
%         savename = [sujname,'_ICA','.set'];
%         EEG = pop_saveset( EEG,  'filename', savename, 'filepath', filepathOUT);
%         EEG = eeg_checkset( EEG );
%       %% step 5: Saca ICA
% 
%     quehacer = 'rej';
% 
%     filepathIN  = 'C:\Users\lucía\Dropbox\datos';
%     filepathOUT = 'C:\Users\lucía\Dropbox\datosFiltrados\ICA';
% 
%     % load dataset
%     filename = [sujname,'_ICA.set'];
%     EEG = pop_loadset('filename', filename, 'filepath', filepathIN);
%     EEG = eeg_checkset( EEG );
% 
%     EEG = pop_selectcomps(EEG, [1:30] );
%     EEG = eeg_checkset( EEG );
%     if strcmp(quehacer,'rej')
%         EEG = pop_subcomp( EEG);
%     end
%     savename = [sujname,'_ICA_removed','.set'];
%     EEG = pop_saveset( EEG,  'filename', savename, 'filepath', filepathOUT);
%     EEG = eeg_checkset( EEG );

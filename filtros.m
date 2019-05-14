close all 
clear all
clc

frec = 128;

%%%%%%%%%%%chevischev
%
% Wp = [0.1 100]/128; Ws = [0.05 120]/128;
% Rp = 1; Rs = 40;
% [n,Wp] = cheb1ord(Wp,Ws,Rp,Rs);
% [b,a] = cheby1(n,Rp,Wp);



%
%%%%%%%%%%%%%%%%

%%%%%%%%%%%%elliptic
%
% Wp = [0.1 100]/128; Ws = [0.05 120]/128;
% Rp = 1; Rs = 40;
% [n,Wp] = ellipord(Wp,Ws,Rp,Rs);
% [b,a] = ellip(n,Rp,Rs,Wp);
%
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%Butterwoth
%
 Wp = [0.1 100]/128; Ws = [0.05 120]/128;
 Rp = 1; Rs = 40;
 [n,Wp] = buttord(Wp,Ws,Rp,Rs);
 [b,a] = butter(n,Wp);

fvtool(b,a);
%
%%%%%%%%%%%%%%%%%%

%freqz(b,a);

T = 1/frec;                     % Sample time
L = 1000;                     % Length of signal
t = (0:L-1)*T;                % Time vector
% Sum of a 50 Hz sinusoid and a 120 Hz sinusoid
x = sin(2*pi*0.001*t)+0.7*sin(2*pi*50*t) + sin(2*pi*120*t)+ sin(2*pi*200*t); 
%EEGp = x + 2*randn(size(t));     % Sinusoids plus noise

%%%%%%%%filtro eeglab
% 
NOMBRE='s1';

addpath('C:\Users\lucía\Documents\eeglab14_1_1b')
eeglab;

 ppal = 'direccion ppal';
    
filepathIN  = 'C:\Users\lucía\Dropbox\datos\';
filepathOUT = 'C:\Users\lucía\Dropbox\datosFiltrados\F100\';

 EEG = pop_loadset('filename',[NOMBRE,'.set'], 'filepath', filepathIN);
 EEG = eeg_checkset( EEG );

EEG.nbchan=1;
EEG.pnts=L;
% %EEG.data=EEGp;
%
%%%%%%%%%%%%%%

%amplitud en 100 Hz

pico100=zeros(1,100);
filtPico100=zeros(1,100);
pmdio100=zeros(1,100);
filtPmedio100=zeros(1,100);

for i=1:100
    
     EEGp = x + 2*randn(size(t)); 
     EEG.data=EEGp;

     fs=256;
    L=length(EEGp);

    k=(0:L-1)*1/fs;
    f = fs/2*linspace(0,1,L/2+1);

    filtEEG=filtfilt(b,a,EEGp);  %filtro
%     
%     [filtEEG,com,b]=pop_eegfiltnew(EEG,0.1,100); %filtro del eeglab
%     filtEEG=filtEEG.data;
% 
%     FEEG=fft(EEGp);                 %FEEG=transformada de fourier del canal 1 del EEG
%     aFEEG=angle(FEEG);
%     FEEG=abs(FEEG);
%     filtFEEG=fft(filtEEG);         %transfomada de fourier del canal 1 filtrado del EEG
%     afiltFEEG=angle(filtFEEG);
%     filtFEEG=abs(filtFEEG);
% 
%      FEEG2=2*(FEEG(1:L/2+1));
%      pico100(i)=mean(FEEG2(386:400)); %pico en 392
%      filtFEEG2=2*(filtFEEG(1:L/2+1));
%      filtPico100(i)=mean(filtFEEG2(386:400)); %pico en 392
% 
%      aFEEG2=2*(aFEEG(1:L/2+1)); 
%      afiltFEEG2=2*(afiltFEEG(1:L/2+1)); 
% 
%      pmdio100(i)=mean(aFEEG2(392:450));
%      filtPmedio100(i)=mean(afiltFEEG2(392:450));
% 
 end
 
Mpico100=mean(pico100) %promedio de valores alrededor del pico en 100 de la señal sin filtrar
Spico100=std(pico100)/sqrt(length(pico100)) %desvío standard de valores alrededor del pico en 100 de la señal sin filtrar
MfiltPico100=mean(filtPico100) %promedio de valores alrededor del pico en 100 de la señal filtrada
SfiltPico100=std(filtPico100)/sqrt(length(filtPico100)) %desvío standard de valores alrededor del pico en 100 de la señal filtrada
Mpmdio100=mean(pmdio100) %promedio de valores superiores a 100 de la fase de la señal sin filtrar
Spmdio100=std(pmdio100)/sqrt(length(pmdio100)) %desvío standard de valores superiores a 100 de la fase de la señal sin filtrar
MfiltPmedio100=mean(filtPmedio100) %promedio de valores superiores a 100 de la fase de la señal filtrada
SfiltPmedio100=std(filtPmedio100)/sqrt(length(filtPmedio100)) %desvío standard de valores superiores a 100 de la fase de la señal filtrada
 
 
%%
subplot(3,1,1);
plot(EEGp); %grafico canal 1 del EEG
title('señal en tiempo sin filtro');
xlabel('tiempo');
ylabel('actividad eléctrica');
hold on
%subplot(4,1,2);
plot(filtEEG,'r');
title('señal en tiempo con filtro');
subplot(3,1,2);
plot(f(3:end),2*(FEEG(3:L/2+1)));
%title('transformada de fourier sin filtro');
xlabel('frecuencia');
ylabel('amplitud');
hold on
%subplot(4,1,4);
plot(f(3:end),2*(filtFEEG(3:L/2+1)),'r');
title('amplitud  de la transformada de fourier');

subplot(3,1,3);
plot(f,2*(aFEEG(1:L/2+1)));
%title('fase de la transformada de fourier sin filtro');
xlabel('fase');
ylabel('amplitud');
%subplot(2,1,2);
hold on
plot(f,2*(afiltFEEG(1:L/2+1)),'r');
title('fase de la transformada de fourier');



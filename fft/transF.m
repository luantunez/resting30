close all
clear all
load('F:\pasantías Luchi\resting\matrices\s1.mat');
ind=find(times<800000);
SIG=datos(:,ind);
FE=256;
%FRANGE=[1:0.5:8];
FRANGE=[4:8:35];
TRANGE=[0:800000];
WinSig=256*30;
step=WinSig-WinSig/2;
[Rho, Phi, EjeX, EjeF] = espectrograma2( SIG, FE, FRANGE, TRANGE, WinSig, step);
RhoP=mean(Rho,1);
RhoP=squeeze(RhoP);


%[CumRho, CumPhi,  CumMatdif, EjeX, EjeF, ParElec] = DataAnalyzer2(SIG, FE, FRANGE, TRANGE, WinSig, step);
close all; imagesc(EjeX,EjeF,RhoP',[-3 30]);
xlabel('tiempo(s)');
ylabel('frecuencia(Hz)');
%save('C:\Users\lucía\Dropbox\fft\Rho\Prueba\Rho10.mat','RhoP'); 
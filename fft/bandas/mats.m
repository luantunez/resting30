close all
clear all

addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');

FE=256;
WinSig=256;
step=WinSig-WinSig/2;

for i=1:34
     if i ~= 18 && i ~= 28 && i ~= 30
        load(['D:\EEG\matrices\s',num2str(i),'.mat']);
        ind=find(times<800000);
        FRANGE=[1:0.2:3];  %delta
        %FRANGE=[4:0.2:8];  %theta
        %FRANGE=[8:0.2:12]; %alfa
        %FRANGE=[12:1:35]; %beta
        %FRANGE=[12:0.5:22]; %beta1
        %FRANGE=[22:0.5:35]; %beta2
        %FRANGE=[1:1:35]; %total

        TRANGE=[0:times(ind(end))];
        %tmedido=length(times)/step;
        SIG=datos(:,ind);
        [Rho, Phi, EjeX, EjeF] = espectrograma2( SIG, FE, FRANGE, TRANGE, WinSig, step);
        RhoP=squeeze(Rho);
        %save(['D:\EEG\fft\bandas\delta\RhoP\s',num2str(i),'.mat'],'RhoP','EjeX','EjeF'); 
     end
end


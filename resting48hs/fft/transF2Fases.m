banda=1

while banda~=9

close all
clearvars -except banda

if(banda==1) %delta
        frec='delta';
        FRANGE=[1:0.2:3];
    elseif(banda==2) %theta
         frec='theta';
        FRANGE=[4:0.2:8];
    elseif(banda==3) %alfa
        frec='alfa';
        FRANGE=[8:0.2:12];
    elseif(banda==4) %beta
        frec='beta';
        FRANGE=[12:1:35];
    elseif(banda==5) %beta1
         frec='beta1';
        FRANGE=[12:0.5:22];
    elseif(banda==6) %beta2
         frec='beta2';
        FRANGE=[22:0.5:35];
    elseif(banda==7) %total
         frec='total';
        FRANGE=[1:1:35];
    elseif(banda==8) %totalCut
        frec='totalCut';
        FRANGE=[4:1:35];   %saco delta
end   

FE=256;
TRANGE=[0:800000];
WinSig=256;
step=WinSig-WinSig/2;

for i=1:23
    %i=4
    if i ~= 18 && i ~= 28 && i ~= 30
        load(['D:\EEG\resting48hs\datosMAT\s',num2str(i),'.mat']);
        ind=find(times<800000);
        %suj=zeros(1167,11,30);
            SIG=datos(:,ind);
           [CumRho, CumPhi,  CumMatdif, EjeX, EjeF, ParElec] = DataAnalyzer2(SIG, FE, FRANGE, TRANGE, WinSig, step);
        save(['D:\EEG\resting48hs\fft\',frec,'\RhoFase\s',num2str(i),'.mat'],'CumRho', 'CumPhi',  'CumMatdif', 'EjeX', 'EjeF', 'ParElec');
    end
end

banda=banda+1

end
% 
% close all
% clear all
% load('F:\pasantías Luchi\resting\matrices\s1.mat');
% ind=find(times<800000);
% SIG=datos(:,ind);
% FE=256;
% FRANGE=[1:0.5:8];
% TRANGE=[0:800000];
% WinSig=256*10;
% step=WinSig-WinSig/2;
% [Rho, Phi, EjeX, EjeF] = espectrograma2( SIG, FE, FRANGE, TRANGE, WinSig, step);
% RhoP=mean(Rho,1);
% RhoP=squeeze(RhoP);
% 
% 
% %[CumRho, CumPhi,  CumMatdif, EjeX, EjeF, ParElec] = DataAnalyzer2(SIG, FE, FRANGE, TRANGE, WinSig, step);
% close all; imagesc(EjeX,EjeF,RhoP',[-1 1000]);
% xlabel('tiempo');
% ylabel('frecuencia');
% %save('C:\Users\lucía\Dropbox\fft\Rho\Prueba\Rho10.mat','RhoP'); 
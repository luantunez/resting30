close all
clear all

FE=256;
FRANGE=[4:1:35];
TRANGE=[0:800000];
WinSig=256;
step=WinSig-WinSig/2;

for i=1:34
    if i ~= 18 && i ~= 28 && i ~= 30
        load(['F:\pasantías Luchi\resting\matrices\s',num2str(i),'.mat']);
        ind=find(times<800000);
        %suj=zeros(1167,11,30);
            SIG=datos(:,ind);
            [Rho, Phi, EjeX, EjeF] = espectrograma2( SIG, FE, FRANGE, TRANGE, WinSig, step);
            RhoP=Rho;
        save(['F:\pasantías Luchi\resting\fft\bandas\totalCut\RhoP\s',num2str(i),'.mat'],'RhoP'); 
    end
end



% FE=256;
% FRANGE=[1:0.5:8];
% TRANGE=[0:800000];
% WinSig=256;
% step=WinSig-WinSig/2;
% 
% for i=1:34
%     load(['C:\Users\lucía\Dropbox\datosFiltrados\sujetos\s',num2str(i),'mat.mat']);
%     ind=find(times<800000);
%     mkdir('C:\Users\lucía\Dropbox\fft\Rho',['S',num2str(i)]);
%     for j=1:30
%         SIG=datos(j,ind);
%         [Rho, Phi, EjeX, EjeF] = espectrograma2( SIG, FE, FRANGE, TRANGE, WinSig, step);
%         RhoP=squeeze(Rho);
%         save(['C:\Users\lucía\Dropbox\fft\Rho\S',num2str(i),'\s',num2str(i),'Ch',num2str(j),'.mat'],'RhoP'); 
%     end
% end


% modificado para nueva normalizacion

close all    
clear all
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');
 
%% Hago esto sólo para sacar EjeX y EjeF
% i=1;
% j=1;
% load(['C:\Users\lucía\Dropbox\datosFiltrados\sujetos\s',num2str(i),'mat.mat']);
% ind=find(times<800000);
% FE=256;
% FRANGE=[1:0.2:3];
% TRANGE=[0:times(ind(end))];
% WinSig=256;
% step=WinSig-WinSig/2;
% SIG=datos(j,ind);
% [Rho, Phi, EjeX, EjeF] = espectrograma2( SIG, FE, FRANGE, TRANGE, WinSig, step);

%% Saco la mínima dimensión de tiempos (del sujeto registrado durante menos tiempo)

%load(['C:\Users\lucía\Dropbox\fft\Rho\S',num2str(i),'\s',num2str(i),'Ch',num2str(j),'.mat']); 

banda=7;

    if(banda==1) %delta
        frec='delta';
        FRANGE=[1:0.2:3];
        direc='F:\pasantías Luchi\resting\fft\bandas\delta\sujNormTot\s';
        colorBar=[0 5];
    elseif(banda==2) %theta
         frec='theta';
        FRANGE=[4:0.2:8];
        direc='F:\pasantías Luchi\resting\fft\bandas\theta\sujNormTot\s';
        colorBar=[0 3]; 
    elseif(banda==3) %alfa
        frec='alfa';
        FRANGE=[8:0.2:12];
        direc='F:\pasantías Luchi\resting\fft\bandas\alfa\sujNormTot\s';
        colorBar=[0 3]; 
    elseif(banda==4) %beta
        frec='beta';
        FRANGE=[12:1:35];
        direc='F:\pasantías Luchi\resting\fft\bandas\beta\sujNormTot\s';
        colorBar=[0 1.2];
    elseif(banda==5) %beta1
         frec='beta1';
        FRANGE=[12:0.5:22];
        direc='F:\pasantías Luchi\resting\fft\bandas\beta1\sujNormTot\s';
        colorBar=[0 1.7];
    elseif(banda==6) %beta2
         frec='beta2';
        FRANGE=[22:0.5:35];
        direc='F:\pasantías Luchi\resting\fft\bandas\beta2\sujNormTot\s';
        colorBar=[0 0.6];
    elseif(banda==7) %total
         frec='total';
        FRANGE=[1:1:35];
        direc='F:\pasantías Luchi\resting\fft\bandas\total\sujNormTot\s';
        colorBar=[0 3];
    end  

% largos=zeros(1,34);
% 
% for i=1:34
%      if i ~= 18 && i ~= 28 && i ~= 30    %los sujetos que no sirven, si es distinto de estos, guardar el largo, sino poer un valor alto, no sirven
%         load(['C:\Users\lucía\Dropbox\fft\bandas\beta\RhoP\S',num2str(i),'.mat']); 
%         largos(i)=length(RhoP);
%      else
%          largos(i)=nan; %a estos, que no sirven, les asigno un valor nan
%      end
% end
% 
% [largoMin,sujetoMin]=min(largos);

%% Saco  el promedio de los RhoP de todos los canales para todos los sujetos en el tiempo min 

total=[];
totalFrec=[];

for i=1:34
    if i ~=18 && i ~= 28 && i ~= 30   %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es iguala a alguno no entra
        load([direc,num2str(i),'.mat']); 
        pmedioCh=mean(suj,1);  %promedio de todos los canales para cada sujeto;
        pmedioFrec=mean(pmedioCh,3); %para hacer otro grafico de frecuencias colapsadas
        total=[total; pmedioCh]; %(:,1:largoMin,:);
        totalFrec=[totalFrec; pmedioFrec];  %para hacer otro grafico de frecuencias colapsadas
        
    end
end

pmedioTot=squeeze(mean(total,1));
xlabel('tiempo');
ylabel('frecuencia');

%suj=suj/31;
%suj=squeeze(suj);

%% Grafico el promedio

pmedioTotalFrec=mean(totalFrec,1);

media1=mean(pmedioTotalFrec(1:length(pmedioTotalFrec)*1/3));
media1err=std(pmedioTotalFrec(1:length(pmedioTotalFrec)*1/3))/sqrt(length(pmedioTotalFrec(1:length(pmedioTotalFrec)*1/3)));

media2=mean(pmedioTotalFrec(length(pmedioTotalFrec)*1/3:length(pmedioTotalFrec)*2/3));
media2err=std(pmedioTotalFrec(length(pmedioTotalFrec)*1/3:length(pmedioTotalFrec)*2/3))/sqrt(length(pmedioTotalFrec(length(pmedioTotalFrec)*1/3:length(pmedioTotalFrec)*2/3)));

media3=mean(pmedioTotalFrec(length(pmedioTotalFrec)*2/3:length(pmedioTotalFrec)));
media3err=std(pmedioTotalFrec(length(pmedioTotalFrec)*2/3:length(pmedioTotalFrec)))/sqrt(length(pmedioTotalFrec(length(pmedioTotalFrec)*2/3:length(pmedioTotalFrec))));

media=mean(pmedioTotalFrec);
mediaerr=std(pmedioTotalFrec(1:length(pmedioTotalFrec)))/sqrt(length(pmedioTotalFrec(1:length(pmedioTotalFrec))));
% 
% mediaErr=std(pmedioTotalFrec);
% mediaArr=media+mediaErr;
% mediaAb=media-mediaErr;

mediaArr=media+mediaerr;
mediaAb=media-mediaerr;

%plot(0:EjeX(length(EjeX/1000)*1/3)/1000,media1,'.','MarkerEdgeColor','red','MarkerSize',12);

% plot(EjeX/1000,pmedioTotalFrec);
% hold on
% plot(0:EjeX(length(EjeX/1000)*1/3)/1000,media1,'.','MarkerEdgeColor','red','MarkerSize',12);
% hold on
% plot(EjeX/1000,mediaArr,'.','MarkerEdgeColor','green','MarkerSize',10);
% hold on
% plot(EjeX(length(EjeX/1000)*1/3)/1000:EjeX(length(EjeX/1000)*2/3)/1000,media2,'.','MarkerEdgeColor','red','MarkerSize',12);
% hold on
% plot(EjeX/1000,mediaAb,'.','MarkerEdgeColor','green','MarkerSize',10);
% hold on
% plot(EjeX(length(EjeX/1000)*2/3)/1000:EjeX(length(EjeX/1000))/1000,media3,'.','MarkerEdgeColor','red','MarkerSize',12);

plot(EjeX/1000,pmedioTotalFrec);
hold on
plot(EjeX/1000,mediaArr,'.','MarkerEdgeColor','green','MarkerSize',14);
hold on
plot(EjeX/1000,mediaAb,'.','MarkerEdgeColor','green','MarkerSize',14);
hold on
plot(0:EjeX(length(EjeX/1000))/1000,media,'.','MarkerEdgeColor','red','MarkerSize',10);

xlabel ('Tiempo(s)');
ylabel('Amplitud');

% graph1=plot(0:EjeX(length(EjeX/1000)*1/3)/1000,media1,'r',EjeX(length(EjeX/1000)*1/3)/1000:EjeX(length(EjeX/1000)*2/3)/1000,media2,'r',EjeX(length(EjeX/1000)*2/3)/1000:EjeX(length(EjeX/1000))/1000,media3,'r','LineWidth',20)
% set(graph1,'LineWidth',20);

%plot(EjeX/1000,media,'r',EjeX/1000,pmedioTotalFrec,'b')

%xlabel('frecuencias(Hz)');
%ylabel('Amplitud');

figure();

imagesc(EjeX/1000,EjeF,pmedioTot',colorBar);
xlabel('tiempo (s)');
ylabel('frecuencia (Hz)');

[X,Y]   = meshgrid(1:size(pmedioTot,1), 1:length(FRANGE));

[X2,Y2] = meshgrid(1:0.05:size(pmedioTot,1), 1:0.1:length(FRANGE));

 sujFilt = interp2(X, Y, pmedioTot', X2, Y2, 'linear');
 
 figure();
 
 imagesc(EjeX/1000,EjeF,sujFilt,colorBar);
xlabel('tiempo (s)');
ylabel('frecuencia (Hz)');




 

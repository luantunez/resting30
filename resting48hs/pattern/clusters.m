close all
clear all
clc
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');

%% levanto los datos de excel

 nombre=xlsread('C:\EEG\pasantias\compRest48.xlsx', 'C3:C25');  %levanto datos de excel
 nombre(17)=nan;    %falta suj 17 tal
 definicion=xlsread('C:\EEG\pasantias\compRest48.xlsx', 'D3:D25');
 definicion(17)=nan;    %falta suj 17 tal
 
%  siRel=xlsread('D:\EEG\clusters\datos.xlsx', 'C2:C35');
%  noRel=xlsread('D:\EEG\clusters\datos.xlsx', 'E2:E35');
%  indzSiRel=find(isnan(siRel)==1);        %busco los sujetos que no hicieron la prueba de palabras relacionadas;
%  siRel(indzSiRel)=0;
%  indzNoRel=find(isnan(noRel)==1);        %busco los sujetos que no hicieron la prueba de palabras relacionadas;
%  noRel(indzNoRel)=0;
%  relacion=siRel-noRel;
 
%% 

banda=10;

if(banda==1) %delta1
    ROI=[23,21,10,14];
    frec='delta1';
    direccion={'F:\pasantías Luchi\resting48hs\fft\delta\RhoNorm\s'};
    FRANGE=[1:0.2:3];
    colorBar=[1 4];
elseif(banda==2) %delta2
    ROI=[1,30,9,28];
    frec='delta2';
    direccion={'D:\EEG\resting48hs\fft\delta\RhoNorm\s'};
    FRANGE=[1:0.2:3];
    colorBar=[1 4];
elseif(banda==3) %theta1
     ROI=[28, 2, 17, 10];
     frec='theta1';
    direccion={'D:\EEG\resting48hs\fft\theta\RhoNorm\s'};
    FRANGE=[4:0.2:8];
    colorBar=[0.6 1.8];
elseif(banda==4) %theta2
     ROI=[18, 20, 21, 17];
     frec='theta2';
    direccion={'D:\EEG\resting48hs\fft\theta\RhoNorm\s'};
    FRANGE=[4:0.2:8];
    colorBar=[0.6 1.8];
elseif(banda==5) %alfa
    ROI=[29,19,4,12];
    frec='alfa';
    direccion={'D:\EEG\resting48hs\fft\alfa\RhoNorm\s'};
    FRANGE=[8:0.2:12];
    colorBar=[0.6 1.8];
elseif(banda==6) %betaLow
    ROI=[29,19,4,12];
    frec='betaLow';
    direccion={'D:\EEG\resting48hs\fft\beta1\RhoNorm\s'};
    FRANGE=[12:0.5:22];
    colorBar=[0.4 0.9];
elseif(banda==7) %betaHigh1
     ROI=[22, 2, 20, 3];
     frec='betaHigh1';
    direccion={'D:\EEG\resting48hs\fft\beta2\RhoNorm\s'};       
    FRANGE=[22:0.5:35];
    colorBar=[0.2 0.5];
elseif(banda==8) %betaHigh2
     ROI=[17, 20, 28, 21];
     frec='betaHigh2';
    direccion={'D:\EEG\resting48hs\fft\beta2\RhoNorm\s'};   
    FRANGE=[22:0.5:35];
    colorBar=[0.2 0.5];
elseif(banda==9) %betaHigh3
     ROI=[21, 10, 23, 11];
     frec='betaHigh3';
    direccion={'D:\EEG\resting48hs\fft\beta2\RhoNorm\s'};   
    FRANGE=[22:0.5:35];
    colorBar=[0.2 0.5];
elseif(banda==10) %betaHigh4
     ROI=[5, 13, 29, 19];
     frec='betaHigh4';
    direccion={'F:\pasantías Luchi\resting48hs\fft\beta2\RhoNorm\s'};   
    FRANGE=[22:0.5:35];
    colorBar=[0.2 0.5];
elseif(banda==11) %betaHighCompTheta
    ROI=[28,2,17,10, 22, 20, 21, 23, 18];
    frec='betaHigh5';
    direccion={'D:\EEG\resting48hs\fft\beta2\RhoNorm\s'};   
    FRANGE=[22:0.5:35];
    colorBar=[0.2 0.5];
elseif(banda==12) %thetaCompBetaHigh
    ROI=[28,2,17,10, 22, 20, 21, 23, 18];
    frec='theta3';
    direccion={'F:\pasantías Luchi\resting48hs\fft\theta\RhoNorm\s'};
    FRANGE=[4:0.2:8];
    colorBar=[0.6 1.8];
elseif(banda==13) %betaHighCompTheta2
    ROI=[18 24 25 19];
    frec='betaHigh6';
    direccion={'D:\EEG\resting48hs\fft\beta2\RhoNorm\s'};   
    FRANGE=[22:0.5:35];
    colorBar=[0.2 0.5];
elseif(banda==14) %betaHighCompTheta3
    ROI=[18 24 25 19 20 11];
    frec='betaHigh7';
    direccion={'D:\EEG\resting48hs\fft\beta2\RhoNorm\s'};   
    FRANGE=[22:0.5:35];
    colorBar=[0.2 0.5];
elseif(banda==15) %thetaCompBetaHigh2
    ROI=[18 24 25 19];
    frec='theta4';
    direccion={'D:\EEG\resting48hs\fft\theta\RhoNorm\s'};
    FRANGE=[4:0.2:8];
    colorBar=[0.6 1.8];
elseif(banda==16) %thetaCompBetaHigh3
    ROI=[18 24 25 19 20 11];
    frec='theta5';
    direccion={'D:\EEG\resting48hs\fft\theta\RhoNorm\s'};
    FRANGE=[4:0.2:8];
    colorBar=[0.6 1.8];
end


%% divido en buenos y malos aprendedores para nombres y definiciones

%para hacer el promedio:
nombre([17 3 14 16 18 15])=[];
definicion([17 3 14 16 18 15])=[];

medNom=median(nombre);  %para nombre
medDef=median(definicion);  %para definicion

stdNom=std(nombre);  %para nombre
stdDef=std(definicion);  %para definicion

%meanDef=mean(definicion);

%medRel=median(relacion); %para relacion

%despues de hacer la mediana vuelvo a levatar para que me queden ordenados

nombre=xlsread('C:\EEG\pasantias\compRest48.xlsx', 'C3:C25');  %levanto datos de excel
 nombre([17 3 14 16 18 15])=nan;    %falta suj 17 tal
 definicion=xlsread('C:\EEG\pasantias\compRest48.xlsx', 'D3:D25');
 definicion([17 3 14 16 18 15])=nan;    %falta suj 17 tal


%relacion([indzSiRel indzNoRel])=nan;

sujBuenosNom=[];   %inicializo
numSujBuenosNom=[];
sujMalosNom=[];
numSujMalosNom=[];
sujBuenosDef=[];
numSujBuenosDef=[];
sujMalosDef=[];
numSujMalosDef=[];
% sujBuenosRel=[];
% numSujBuenosRel=[];
% sujMalosRel=[];
% numSujMalosRel=[];

for i=1:23 
    
     if i~=3 && i ~= 14 && i ~= 16 && i ~= 18  && i ~= 15 && i~=17    %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es igual a alguno no entra
      
        suj=load(char(strcat(direccion,num2str(i),'.mat')));
        suj=suj.Rho;
        suj=cast(suj,'double');
        
        suj=mean(suj,3); %promedio en frecuencias
        suj=mean(suj,2); %promedio en tiempos
        %suj=mean(suj(ROI),1);
        suj=squeeze(suj);
        
        clust(i)=mean(suj(ROI));  %hago un clust con el promedio de las energías de los canales de ese ROI para cada sujeto para el grafico de puntos
        
        if nombre(i)>medNom            %para nombre
            sujBuenosNom=[sujBuenosNom suj];
            numSujBuenosNom=[numSujBuenosNom i];
        elseif nombre(i)<medNom 
           sujMalosNom=[sujMalosNom suj];
           numSujMalosNom=[numSujMalosNom i];
        end

        if definicion(i)>medDef        %para definicion
            sujBuenosDef=[sujBuenosDef suj];
            numSujBuenosDef=[numSujBuenosDef i];
        elseif definicion(i)<medDef    
            sujMalosDef=[sujMalosDef suj];
            numSujMalosDef=[numSujMalosDef i];
        end   
        
%         if ismember(i,[indzSiRel indzNoRel])==0 %si el sujeto NO es uno de los que no tienen datos en relaciones
%              if relacion(i)>medRel        %para relacion
%                 sujBuenosRel=[sujBuenosRel suj];
%                 numSujBuenosRel=[numSujBuenosRel i];
%             elseif relacion(i)<medRel    
%                 sujMalosRel=[sujMalosRel suj];
%                 numSujMalosRel=[numSujMalosRel i];
%              end   
%         end
        
     end
end

clust=clust';
clust([3 14 16 17 18 15])=nan;

%indz=find(clust==0);        %busco los sujetos que no sirven;
%clust(indz)=[];                  %los dejo vacios
% nombre(indz)=[];
% definicion(indz)=[];
% 
% indzRel=find(relacion==0);        %busco los sujetos que no hicieron la prueba de palabras relacionadas;
% relacion(indzRel)=[];                 %los dejo vacios

%% graficos de puntos

%indz=find(nombre==0);       %saco los que estan en cero en clust para la correlacion 
vect=[1:23];
vect([3 14 16 17 18 15])=[];                    %lo hago asi para no modificar los datos originales

subplot(2,1,1);    %grafico nombres
plot(nombre(vect),clust(vect),'.');
%ylim([0,0.65]);
title(strcat(frec,' nombre'));
ylabel('cluster');
xlabel('porcentaje de nombres');
[Rnom,Pnom]=corr(clust(vect),nombre(vect))

subplot(2,1,2);   %grafico definiciones
plot(definicion(vect),clust(vect),'.');
%ylim([0,0.65]);
title(strcat(frec,' definicion'));
ylabel('cluster');
xlabel('porcentaje de definicion');
[Rdef,Pdef]=corr(clust(vect),definicion(vect))

%indz=find(nombre==0);       %saco los que estan en cero en clust y relacion para la correlacion 
% vect=[1:34];
% vect([indz' indzSiRel' indzNoRel'])=[];

% subplot(3,1,3);   %grafico relaciones
% plot(relacion(vect),clust(vect),'.');
% ylim([0,0.65]);
% title(strcat(frec,' relacion'));
% ylabel('cluster');
% xlabel('resta en palabras relacionadas');
% [Rrel,Prel]=corr(clust(vect),relacion(vect))

%% hago el topoplot

%colapso sujetos en todos los canales (despues para el grafico de barras
%voy a sacar el promedio pero para los canales de la ROI y ya colapsados)

pmedioBuenosNom=squeeze(mean(sujBuenosNom,2)); 
pmedioMalosNom=squeeze(mean(sujMalosNom,2)); 

pmedioBuenosDef=squeeze(mean(sujBuenosDef,2)); 
pmedioMalosDef=squeeze(mean(sujMalosDef,2));

% pmedioBuenosRel=squeeze(mean(sujBuenosRel,2));
% pmedioMalosRel=squeeze(mean(sujMalosRel,2));

addpath('C:\Users\lucía\Documents\eeglab14_1_1b');
eeglab;

NOMBRE='s1';

ppal = 'direccion ppal';

filepathIN  = 'C:\Users\lucía\Dropbox\datos\';

EEG = pop_loadset('filename',[NOMBRE,'.set'], 'filepath', filepathIN);
EEG = eeg_checkset( EEG );
localizacion=EEG.chanlocs;


figure();
subplot(2,2,2);
topoplot(pmedioBuenosNom',localizacion,'maplimits',colorBar);  %topoplpot de sujetos buenos en nombres
title('Buenos en Nombres');
subplot(2,2,1);
topoplot(pmedioMalosNom',localizacion,'maplimits',colorBar);  %topoplpot de sujetos malos en nombres
title('Malos en Nombres');

subplot(2,2,4);
topoplot(pmedioBuenosDef',localizacion,'maplimits',colorBar);  %topoplpot de sujetos buenos en definiciones
title('Buenos en Definiciones');
subplot(2,2,3);
topoplot(pmedioMalosDef',localizacion,'maplimits',colorBar);  %topoplpot de sujetos malos en definiciones
title('Malos en Definiciones');

% subplot(3,2,6);
% topoplot(pmedioBuenosRel',localizacion,'maplimits',colorBar);  %topoplpot de sujetos buenos en relaciones
% title('Buenos en Relaciones');
% subplot(3,2,5);
% topoplot(pmedioMalosRel',localizacion,'maplimits',colorBar);  %topoplpot de sujetos malos en relaciones
% title('Malos en Relaciones');

figure()
     
%% Histograma de aprendedores

xDef=[0:20:100]; %para los valores del eje x del histograma

subplot(1,2,1);

nombre2=nombre;
definicion2=definicion;

nombre2([17 3 14 16 18 15])=[];
definicion2([17 3 14 16 18 15])=[];

medNom2=median(nombre2);
medDef2=median(definicion2);

hist(nombre2,2);
ylabel('cantidad de aprendedores');
xlabel('porcentaje de nombres aprendidos');
ylim([0,12]);
xlim([0,100]);
hold on 
plot([medNom2 medNom2],ylim,'r-'); %hago una raya en la mediana

subplot(1,2,2);
%hist(definicion,xDef);
hist(definicion2,2);
ylabel('cantidad de aparendedores');
xlabel('porcentaje de definiciones aprendidas');
%ylim([0,12]);
ylim([0,12]);
xlim([0,100]);
hold on
plot([medDef2 medDef2],ylim,'r-'); %hago una raya en la mediana

% subplot(1,3,3);
% hist(relacion);
% ylabel('cantidad de aprendedores');
% xlabel('resta en palabras relacionadas');
% %ylim([0,10]);
% hold on
% plot([medRel medRel],ylim,'r-'); %hago una raya en la mediana

figure()

%% grafico de barras  

%sujetos buenos en nombres
clustBuenosNom=mean(sujBuenosNom(ROI,:),1); %colapso los canales de la ROI para los sujetos buenos en nombres
errBuenosNom=std(clustBuenosNom)/sqrt(length(clustBuenosNom));
pmedioClustBuenosNom=mean(clustBuenosNom); %ahora promedio los sujetos

%sujetos malos en nombres
clustMalosNom=mean(sujMalosNom(ROI,:),1); %colapso los canales de la ROI para los sujetos malos en nombres
errMalosNom=std(clustMalosNom)/sqrt(length(clustMalosNom));
pmedioClustMalosNom=mean(clustMalosNom); %ahora promedio los sujetos

[h,pNom,ci,stats]=ttest2(clustMalosNom,clustBuenosNom,'tail','right');   %T student
pNom

%sujetos buenos en definiciones
clustBuenosDef=mean(sujBuenosDef(ROI,:),1); %colapso los canales de la ROI para los sujetos buenos en definicniones
errBuenosDef=std(clustBuenosDef)/sqrt(length(clustBuenosDef));
pmedioClustBuenosDef=mean(clustBuenosDef); %ahora promedio los sujetos

%sujetos malos en definiciones
clustMalosDef=mean(sujMalosDef(ROI,:),1); %colapso los canales de la ROI para los sujetos malos en definiciones
errMalosDef=std(clustMalosDef)/sqrt(length(clustMalosDef));
pmedioClustMalosDef=mean(clustMalosDef); %ahora promedio los sujetos

[h,pDef,ci,stats]=ttest2(clustMalosDef,clustBuenosDef,'tail','right');
pDef

% relacion([indzSiRel indzNoRel])=[]; %saco para relaciones los que no tienen datos
% 
% %sujetos buenos en relaciones
% clustBuenosRel=mean(sujBuenosRel(ROI,:),1); %colapso los canales de la ROI para los sujetos buenos en relaciones
% errBuenosRel=std(clustBuenosRel)/sqrt(length(clustBuenosRel));
% pmedioClustBuenosRel=mean(clustBuenosRel); %ahora promedio los sujetos
% 
% %sujetos malos en relaciones
% clustMalosRel=mean(sujMalosRel(ROI,:),1); %colapso los canales de la ROI para los sujetos malos en relaciones
% errMalosRel=std(clustMalosRel)/sqrt(length(clustMalosRel));
% pmedioClustMalosRel=mean(clustMalosRel); %ahora promedio los sujetos
% 
% [h,pRel,ci,stats]=ttest2(clustBuenosRel,clustMalosRel,'tail','left');
% pRel

subplot(1,2,1);
bar([1,2], [pmedioClustMalosNom,pmedioClustBuenosNom]);
hold on
errorbar([1,2], [pmedioClustMalosNom,pmedioClustBuenosNom],[errMalosNom,errBuenosNom],'r.');
ylim([0,0.6]);
hold on
set(gca,'xticklabel',{'malos','buenos'});
title('Nombres');

subplot(1,2,2);
bar([1,2], [pmedioClustMalosDef,pmedioClustBuenosDef]);
hold on
errorbar([1,2], [pmedioClustMalosDef,pmedioClustBuenosDef],[errMalosDef,errBuenosDef],'r.');
ylim([0,0.6]);
hold on
set(gca,'xticklabel',{'malos','buenos'});
title('Definiciones');

% subplot(1,3,3);
% bar([1,2], [pmedioClustMalosRel,pmedioClustBuenosRel]);
% hold on
% errorbar([1,2], [pmedioClustMalosRel,pmedioClustBuenosRel],[errMalosRel,errBuenosRel],'r.');
% ylim([0,0.45]);
% hold on
% set(gca,'xticklabel',{'malos','buenos'});
% title('Relaciones');
% 

close all
clear all
clc
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');

%% levanto los datos de excel

 nombre=xlsread('C:\EEG\clusters\datos.xlsx', 'T2:T35');  %levanto datos de excel
 definicion=xlsread('C:\EEG\clusters\datos.xlsx', 'U2:U35');
 siRel=xlsread('C:\EEG\clusters\datos.xlsx', 'C2:C35');
 noRel=xlsread('C:\EEG\clusters\datos.xlsx', 'E2:E35');
 indzSiRel=find(isnan(siRel)==1);        %busco los sujetos que no hicieron la prueba de palabras relacionadas;
 siRel(indzSiRel)=0;
 indzNoRel=find(isnan(noRel)==1);        %busco los sujetos que no hicieron la prueba de palabras relacionadas;
 noRel(indzNoRel)=0;
 relacion=siRel-noRel;
 
%% 

banda=3;


if(banda==1) %delta1
    ROI=[23,21,10,14];
    frec='delta1';
    direccion={'C:\EEG\fft\bandas\delta\sujNormTot\s'};
    FRANGE=[1:0.2:3];
elseif(banda==2) %delta2
    ROI=[1,30,9,28];
    frec='delta2';
    direccion={'C:\EEG\fft\bandas\delta\sujNormTot\s'};
    FRANGE=[1:0.2:3];
elseif(banda==3) %theta1
     ROI=[28, 2, 17, 10];
     frec='theta1';
    direccion={'C:\EEG\fft\bandas\theta\sujNormTot\s'};
    FRANGE=[4:0.2:8];
elseif(banda==4) %theta2
     ROI=[18, 20, 21, 17];
     frec='theta2';
    direccion={'C:\EEG\fft\bandas\theta\sujNormTot\s'};
    FRANGE=[4:0.2:8];
elseif(banda==5) %alfa
    ROI=[29,19,4,12];
    frec='alfa';
    direccion={'C:\EEG\fft\bandas\alfa\sujNormTot\s'};
    FRANGE=[8:0.2:12];
elseif(banda==6) %betaLow
    ROI=[29,19,4,12];
    frec='betaLow';
    direccion={'C:\EEG\fft\bandas\beta1\sujNormTot\s'};
    FRANGE=[12:0.5:22];
elseif(banda==7) %betaHigh1
     ROI=[22, 2, 20, 3];
     frec='betaHigh1';
    direccion={'C:\EEG\fft\bandas\beta2\sujNormTot\s'};       
    FRANGE=[22:0.5:35];
elseif(banda==8) %betaHigh2
     ROI=[17, 20, 28, 21];
     frec='betaHigh2';
    direccion={'C:\EEG\fft\bandas\beta2\sujNormTot\s'};   
    FRANGE=[22:0.5:35];
elseif(banda==9) %betaHigh3
     ROI=[21, 10, 23, 11];
     frec='betaHigh3';
    direccion={'C:\EEG\fft\bandas\beta2\sujNormTot\s'};   
    FRANGE=[22:0.5:35];
elseif(banda==10) %betaHigh4
     ROI=[5, 13, 29, 19];
     frec='betaHigh4';
    direccion={'C:\EEG\fft\bandas\beta2\sujNormTot\s'};   
    FRANGE=[22:0.5:35];
elseif(banda==11) %betaHighCompTheta
    ROI=[28,2,17,10, 22, 20, 21, 23, 18];
    frec='betaHigh5';
    direccion={'C:\EEG\fft\bandas\beta2\sujNormTot\s'};   
    FRANGE=[22:0.5:35];
elseif(banda==12) %thetaCompBetaHigh
    ROI=[28,2,17,10, 22, 20, 21, 23, 18];
    frec='theta3';
    direccion={'C:\EEG\fft\bandas\theta\sujNormTot\s'};
    FRANGE=[4:0.2:8];
elseif(banda==13) %betaHighCompTheta2
    ROI=[18 24 25 19];
    frec='betaHigh6';
    direccion={'C:\EEG\fft\bandas\beta2\sujNormTot\s'};   
    FRANGE=[22:0.5:35];
elseif(banda==14) %betaHighCompTheta3
    ROI=[18 24 25 19 20 11];
    frec='betaHigh7';
    direccion={'C:\EEG\fft\bandas\beta2\sujNormTot\s'};   
    FRANGE=[22:0.5:35];
elseif(banda==15) %thetaCompBetaHigh2
    ROI=[18 24 25 19];
    frec='theta4';
    direccion={'C:\EEG\fft\bandas\theta\sujNormTot\s'};
    FRANGE=[4:0.2:8];
elseif(banda==16) %thetaCompBetaHigh3
    ROI=[18 24 25 19 20 11];
    frec='theta5';
    direccion={'C:\EEG\fft\bandas\theta\sujNormTot\s'};
    FRANGE=[4:0.2:8];
end


%% divido en buenos y malos aprendedores para nombres y definiciones

%nombre([30 28 18])=[];
%definicion([30 28 18])=[];
%relacion([30 28 18])=[];

perc1Nom=prctile(nombre,100*1/3);  %para nombre 
perc2Nom=prctile(nombre,100*2/3);  %para nombre

perc1Def=prctile(definicion,100*1/3);  %para nombre
perc2Def=prctile(definicion,100*2/3);  %para nombre

perc1Rel=prctile(relacion,100*1/3);  %para nombre
perc2Rel=prctile(relacion,100*2/3);  %para nombre

relacion([indzSiRel indzNoRel])=nan;

suj1Nom=[];   %inicializo
numSuj1Nom=[];
suj2Nom=[];
numSuj2Nom=[];
suj3Nom=[];
numSuj3Nom=[];

suj1Def=[];
numSuj1Def=[];
suj2Def=[];
numSuj2Def=[];
suj3Def=[];
numSuj3Def=[];

suj1Rel=[];
numSuj1Rel=[];
suj2Rel=[];
numSuj2Rel=[];
suj3Rel=[];
numSuj3Rel=[];
temp=[];

nombre([18,28,30])=nan;
defincion([18,28,30])=nan;
relacion([18,28,30])=nan;

for i=1:34 
    
     if i ~=18 && i ~= 28 && i ~= 30   %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es igual a alguno no entra
      
        suj=load(char(strcat(direccion,num2str(i),'.mat')));
        suj=suj.suj;
        suj=cast(suj,'double');
        
        suj=mean(suj,3); %promedio en frecuencias
        suj=mean(suj,2); %promedio en tiempos
        %suj=mean(suj(ROI),1);
        suj=squeeze(suj);
        
        clust(i)=mean(suj(ROI));  %hago un clust con el promedio de las energías de los canales de ese ROI para cada sujeto para el grafico de puntos
        
        if nombre(i)<perc1Nom          %para nombre
            suj1Nom=[suj1Nom suj];
            numSuj1Nom=[numSuj1Nom i];
        elseif nombre(i)>perc1Nom && nombre(i)<perc2Nom
           suj2Nom=[suj2Nom suj];
           numSuj2Nom=[numSuj2Nom i];
        elseif nombre(i)>perc2Nom
            suj3Nom=[suj3Nom suj];
            numSuj3Nom=[numSuj3Nom i];
            temp=[temp i];
        end
            
        if definicion(i)<perc1Def        %para definicion
            suj1Def=[suj1Def suj];
            numSuj1Def=[numSuj1Def i];
        elseif definicion(i)>perc1Def && definicion(i)<perc2Def
           suj2Def=[suj2Def suj];
           numSuj2Def=[numSuj2Def i];
        elseif definicion(i)>perc2Def
            suj3Def=[suj3Def suj];
            numSuj3Def=[numSuj3Def i];
        end
        
        if ismember(i,[indzSiRel indzNoRel])==0 %si el sujeto NO es uno de los que no tienen datos en relaciones     
                if relacion(i)<perc1Rel          %para relacion
                    suj1Rel=[suj1Rel suj];
                    numSuj1Rel=[numSuj1Rel i];
                elseif relacion(i)>perc1Rel && relacion(i)<perc2Rel
                   suj2Rel=[suj2Rel suj];
                   numSuj2Rel=[numSuj2Rel i];
                elseif relacion(i)>perc2Rel
                    suj3Rel=[suj3Rel suj];
                    numSuj3Rel=[numSuj3Rel i];
                end
        end
     end
end        

clust([18,28,30])=nan;

clust=clust';

indz=find(clust==0);        %busco los sujetos que no sirven;
%clust(indz)=[];                  %los dejo vacios
% nombre(indz)=[];
% definicion(indz)=[];
% 
% indzRel=find(relacion==0);        %busco los sujetos que no hicieron la prueba de palabras relacionadas;
% relacion(indzRel)=[];                 %los dejo vacios

%% grafico de barras  

if(banda~=1 && banda~=2)
    
%primer percentil en nombres
clust1Nom=mean(suj1Nom(ROI,:),1); %colapso los canales de la ROI para los sujetos buenos en nombres
err1Nom=std(clust1Nom)/sqrt(length(clust1Nom));
pmedioClust1Nom=mean(clust1Nom); %ahora promedio los sujetos

%segundo percentil en nombres
clust2Nom=mean(suj2Nom(ROI,:),1); %colapso los canales de la ROI para los sujetos buenos en nombres
err2Nom=std(clust2Nom)/sqrt(length(clust2Nom));
pmedioClust2Nom=mean(clust2Nom); %ahora promedio los sujetos

%tercer percentil en nombres
clust3Nom=mean(suj3Nom(ROI,:),1); %colapso los canales de la ROI para los sujetos buenos en nombres
err3Nom=std(clust3Nom)/sqrt(length(clust3Nom));
pmedioClust3Nom=mean(clust3Nom); %ahora promedio los sujetos

% [h,pNom12,ci,stats]=ttest2(clust1Nom,clust2Nom,'tail','left');
% pNom12
% 
% [h,pNom23,ci,stats]=ttest2(clust2Nom,clust3Nom,'tail','right');
% pNom23
% 
% [h,pNom13,ci,stats]=ttest2(clust1Nom,clust3Nom,'tail','left');
% pNom13

%primer percentil en definiciones
clust1Def=mean(suj1Def(ROI,:),1); %colapso los canales de la ROI para los sujetos buenos en definicniones
err1Def=std(clust1Def)/sqrt(length(clust1Def));
pmedioClust1Def=mean(clust1Def); %ahora promedio los sujetos

%segundo percentil en definiciones
clust2Def=mean(suj2Def(ROI,:),1); %colapso los canales de la ROI para los sujetos buenos en definicniones
err2Def=std(clust2Def)/sqrt(length(clust2Def));
pmedioClust2Def=mean(clust2Def); %ahora promedio los sujetos

%tercer percentil en definiciones
clust3Def=mean(suj3Def(ROI,:),1); %colapso los canales de la ROI para los sujetos buenos en definicniones
err3Def=std(clust3Def)/sqrt(length(clust3Def));
pmedioClust3Def=mean(clust3Def); %ahora promedio los sujetos

% [h,pDef12,ci,stats]=ttest2(clust1Def,clust2Def,'tail','left');
% pDef12
% 
% [h,pDef23,ci,stats]=ttest2(clust2Def,clust3Def,'tail','right');
% pDef23
% 
% [h,pDef13,ci,stats]=ttest2(clust1Def,clust3Def,'tail','right');
% pDef13

subplot(1,2,1);
bar([1,2,3], [pmedioClust1Nom,pmedioClust2Nom,pmedioClust3Nom]);
hold on
errorbar([1,2,3], [pmedioClust1Nom,pmedioClust2Nom,pmedioClust3Nom],[err1Nom,err2Nom,err3Nom],'r.');
%ylim([0,0.5]);
hold on
set(gca,'xticklabel',{'prctil1', '´prctil2','prctil3'});
title('Nombres');

subplot(1,2,2);
bar([1,2,3], [pmedioClust1Def,pmedioClust2Def,pmedioClust3Def]);
hold on
errorbar([1,2,3], [pmedioClust1Def,pmedioClust2Def,pmedioClust3Def],[err1Def,err2Def,err3Def],'r.');
%ylim([0,0.5]);
hold on
set(gca,'xticklabel',{'prctil1', '´prctil2','prctil3'});
title('Definiciones');

else

relacion([indzSiRel indzNoRel])=[]; %saco para relaciones los que no tienen datos

%primer percentil en relaciones
clust1Rel=mean(suj1Rel(ROI,:),1); %colapso los canales de la ROI para los sujetos buenos en relaciones
err1Rel=std(clust1Rel)/sqrt(length(clust1Rel));
pmedioClust1Rel=mean(clust1Rel); %ahora promedio los sujetos

%segundo percentil en relaciones
clust2Rel=mean(suj2Rel(ROI,:),1); %colapso los canales de la ROI para los sujetos buenos en relaciones
err2Rel=std(clust2Rel)/sqrt(length(clust2Rel));
pmedioClust2Rel=mean(clust2Rel); %ahora promedio los sujetos

%tercer percentil en relaciones
clust3Rel=mean(suj3Rel(ROI,:),1); %colapso los canales de la ROI para los sujetos buenos en relaciones
err3Rel=std(clust3Rel)/sqrt(length(clust3Rel));
pmedioClust3Rel=mean(clust3Rel); %ahora promedio los sujetos

% [h,pRel12,ci,stats]=ttest2(clust1Rel,clust2Rel,'tail','left');
% pRel12
% 
% [h,pRel23,ci,stats]=ttest2(clust2Rel,clust3Rel,'tail','right');
% pRel23
% 
% [h,pRel13,ci,stats]=ttest2(clust1Rel,clust3Rel,'tail','left');
% pRel13

bar([1,2,3], [pmedioClust1Rel,pmedioClust2Rel,pmedioClust3Rel]);
hold on
errorbar([1,2,3], [pmedioClust1Rel,pmedioClust2Rel,pmedioClust3Rel],[err1Rel,err2Rel,err3Rel],'r.');
%ylim([0,3.5]);
hold on
set(gca,'xticklabel',{'prctil1', '´prctil2','prctil3'});
title('Relaciones');

end
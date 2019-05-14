clear all
close all

banda=7

%elijo frecuencia
if banda==1
frange=[1:0.2:3];  %delta
    direcc='F:\pasantías Luchi\resting48hs\datosFieldtrip\delta';
elseif banda==2
    frange=[4:0.2:8];  %theta
    direcc='F:\pasantías Luchi\resting48hs\datosFieldtrip\theta';
elseif banda==3
    frange=[8:0.2:12]; %alfa
    direcc='F:\pasantías Luchi\resting48hs\datosFieldtrip\alfa';
elseif banda==4
     frange=[12:0.5:22]; %beta1
    direcc='F:\pasantías Luchi\resting48hs\datosFieldtrip\beta1';
elseif banda==5
    frange=[22:0.5:35]; %beta2
    direcc='F:\pasantías Luchi\resting48hs\datosFieldtrip\beta2';
elseif banda==6
    frange=[1:1:35]; %total
    direcc='F:\pasantías Luchi\resting48hs\datosFieldtrip\total';
elseif banda==7
    frange=[4:1:35]; %totalCut
    direcc='F:\pasantías Luchi\resting48hs\datosFieldtrip\totalCut';
end 

addpath C:\Users\lucía\Documents\MATLAB\fieldtrip-20180815

direccTot='F:\pasantías Luchi\resting48hs\datosFieldtrip\total';

charBuenosNom=[];
charMalosNom=[];
charBuenosDef=[];
charMalosDef=[];

buenosNom=load([direcc,'\datosEeglab\sujBuenosNom\buenosNom'], 'buenosNom');
malosNom=load([direcc,'\datosEeglab\sujMalosNom\malosNom'], 'malosNom');
buenosDef=load([direcc,'\datosEeglab\sujBuenosDef\buenosDef'], 'buenosDef');
malosDef=load([direcc,'\datosEeglab\sujMalosDef\malosDef'],'malosDef');


%% saco el largo minimo

sujTotPmedio=[];
notAvalTot=[];
   
%%

for i=1:23     
     if i~=3 && i ~= 14 && i ~= 16 && i ~= 18  && i ~= 15 && i~=17
         
         if find(i==buenosNom.buenosNom) ~=0
            suj=load([direcc,'\datosEeglab\sujBuenosNom\s',num2str(i),'.mat']);
            sujTot=load([direccTot,'\datosEeglab\sujBuenosNom\s',num2str(i),'.mat']);
        elseif find(i==malosNom.malosNom) ~=0
            suj=load([direcc,'\datosEeglab\sujMalosNom\s',num2str(i),'.mat']);
            sujTot=load([direccTot,'\datosEeglab\sujMalosNom\s',num2str(i),'.mat']);
         end
         
         sujTotPmedio=mean(sujTot.sujFinE.freq.powspctrm,3); %promedio en tiempos 
         sujTotPmedio=mean(sujTotPmedio,2);     %promedio en frecuencias 
         sujTotPmedio=mean(sujTotPmedio,1);    %promedio en canales 
         
         suj.sujFinE.freq.powspctrm=suj.sujFinE.freq.powspctrm/sujTotPmedio;      %normalizo cada sujeto respecto a si mismo
         
         %los guardo
         
         %nombres
         if find(i==buenosNom.buenosNom) ~=0
            save([direcc,'\sujNormalizados\buenosNom\s',num2str(i),'.mat'],'suj');
          else
            save([direcc,'\sujNormalizados\malosNom\s',num2str(i),'.mat'],'suj');
          end
         %definiciones 
          if find(i==buenosDef.buenosDef) ~=0
            save([direcc,'\sujNormalizados\buenosDef\s',num2str(i),'.mat'],'suj');
          else
            save([direcc,'\sujNormalizados\malosDef\s',num2str(i),'.mat'],'suj');
          end
          
     end
end


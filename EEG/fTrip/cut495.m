clear all
close all

banda=6

%elijo frecuencia
if banda==1
frange=[1:0.2:3];  %delta
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\delta';
elseif banda==2
    frange=[4:0.2:8];  %theta
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\theta';
elseif banda==3
    frange=[8:0.2:12]; %alfa
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\alfa';
elseif banda==4
     frange=[12:0.5:22]; %beta1
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\beta1';
elseif banda==5
    frange=[22:0.5:35]; %beta2
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\beta2';
elseif banda==6
    frange=[1:1:35]; %total
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\total';
end   

addpath C:\Users\lucía\Documents\MATLAB\fieldtrip-20180815

charBuenosNom=[];
charMalosNom=[];
charBuenosDef=[];
charMalosDef=[];

buenosNom=load([direcc,'\freqAnalysis\sujBuenosNom\buenosNom'], 'buenosNom');
malosNom=load([direcc,'\freqAnalysis\sujMalosNom\malosNom'], 'malosNom');
buenosDef=load([direcc,'\freqAnalysis\sujBuenosDef\buenosDef'], 'buenosDef');
malosDef=load([direcc,'\freqAnalysis\sujMalosDef\malosDef'],'malosDef');



%% Normalizo cada sujeto respecto a si mismo


%% saco el largo minimo

sujTotPmedio=[];
notAvalTot=[];

largoMin=495-1;
   
%%

for i=1:34 
     if i~=[18 28 30 4 16 32] 
         
         if find(i==buenosNom.buenosNom) ~=0
            suj=load([direcc,'\freqAnalysis\sujBuenosNom\s',num2str(i),'.mat']);
        elseif find(i==malosNom.malosNom) ~=0
            suj=load([direcc,'\freqAnalysis\sujMalosNom\s',num2str(i),'.mat']);
         end
      
         suj.freq.powspctrm=suj.freq.powspctrm(:,:,1:largoMin);   %lo corto hasta 607 en tiempos
         suj.freq.time=suj.freq.time(:,1:largoMin);
         
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




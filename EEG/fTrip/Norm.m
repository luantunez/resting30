clear all
close all

banda=1

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

direccTot='F:\pasantías Luchi\resting\datosFieldtrip\total';

charBuenosNom=[];
charMalosNom=[];
charBuenosDef=[];
charMalosDef=[];

buenosNom=load([direcc,'\freqAnalysis\sujBuenosNom\buenosNom'], 'buenosNom');
malosNom=load([direcc,'\freqAnalysis\sujMalosNom\malosNom'], 'malosNom');
buenosDef=load([direcc,'\freqAnalysis\sujBuenosDef\buenosDef'], 'buenosDef');
malosDef=load([direcc,'\freqAnalysis\sujMalosDef\malosDef'],'malosDef');

%convierto a un char con las estructuras de los sujetos de cada categoria
%(buenos nombres, malos nombres, buenos definiciones, malos definiciones)
% 
% for i=1:23     
%      if i~=3 && i ~= 14 && i ~= 16 && i ~= 18  && i ~= 15 && i~=17    %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es igual a alguno no entra                 
%         if find(i==buenosNom.buenosNom) ~=0
%             sujF(i)=load([direcc,'\freqAnalysis\sujBuenosNom\s',num2str(i),'.mat']);
%         elseif find(i==malosNom.malosNom) ~=0
%             sujF(i)=load([direcc,'\freqAnalysis\sujMalosNom\s',num2str(i),'.mat']);
%         end
% %         if find(i==buenosDef.buenosDef) ~=0
% %             sujF(i)=load([direcc,'\freqAnalysis\sujBuenosDef\s',num2str(i),'.mat']);
% %         elseif find(i==malosDef.malosDef) ~=0
% %             sujF(i)=load([direcc,'\freqAnalysis\sujMalosDef\s',num2str(i),'.mat']);
% %         end
%      end
% end  


%% Normalizo cada sujeto respecto a si mismo


%% saco el largo minimo

sujTotPmedio=[];
notAvalTot=[];

for i=1:34 
     if i~=[18 28 30 4 16 32] 
         
         if find(i==buenosNom.buenosNom) ~=0
            suj=load([direcc,'\freqAnalysis\sujBuenosNom\s',num2str(i),'.mat']);
            sujTot=load([direccTot,'\freqAnalysis\sujBuenosNom\s',num2str(i),'.mat']);
        elseif find(i==malosNom.malosNom) ~=0
            suj=load([direcc,'\freqAnalysis\sujMalosNom\s',num2str(i),'.mat']);
            sujTot=load([direccTot,'\freqAnalysis\sujMalosNom\s',num2str(i),'.mat']);
         end
               
         notAval = find(isnan(suj.freq.powspctrm(1,1,:)));
         if isempty(notAval);
         else
            notAvalTot=[notAvalTot notAval(1)];  %guardo las posiciones del primer Nan de cada sujeto
         end

     end
end

[largoMin,sujetoMin]=min(notAvalTot);
largoMin=largoMin-1;
   
%%

for i=1:34 
     if i~=[18 28 30 4 16 32] 
         
         if find(i==buenosNom.buenosNom) ~=0
            suj=load([direcc,'\freqAnalysis\sujBuenosNom\s',num2str(i),'.mat']);
            sujTot=load([direccTot,'\freqAnalysis\sujBuenosNom\s',num2str(i),'.mat']);
        elseif find(i==malosNom.malosNom) ~=0
            suj=load([direcc,'\freqAnalysis\sujMalosNom\s',num2str(i),'.mat']);
            sujTot=load([direccTot,'\freqAnalysis\sujMalosNom\s',num2str(i),'.mat']);
         end
      
         suj.freq.powspctrm=suj.freq.powspctrm(:,:,1:largoMin);   %lo corto hasta 607 en tiempos
         suj.freq.time=suj.freq.time(:,1:largoMin);
         
         sujTot.freq.powspctrm=sujTot.freq.powspctrm(:,:,1:largoMin);
         sujTot.freq.time=sujTot.freq.time(:,1:largoMin);
         
         sujTotPmedio=mean(sujTot.freq.powspctrm,3); %promedio en tiempos 
         sujTotPmedio=mean(sujTotPmedio,2);     %promedio en frecuencias 
         sujTotPmedio=mean(sujTotPmedio,1);    %promedio en canales 
         
         suj.freq.powspctrm=suj.freq.powspctrm/sujTotPmedio;      %normalizo cada sujeto respecto a si mismo
         
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




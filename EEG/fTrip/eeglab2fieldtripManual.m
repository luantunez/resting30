clear all
close all

banda=7

%elijo frecuencia
if banda==1
frange=[1:0.2:3];  %delta
    direccEeg='F:\pasantías Luchi\resting\fft\bandas\delta\RhoP';
    direccField='F:\pasantías Luchi\resting\datosFieldtrip\delta';
    direccGuardar='F:\pasantías Luchi\resting\datosFieldtrip\delta\datosEeglab';
elseif banda==2
    frange=[4:0.2:8];  %theta
    direccEeg='F:\pasantías Luchi\resting\fft\bandas\theta\RhoP';
    direccField='F:\pasantías Luchi\resting\datosFieldtrip\theta';
    direccGuardar='F:\pasantías Luchi\resting\datosFieldtrip\theta\datosEeglab';
elseif banda==3
    frange=[8:0.2:12]; %alfa
    direccEeg='F:\pasantías Luchi\resting\fft\bandas\alfa\RhoP';
    direccField='F:\pasantías Luchi\resting\datosFieldtrip\alfa';
    direccGuardar='F:\pasantías Luchi\resting\datosFieldtrip\alfa\datosEeglab';
elseif banda==4
     frange=[12:0.5:22]; %beta1
     direccEeg='F:\pasantías Luchi\resting\fft\bandas\beta1\RhoP';
    direccField='F:\pasantías Luchi\resting\datosFieldtrip\beta1';
    direccGuardar='F:\pasantías Luchi\resting\datosFieldtrip\beta1\datosEeglab';
elseif banda==5
    frange=[22:0.5:35]; %beta2
    direccEeg='F:\pasantías Luchi\resting\fft\bandas\beta2\RhoP';
    direccField='F:\pasantías Luchi\resting\datosFieldtrip\beta2';
    direccGuardar='F:\pasantías Luchi\resting\datosFieldtrip\beta2\datosEeglab';
elseif banda==6
    frange=[1:1:35]; %total
    direccEeg='F:\pasantías Luchi\resting\fft\bandas\total\RhoP';
    direccField='F:\pasantías Luchi\resting\datosFieldtrip\total';
    direccGuardar='F:\pasantías Luchi\resting\datosFieldtrip\total\datosEeglab';
elseif banda==7
    frange=[4:1:35]; %totalCut
    direccEeg='F:\pasantías Luchi\resting\fft\bandas\totalCut\RhoP';
    direccField='F:\pasantías Luchi\resting\datosFieldtrip\totalCut';
    direccGuardar='F:\pasantías Luchi\resting\datosFieldtrip\totalCut\datosEeglab';
end 

addpath C:\Users\lucía\Documents\MATLAB\fieldtrip-20180815

buenosNom=load([direccField,'\freqAnalysis\sujBuenosNom\buenosNom'], 'buenosNom');
malosNom=load([direccField,'\freqAnalysis\sujMalosNom\malosNom'], 'malosNom');
buenosDef=load([direccField,'\freqAnalysis\sujBuenosDef\buenosDef'], 'buenosDef');
malosDef=load([direccField,'\freqAnalysis\sujMalosDef\malosDef'],'malosDef');


%% saco el largo minimo

largoMin=495;
   
%%

for i=1:34 
     if i~=[18 28 30 4 16 32] 
         
         sujEeg=load([direccEeg,'\s',num2str(i),'.mat']);  %cargo los datos de eeglab
         sujEeg.RhoP=sujEeg.RhoP(:,1:largoMin,:);   %corto los datos de eeglab (canales,tiempos,frecuencia)
         
         if find(i==buenosNom.buenosNom) ~=0    %cargo los datos de fieldtrip
            sujField=load([direccField,'\freqAnalysis\sujBuenosNom\s',num2str(i),'.mat']);
        elseif find(i==malosNom.malosNom) ~=0
            sujField=load([direccField,'\freqAnalysis\sujMalosNom\s',num2str(i),'.mat']);
         end
         
         sujFinE=sujField;      %creo una nueva matriz con los datos de fieltrip
         
         sujFinE.freq.powspctrm=sujFinE.freq.powspctrm(:,:,1:largoMin);        %corto los datos de la nueva matriz para que entren bien los de eeglab
         sujFinE.freq.time=sujFinE.freq.time(:,1:largoMin);
         
         %sujFinE.freq.powspctrm=sujEeg.Rho;     %guardo los datos de eeglab en el powspctrm de la nueva matriz
         sujFinE.freq.powspctrm=permute(sujEeg.RhoP,[1 3 2]);     %guardo los datos de eeglab en el powspctrm de la nueva matriz, dando vuelta la ultimas dos dimensiones (canales,frecuancias,tiempos)  
         
         %nombres
         if find(i==buenosNom.buenosNom) ~=0
            save([direccGuardar,'\sujBuenosNom\s',num2str(i),'.mat'],'sujFinE');
          else
            save([direccGuardar,'\sujMalosNom\s',num2str(i),'.mat'],'sujFinE');
          end
         %definiciones 
          if find(i==buenosDef.buenosDef) ~=0
            save([direccGuardar,'\sujBuenosDef\s',num2str(i),'.mat'],'sujFinE');
          else
            save([direccGuardar,'\sujMalosDef\s',num2str(i),'.mat'],'sujFinE');
          end
          
     end
end


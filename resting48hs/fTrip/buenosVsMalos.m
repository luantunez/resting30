close all
clear all

banda=6
nomDef=2  %1=nom, 2=def
posNeg=2 %1=pos, 2=neg

%elijo frecuencia
if banda==1
frange=[1:0.2:3];  %delta
    direcc='F:\pasantías Luchi\resting48hs\datosFieldtrip\delta';
    scal= [-5 5];
elseif banda==2
    frange=[4:0.2:8];  %theta
    direcc='F:\pasantías Luchi\resting48hs\datosFieldtrip\theta';
    scal= [-5 5];
elseif banda==3
    frange=[8:0.2:12]; %alfa
    direcc='F:\pasantías Luchi\resting48hs\datosFieldtrip\alfa';
    scal= [-10 10];
elseif banda==4
     frange=[12:0.5:22]; %beta1
    direcc='F:\pasantías Luchi\resting48hs\datosFieldtrip\beta1';
    scal= [-5 5];
elseif banda==5
    frange=[22:0.5:35]; %beta2
    direcc='F:\pasantías Luchi\resting48hs\datosFieldtrip\beta2'
    scal= [-5 3];
    scal= [-5 1];
    colorBar=[0.3 0.5];
elseif banda==6
    frange=[1:1:35]; %total
    direcc='F:\pasantías Luchi\resting48hs\datosFieldtrip\total';
    scal= [-5 1];
    %colorBar=[0.6 1.1];
    colorBar=[0.3 0.5];
elseif banda==7
    frange=[4:1:35]; %totalCut
    direcc='F:\pasantías Luchi\resting48hs\datosFieldtrip\totalCut';
    scal= [-5 1];
    colorBar=[0.6 1.1];
end 

direccBeta2='F:\pasantías Luchi\resting48hs\datosFieldtrip\beta2';

addpath C:\Users\lucía\Documents\MATLAB\fieldtrip-20180815
addpath C:\Users\lucía\Documents\MATLAB\fieldtrip-20180815\plotting

buenosNom=load([direcc,'\freqAnalysis\sujBuenosNom\buenosNom'], 'buenosNom');
buenosNom=buenosNom.buenosNom;
malosNom=load([direcc,'\freqAnalysis\sujMalosNom\malosNom'], 'malosNom');
malosNom=malosNom.malosNom;
buenosDef=load([direcc,'\freqAnalysis\sujBuenosDef\buenosDef'], 'buenosDef');
buenosDef=buenosDef.buenosDef;
malosDef=load([direcc,'\freqAnalysis\sujMalosDef\malosDef'],'malosDef');
malosDef=malosDef.malosDef;

electrodos=zeros(1,30); 
graficar=1; %graficar

%%%%%%%%%%%%%%%fin declaraciones

if nomDef==1    %nombres
    
    stat=load([direcc,'\freqStatistics\freqstNombres'],'freqstNombres');  %cargo nombres
    stat=stat.freqstNombres;
    
    if posNeg==1        %positivo
    
    %%posclusters nombres

        if stat.posclusters.prob<=0.05
            
            for i=1:30  %electrodos
                for j=1:size(frange,2)  %frecuencias
                    if stat.posclusteslabelmat(i,j)==1
                        electrodos(i)=electrodos(i)+1;  %voy contados la cantidad de electrdos con 1 para todas las frecuencias de la banda
                    end
                end
            end
        

            vect=1;
            for i=1:30      %me hago cun vector con los electrdos que parececen mas de 5 veces
                if electrodos(i)>5
                    cluster(vect)=i;
                    vect=vect+1;
                end
            end
            
        else disp('p>0.05');
            graficar=0; %no graficar
            
        end
        
    end

if posNeg==2        %negativo
    
%%neglustersNombres    
    
    if stat.negclusters.prob<=0.05
        
        for i=1:30  %electrodos
            for j=1:size(frange,2)  %frecuencias
                if stat.negclusterslabelmat(i,j)==1
                    electrodos(i)=electrodos(i)+1;  %voy contados la cantidad de electrdos con 1 para todas las frecuencias de la banda
                end
            end
        end
    

        vect=1;
        for i=1:30      %me hago cun vector con los electrdos que parececen mas de 5 veces
            if electrodos(i)>5
                cluster(vect)=i;
                vect=vect+1;
            end
        end
        
        else disp('p>0.05');
            graficar=0; %no graficar
    end
    
end

% sujFB=zeros(size(buenosDef,2),30,lenght(frange),495);
% sujFM=zeros(size(malosDef,2),30,lenght(frange),495);

%%%%%%%%%%%%graficar
if graficar==1
vectAmp=zeros(30,1);

for  i=1:size(buenosDef,2)
            
            sujFB(i)=load([direcc,'\sujNormalizados\buenosNom\s',num2str(buenosNom(i)),'.mat']); 
            sujFBp=mean(sujFB(i).suj.sujFinE.freq.powspctrm,3); %promedio en tiempos
            sujFBpp(:,i)=mean(sujFBp,2); %promedio en frecuencias
end

for i=1:size(malosDef,2)

            sujFM(i)=load([direcc,'\sujNormalizados\malosNom\s',num2str(malosNom(i)),'.mat']);  %sujetos malos
            sujFMp=mean(sujFM(i).suj.sujFinE.freq.powspctrm,3); %promedio en tiempos
            sujFMpp(:,i)=mean(sujFMp,2); %promedio en frecuencias
       
end

ampB=mean(sujFBpp,2)';
ampBp=ampB(cluster);   %veo para esos electrodos la amplitud    
pmedioB=mean(ampBp);
errB=std(ampBp)/sqrt(length(ampBp));     %y el error

ampM=mean(sujFMpp,2)';
ampMp=ampM(cluster);
pmedioM=mean(ampMp);
errM=std(ampBp)/sqrt(length(ampBp));

bar([1,2], [pmedioM,pmedioB]);
hold on
errorbar([1,2], [pmedioM,pmedioB],[errM,errB],'r.');
%ylim([0,0.45]);
hold on
set(gca,'xticklabel',{'malos','buenos'});
title('Nombres');

%%%%%%%%%%%%%topoplot

figure();

addpath('C:\Users\lucía\Documents\eeglab14_1_1b');
eeglab;

NOMBRE='s1';

ppal = 'direccion ppal';

filepathIN  = 'C:\Users\lucía\Dropbox\datos\';

EEG = pop_loadset('filename',[NOMBRE,'.set'], 'filepath', filepathIN);
EEG = eeg_checkset( EEG );
localizacion=EEG.chanlocs;

figure();
%subplot(1,2,1);
topoplot(ampB'-ampM',localizacion,'maplimits',colorBar,'emarker2',{[cluster],'o','k'});  
% title('Buenos en Nombres');
% subplot(1,2,2);
% topoplot(ampM',localizacion,'maplimits',colorBar,'emarker2',{[cluster],'o','k'});  
% title('Malos en Nombres');
disp(['cluster: ', num2str(cluster)]);  %se repiten mas de 5 veces

end



%%%%%%%%%%%%%%%%%%%%%%%%%%
    
elseif nomDef==2        %definiciones
  
    stat=load([direcc,'\freqStatistics\freqstDefiniciones'],'freqstDefiniciones');      %cargo definiciones
    stat=stat.freqstDefiniciones;

    %%posclustersDefiniciones
    
    if posNeg==1 %positivos
    
        if stat.posclusters.prob<=0.05
            
            for i=1:30  %electrodos
                for j=1:size(frange,2)  %frecuencias
                    if stat.posclusterslabelmat(i,j)==1
                        electrodos(i)=electrodos(i)+1;  %voy contados la cantidad de electrdos con 1 para todas las frecuencias de la banda
                    end
                end
            end
        

            vect=1;
            for i=1:30      %me hago cun vector con los electrdos que parececen mas de 5 veces
                if electrodos(i)>5
                    cluster(vect)=i;
                    vect=vect+1;
                end
            end
            
        else disp('p>0.05');
            graficar=0; %no graficar
        end
        
    end

%negclustersDefiniciones
%%aca voy a agregar una forma de de contar los
%%electrodos como un porcentaje (50%) de los que se activan de la banda beta2 que son 9 (entre la frecuencnia numero 27 y la 35) (en
%%vez de arbitrariamete 5)

if posNeg==2; %negativos

    if stat.negclusters.prob<=0.05
        
        for i=1:30  %electrodos
            for j=1:size(frange,2)  %frecuencias
                if stat.negclusterslabelmat(i,j)==1
                    electrodos(i)=electrodos(i)+1;  %voy contados la cantidad de electrdos con 1 para todas las frecuencias de la banda
                end
            end
        end
    

        vect=1;
        for i=1:30      %me hago cun vector con los electrdos que parececen mas de 5 veces
            %if electrodos(i)>5
            if electrodos(i)>0.5*9  %(5%) de los que se activan de la banda beta2 que son 9
                cluster(vect)=i;
                vect=vect+1;
            end
        end  
    
        else disp('p>0.05');
            graficar=0; %no graficar
    end
    
 end

    
%%ahora grafico

if graficar==1
vectAmp=zeros(30,1);

for  i=1:size(buenosDef,2)
            
            sujFB(i)=load([direcc,'\sujNormalizados\buenosDef\s',num2str(buenosDef(i)),'.mat']); 
            %sujFB(i)=load([direccBeta2,'\sujNormalizados\buenosDef\s',num2str(buenosDef(i)),'.mat']); 
            sujFBpCut=(sujFB(i).suj.sujFinE.freq.powspctrm(:,22:35,:)); %(:,22:35,:)->con esto selecciono las frecuencias a evaluar, corresponden al cluster beta2
            sujFBp=mean(sujFBpCut,3); %promedio en tiempos  
            sujFBpp(:,i)=mean(sujFBp,2); %promedio en frecuencias
end

for i=1:size(malosDef,2)

            sujFM(i)=load([direcc,'\sujNormalizados\malosDef\s',num2str(malosDef(i)),'.mat']);  %sujetos malos
            %sujFM(i)=load([direccBeta2,'\sujNormalizados\malosDef\s',num2str(malosDef(i)),'.mat']);  %sujetos malos
            sujFMpCut=(sujFM(i).suj.sujFinE.freq.powspctrm(:,22:35,:)); %(:,22:35,:)->con esto selecciono las frecuencias a evaluar, corresponden al cluster beta2
            sujFMp=mean(sujFMpCut,3); %promedio en tiempos  
            sujFMpp(:,i)=mean(sujFMp,2); %promedio en frecuencias
       
end

ampB=mean(sujFBpp,2)';
ampBp=ampB(cluster);   %veo para esos electrodos la amplitud    
pmedioB=mean(ampBp);
errB=std(ampBp)/sqrt(length(ampBp));     %y el error

ampM=mean(sujFMpp,2)';
ampMp=ampM(cluster);
pmedioM=mean(ampMp);
errM=std(ampBp)/sqrt(length(ampBp));

bar([1,2], [pmedioM,pmedioB]);
hold on
errorbar([1,2], [pmedioM,pmedioB],[errM,errB],'r.');
%ylim([0,1.1]);
ylim([0,0.5]);
hold on
set(gca,'xticklabel',{'malos','buenos'});
title('Definiciones');

end

%%%%%%%%%%%%%topoplot

figure();

addpath('C:\Users\lucía\Documents\eeglab14_1_1b');
eeglab;

NOMBRE='s1';

ppal = 'direccion ppal';

filepathIN  = 'C:\Users\lucía\Dropbox\datos\';

EEG = pop_loadset('filename',[NOMBRE,'.set'], 'filepath', filepathIN);
EEG = eeg_checkset( EEG );
localizacion=EEG.chanlocs;

figure();
% subplot(2,1,1);
% topoplot(ampB',localizacion,'maplimits',colorBar,'emarker2',{[cluster],'o','k'});  
% title('Buenos en Definiciones');
% subplot(2,1,2);
% topoplot(ampM',localizacion,'maplimits',colorBar,'emarker2',{[cluster],'o','k'});  
% title('Malos en Definiciones');
% disp(['cluster: ', num2str(cluster)]);  %se repiten mas de 5 veces

colorBar=[-0.1 0.2];

topoplot(ampM'-ampB',localizacion,'maplimits',colorBar,'emarker2',{[cluster],'o','k'});  
title('Buenos en Definiciones');

figure()

topoplot(ampM',localizacion,'maplimits',colorBar,'emarker2',{[cluster],'o','k'});  
title('Malos en Definiciones');
disp(['cluster: ', num2str(cluster)]);  %se repiten mas de 5 veces
end



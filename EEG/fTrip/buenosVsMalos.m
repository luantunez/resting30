%%%%%%%%%%para banda total
close all
clear all

banda=6
posNeg=2 %1=pos, 2=neg
nclust=1 %que cluster de los neg 1 y 2 pos 3

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
    direcc30='F:\pasantías Luchi\resting\datosFieldtrip\total';
    direcc48='F:\pasantías Luchi\resting48hs\datosFieldtrip\total';
    scal= [-5 1];
    %colorBar=[0.5 0.9]; 
    %colorBar=[0.2 2.5];  %cluster 1
    %colorBar2=[-0.5 0.3];  %cluster 1 resta
    colorBar=[0.2 0.4];  %cluster 2
    colorBar2=[-0.05 0.02];  %cluster 2 resta
    %colorBar=[0 2];  %cluster 3
    %colorBar2=[0 0.7];  %cluster 3 resta
elseif banda==7
    frange=[4:1:35]; %totalCut
    direcc='F:\pasantías Luchi\resting48hs\datosFieldtrip\totalCut';
    scal= [-5 1];
    colorBar=[0.6 1.1];
end 

addpath C:\Users\lucía\Documents\MATLAB\fieldtrip-20180815
addpath C:\Users\lucía\Documents\MATLAB\fieldtrip-20180815\plotting

buenosNom30=load([direcc30,'\freqAnalysis\sujBuenosNom\buenosNom'], 'buenosNom');
buenosNom30=buenosNom30.buenosNom;
malosNom30=load([direcc30,'\freqAnalysis\sujMalosNom\malosNom'], 'malosNom');
malosNom30=malosNom30.malosNom;
buenosDef30=load([direcc30,'\freqAnalysis\sujBuenosDef\buenosDef'], 'buenosDef');
buenosDef30=buenosDef30.buenosDef;
malosDef30=load([direcc30,'\freqAnalysis\sujMalosDef\malosDef'],'malosDef');
malosDef30=malosDef30.malosDef;

buenosNom48=load([direcc48,'\freqAnalysis\sujBuenosNom\buenosNom'], 'buenosNom');
buenosNom48=buenosNom48.buenosNom;
malosNom48=load([direcc48,'\freqAnalysis\sujMalosNom\malosNom'], 'malosNom');
malosNom48=malosNom48.malosNom;
buenosDef48=load([direcc48,'\freqAnalysis\sujBuenosDef\buenosDef'], 'buenosDef');
buenosDef48=buenosDef48.buenosDef;
malosDef48=load([direcc48,'\freqAnalysis\sujMalosDef\malosDef'],'malosDef');
malosDef48=malosDef48.malosDef;

electrodos=zeros(1,30); 
graficar=1; %graficar

%%%%%%%%%%%%%%%fin declaraciones
    
    stat=load([direcc30,'\freqStatistics\freqstTotal3048'],'freqst3048');  %cargo stat Total (esta en 30 guardado)
    stat=stat.freqst3048;
    
            if nclust==1
            maxEl=3; %maximo numero de electrdos en el cluster
            idClust=2; %numero con que se identifica el cluster
            frecPres=[2:4]; %frecuencias invlucradas en el cluster
        elseif nclust==2
            maxEl=15;
            frecPres=[20:35];
            idClust=1;
        elseif nclust==3
            maxEl=5;
            frecPres=[7:11];
            idClust=1;
        end
            
    
    if posNeg==1        %positivo            

        if stat.posclusters.prob<=0.05
            
            for i=1:30  %electrodos
                for j=1:size(frange,2)  %frecuencias
                    if stat.posclusterslabelmat(i,j)==idClust
                        electrodos(i)=electrodos(i)+1;  %voy contados la cantidad de electrdos con 1 para todas las frecuencias de la banda
                    end
                end
            end
        

            vect=1;
            for i=1:30      %me hago cun vector con los electrdos que parececen mas de 5 veces
                if electrodos(i)>=0.5*maxEl
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
    
    if stat.negclusters(1).prob<=0.05       %(1) porque hay dos clusters, este es el signnificativo      
        for i=1:30  %electrodos
            for j=1:size(frange,2)  %frecuencias
                if stat.negclusterslabelmat(i,j)==idClust
                    electrodos(i)=electrodos(i)+1;  %voy contados la cantidad de electrdos con 1 para todas las frecuencias de la banda
                end
            end
        end
    

        vect=1;
        for i=1:30      %me hago cun vector con los electrdos que parececen mas de 5 veces
            if electrodos(i)>0.5*maxEl
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

for i=1:34      %30 min
     if i~=[18 28 30 4 16 32] 
            
         if find(i==buenosNom30) ~=0
            sujF30(i)=load([direcc30,'\sujNormalizados\buenosNom\s',num2str(i),'.mat']);
         elseif find(i==malosNom30)~=0 
            sujF30(i)=load([direcc30,'\sujNormalizados\malosNom\s',num2str(i),'.mat']); 
         end        %cargo todos
            sujF30pCut=(sujF30(i).suj.sujFinE.freq.powspctrm(:,frecPres,:)); %con esto selecciono las frecuencias a evaluar, corresponden al cluster beta2
            sujF30p=mean(sujF30pCut,3); %promedio en tiempos  
            sujF30pp(:,i)=mean(sujF30p,2); %promedio en frecuencias
     end
end

for i=1:23      %48 hs
     if i~=3 && i ~= 14 && i ~= 16 && i ~= 18  && i ~= 15 && i~=17  
            
         if find(i==buenosNom48) ~=0
            sujF48(i)=load([direcc48,'\sujNormalizados\buenosNom\s',num2str(i),'.mat']);
         elseif find(i==malosNom48)~=0 
            sujF48(i)=load([direcc48,'\sujNormalizados\malosNom\s',num2str(i),'.mat']); 
         end        %cargo todos
            sujF48pCut=(sujF48(i).suj.sujFinE.freq.powspctrm(:,frecPres,:)); %con esto selecciono las frecuencias a evaluar, corresponden al cluster beta2
            sujF48p=mean(sujF48pCut,3); %promedio en tiempos 
            sujF48pp(:,i)=mean(sujF48p,2); %promedio en frecuencias
     end
end


amp30=mean(sujF30pp,2)';
amp30p=amp30(cluster);   %veo para esos electrodos la amplitud    
pmedio30=mean(amp30p);
err30=std(amp30p)/sqrt(length(amp30p));     %y el error

amp48=mean(sujF48pp,2)';
amp48p=amp48(cluster);
pmedio48=mean(amp48p);
err48=std(amp48p)/sqrt(length(amp48p));

bar([1,2], [pmedio30,pmedio48]);
hold on
errorbar([1,2], [pmedio30,pmedio48],[err30,err48],'r.');
%ylim([0,0.45]);
hold on
set(gca,'xticklabel',{'30 min','48 hs'});

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
subplot(2,1,1);
topoplot(amp30',localizacion,'maplimits',colorBar,'emarker2',{[cluster],'o','k'});  
title('resting 30 min');
subplot(2,1,2);
topoplot(amp48',localizacion,'maplimits',colorBar,'emarker2',{[cluster],'o','k'});  
title('resting 48 hs');
disp(['cluster: ', num2str(cluster)]);  %se repiten mas de 5 ve

figure()
ampResta=amp30-amp48;
topoplot(ampResta',localizacion,'maplimits',colorBar2,'emarker2',{[cluster],'o','k'});  
title('resta 30 min - 48 hs');


end
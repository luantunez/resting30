clear all
close all

%dir()

banda=1

%elijo frecuencia
if banda==1
frange=[1:0.2:3];  %delta
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\delta';
    colorBar=[1.4 3];
    %colorBar=[0 2];
elseif banda==2
    frange=[4:0.2:8];  %theta
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\theta';
    colorBar=[0.5 1.8];
    %colorBar=[0.2 1.5];
elseif banda==3
    frange=[8:0.2:12]; %alfa
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\alfa';
    colorBar=[0.5 3];
    %colorBar=[0.2 2];
elseif banda==4
     frange=[12:0.5:22]; %beta1
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\beta1';
    colorBar=[0 0.6];
    colorBar=[0.2 1];
elseif banda==5
    frange=[22:0.5:35]; %beta2
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\beta2';
    colorBar=[0.02 0.08];
    colorBar=[0.2 0.4];
elseif banda==6
    frange=[1:1:35]; %total
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\total';
    colorBar=[0.6 1.1];
    %colorBar=[-2 8];
elseif banda==7
    frange=[4:1:35]; %totalCut
    direcc='F:\pasantías Luchi\resting\datosFieldtrip\totalCut';
    colorBar=[0.6 1];
end   

addpath C:\Users\lucía\Documents\MATLAB\fieldtrip-20180815

charBuenosNom=[];
charMalosNom=[];
charBuenosDef=[];
charMalosDef=[];

buenosNom=load([direcc,'\freqAnalysis\sujBuenosNom\buenosNom'], 'buenosNom');
buenosNom=buenosNom.buenosNom;
malosNom=load([direcc,'\freqAnalysis\sujMalosNom\malosNom'], 'malosNom');
malosNom=malosNom.malosNom;
buenosDef=load([direcc,'\freqAnalysis\sujBuenosDef\buenosDef'], 'buenosDef');
buenosDef=buenosDef.buenosDef;
malosDef=load([direcc,'\freqAnalysis\sujMalosDef\malosDef'],'malosDef');
malosDef=malosDef.malosDef;

%convierto a un char con las estructuras de los sujetos de cada categoria
%(buenos nombres, malos nombres, buenos definiciones, malos definiciones)

buenosNombres=[]
malosNombres=[]
buenosDefiniciones=[]
malosDefiniciones=[]
bn=[]
mn=[]
bd=[]
md=[]


for i=1:34 
     if i~=[18 28 30 4 16 32]     %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es igual a alguno no entra                 
        if find(i==buenosNom) ~=0
            suj=load([direcc,'\sujNormalizados\buenosNom\s',num2str(i),'.mat']);
            buenosNombres=mean(suj.suj.sujFinE.freq.powspctrm,3);
            buenosNombres=mean(buenosNombres,2);
            bn=[bn buenosNombres];
        elseif find(i==malosNom) ~=0
            suj=load([direcc,'\sujNormalizados\malosNom\s',num2str(i),'.mat']);
            malosNombres=mean(suj.suj.sujFinE.freq.powspctrm,3);
            malosNombres=mean(malosNombres,2);
            mn=[mn malosNombres];
        end
        if find(i==buenosDef) ~=0
            suj=load([direcc,'\sujNormalizados\buenosDef\s',num2str(i),'.mat']);
            buenosDefiniciones=mean(suj.suj.sujFinE.freq.powspctrm,3);
            buenosDefiniciones=mean(buenosDefiniciones,2);
            bd=[bd buenosNombres];
        elseif find(i==malosDef) ~=0
            suj=load([direcc,'\sujNormalizados\malosDef\s',num2str(i),'.mat']);
            malosDefiniciones=mean(suj.suj.sujFinE.freq.powspctrm,3);
            malosDefiniciones=mean(malosDefiniciones,2);
            md=[md malosDefiniciones];
        end
     end
end  

totNom=[bn mn];

totNom=mean(totNom,2);
mNom=mean(mn,2);
bDef=mean(bd,2);
mDef=mean(md,2);

total=[];

% for i=1:34
%     if i ~=[18    28    30     4    16    32    16]   %los sujetos que no sirven y los que contestaron 0 bien, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es iguala a alguno no entra
%         load([direc,num2str(i),'.mat']); 
%         sujP=mean(suj,3); %promedio en frecuencias
%         sujP=mean(sujP,2); %promedio en tiempos
%         sujP=squeeze(sujP);
%         total=[total sujP]; %(:,1:largoMin,:);
%     end
% end
% 
% pmedioTot=squeeze(mean(total,2)); %promedio en sujetos (se pusieron como columnas)


%% Grafico el promedio

addpath('C:\Users\lucía\Documents\eeglab14_1_1b');
eeglab;

NOMBRE='s1';

ppal = 'direccion ppal';

filepathIN  = 'C:\Users\lucía\Dropbox\datos\';

EEG = pop_loadset('filename',[NOMBRE,'.set'], 'filepath', filepathIN);
EEG = eeg_checkset( EEG );
localizacion=EEG.chanlocs;


figure();
topoplot(totNom',localizacion,'maplimits',colorBar);
set(0,'defaultaxesfontsize',20);
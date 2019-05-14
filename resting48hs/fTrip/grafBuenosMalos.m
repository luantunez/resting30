clear all
close all

addpath C:\Users\lucía\Documents\MATLAB\fieldtrip-20180815

nombre=xlsread('C:\EEG\pasantias\compRest48.xlsx', 'C3:C25');  %levanto datos de excel
 nombre(17)=nan;    %falta suj 17 tal
 definicion=xlsread('C:\EEG\pasantias\compRest48.xlsx', 'D3:D25');
 definicion(17)=nan;    %falta suj 17 tal
 
%% obtengo medias

nombreMedia=nombre;
definicionMedia=definicion;

%para hacer el promedio:
nombreMedia([17 3 14 16 18 15])=[];
definicionMedia([17 3 14 16 18 15])=[];

medNom=median(nombreMedia);  %para nombre
medDef=median(definicionMedia);  %para definicion

meanNom=mean(nombreMedia);  %para nombre
meanDef=mean(definicionMedia);  %para definicion

%%%%%%%%%%%%%%%%%

plot(nombre,definicion,'o');
hold on
plot(ones(1,length(nombre))*medNom,definicion,'r');
hold on
plot(nombre,ones(1,length(definicion))*medDef,'r');
xlabel('porcentaje de nombres aprendidos por sujeto')
ylabel('porcentaje de definiciones aprendidas por sujeto')
ylim([0;100]);

hold on
%ajuste lineal
[r,m,b] = regression(nombre',definicion')
mld=fitlm(nombre,definicion);
x=[0:ceil(max(definicion'))];
y=m*x+b;
plot(x,y,'g');


% buenosNom=load([direcc,'\freqAnalysis\sujBuenosNom\buenosNom'], 'buenosNom');
% buenosNom=buenosNom.buenosNom;
% malosNom=load([direcc,'\freqAnalysis\sujMalosNom\malosNom'], 'malosNom');
% malosNom=malosNom.malosNom;
% buenosDef=load([direcc,'\freqAnalysis\sujBuenosDef\buenosDef'], 'buenosDef');
% buenosDef=buenosDef.buenosDef;
% malosDef=load([direcc,'\freqAnalysis\sujMalosDef\malosDef'],'malosDef');
% malosDef=malosDef.malosDef;



%convierto a un char con las estructuras de los sujetos de cada categoria
%(buenos nombres, malos nombres, buenos definiciones, malos definiciones)

% for i=1:23     
%      if i~=3 && i ~= 14 && i ~= 16 && i ~= 18  && i ~= 15 && i~=17    %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es igual a alguno no entra                 
%         if find(i==buenosNom) ~=0
%             sujF(i)=load([direcc,'\sujNormalizados\buenosNom\s',num2str(i),'.mat']);
%             if i~=buenosNom(end)
%                 charBuenosNom=[charBuenosNom,'sujF(',num2str(i),').suj.sujFinE.freq,'];
%             else
%                 charBuenosNom=[charBuenosNom,'sujF(',num2str(i),').suj.sujFinE.freq'];
%             end
%         elseif find(i==malosNom) ~=0
%             sujF(i)=load([direcc,'\sujNormalizados\malosNom\s',num2str(i),'.mat']);
%              if i~=malosNom(end)
%                 charMalosNom=[charMalosNom,'sujF(',num2str(i),').suj.sujFinE.freq,'];
%             else
%                 charMalosNom=[charMalosNom,'sujF(',num2str(i),').suj.sujFinE.freq'];
%              end
%         end
%         if find(i==buenosDef) ~=0
%             sujF(i)=load([direcc,'\sujNormalizados\buenosDef\s',num2str(i),'.mat']);
%             if i~=buenosDef(end)
%                 charBuenosDef=[charBuenosDef 'sujF(',num2str(i),').suj.sujFinE.freq,'];
%             else
%                 charBuenosDef=[charBuenosDef 'sujF(',num2str(i),').suj.sujFinE.freq'];
%             end
%         elseif find(i==malosDef) ~=0
%             sujF(i)=load([direcc,'\sujNormalizados\malosDef\s',num2str(i),'.mat']);
%             if i~=malosDef(end)
%                 charMalosDef=[charMalosDef,'sujF(',num2str(i),').suj.sujFinE.freq,'];
%             else
%                 charMalosDef=[charMalosDef,'sujF(',num2str(i),').suj.sujFinE.freq'];
%             end
%         end
%      end
% end  
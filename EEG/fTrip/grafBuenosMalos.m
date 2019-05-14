clear all
close all

addpath C:\Users\lucía\Documents\MATLAB\fieldtrip-20180815

 nombre=xlsread('F:\pasantías Luchi\resting\clusters\datos.xlsx', 'T2:T35');  %levanto datos de excel
 definicion=xlsread('F:\pasantías Luchi\resting\clusters\datos.xlsx', 'U2:U35');
 
%% divido en buenos y malos aprendedores para nombres y definiciones

indNom=find(nombre==0);  
indDef=find(definicion==0);  %saco los que no adivinaron nada


nombre2=nombre;
nombre2([18,28,30,indNom',indDef'])=[];
definicion2=definicion;
definicion2([18,28,30,indNom',indDef'])=[];

medNom=median(nombre2);  %para nombre
medDef=median(definicion2);  %para definicion

meanNom=mean(nombre2);  %para nombre
meanDef=mean(definicion2);  %para definicion

nombre([18,28,30,indNom',indDef'])=nan;
definicion([18,28,30,indNom',indDef'])=nan;

%%%%%%%%%%%%%%%%%

plot(nombre,definicion,'o');
hold on
plot(ones(1,length(nombre))*medNom,definicion,'r');
hold on
plot(nombre,ones(1,length(definicion))*medDef,'r');
xlabel('porcentaje de nombres aprendidos por sujeto')
ylabel('porcentaje de deiniciones aprendidas por sujeto')

% figure()
% plot(nombre,'or')
% hold on
% plot(definicion,'o')

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
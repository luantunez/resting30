close all
clear all
clc
addpath('C:\Users\luc�a\Documents\MATLAB\EEG\EEG2\fft');
%%
 
 %ROI comp 1
 r=1;
 
 if r==1
    ROI=[28,2,17,10, 22, 20, 21, 23, 18];
 elseif r==2
     ROI=[18 24 25 19];
 elseif r==3
     ROI=[18 24 25 19 20 11];
 end

    direccionB={'F:\pasant�as Luchi\resting48hs\fft\beta2\RhoNorm\s'};   
    direccionT={'F:\pasant�as Luchi\resting48hs\fft\theta\RhoNorm\s'};

for i=1:23 
    
     if i~=3 && i ~= 14 && i ~= 16 && i ~= 18  && i ~= 15   %los sujetos que no sirven, si es distinto de estos, hacer el promedio de los datos hasta largo min, sino no, si es igual a alguno no entra
      
         %para beta
        suj=load(char(strcat(direccionB,num2str(i),'.mat')));
        suj=suj.Rho;
        suj=cast(suj,'double');
        
        suj=mean(suj,3); %promedio en frecuencias
        suj=mean(suj,2); %promedio en tiempos
        %suj=mean(suj(ROI),1);
        suj=squeeze(suj);
        
        clustB(i)=mean(suj(ROI));  %hago un clust con el promedio de las energ�as de los canales de ese ROI para cada sujeto para el grafico de puntos
        
        %para theta
        suj=load(char(strcat(direccionT,num2str(i),'.mat')));
        suj=suj.Rho;
        suj=cast(suj,'double');
        
        suj=mean(suj,3); %promedio en frecuencias
        suj=mean(suj,2); %promedio en tiempos
        %suj=mean(suj(ROI),1);
        suj=squeeze(suj);
        
        clustT(i)=mean(suj(ROI));  %hago un clust con el promedio de las energ�as de los canales de ese ROI para cada sujeto para el grafico de puntos
     
     else
         clustT(i)=nan;
         clustB(i)=nan;
     end
end

clustT([3 14 16 18 15])=[];
clustB([3 14 16 18 15])=[];

%clust=clust';
%indz=find(clust==0);        %busco los sujetos que no sirven;
plot(clustT,clustB,'o','MarkerSize', 8);
xlabel('Theta');
ylabel('Beta superior');
%xlim([0.2,0.6]);
%ylim([0.2,0.6]);
hold on
%ajuste lineal
[r,m,b] = regression(clustT,clustB)
mld=fitlm(clustB',clustT');
x=[0:ceil(max(clustT))];
y=m*x+b;
plot(x,y,'r');



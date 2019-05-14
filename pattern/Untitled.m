close all
clear all
clc

%%48 horas

nombre=xlsread('C:\EEG\pasantias\compRest48.xlsx', 'C3:C25');  %levanto datos de excel
definicion=xlsread('C:\EEG\pasantias\compRest48.xlsx', 'D3:D25');
 
nombre2=nombre;
definicion2=definicion;

nombre2([17 3 14 16 18 15])=[];
definicion2([17 3 14 16 18 15])=[];

medNom2=median(nombre2);
medDef2=median(definicion2);

subplot(1,2,1);
hist(nombre2,2);
ylabel('cantidad de aprendedores');
xlabel('porcentaje de nombres aprendidos');
ylim([0,12]);
xlim([0,100]);
hold on 
plot([medNom2 medNom2],ylim,'r-'); %hago una raya en la mediana

subplot(1,2,2);
%hist(definicion,xDef);
hist(definicion2,2);
ylabel('cantidad de aparendedores');
xlabel('porcentaje de definiciones aprendidas');
%ylim([0,12]);
ylim([0,12]);
xlim([0,100]);
hold on
plot([medDef2 medDef2],ylim,'r-'); %hago una raya en la mediana

figure()

%%30 minutos

nombre=xlsread('F:\pasantías Luchi\resting\clusters\datos.xlsx', 'T2:T35');  %levanto datos de excel
definicion=xlsread('F:\pasantías Luchi\resting\clusters\datos.xlsx', 'U2:U35');

indNom=find(nombre==0);  
indDef=find(definicion==0);  %saco los que no adivinaron nada

nombre2=nombre;
nombre2([18,28,30,indNom',indDef'])=[];
definicion2=definicion;
definicion2([18,28,30,indNom',indDef'])=[];

medNom=median(nombre2);  %para nombre
medDef=median(definicion2);  %para definicion

subplot(1,2,1);
hist(nombre2,2);
ylabel('cantidad de aprendedores');
xlabel('porcentaje de nombres aprendidos');
ylim([0,20]);
xlim([0,100]);
hold on 
plot([medNom medNom],ylim,'r-'); %hago una raya en la mediana

subplot(1,2,2);
%hist(definicion,xDef);
hist(definicion2,2);
ylabel('cantidad de aparendedores');
xlabel('porcentaje de definiciones aprendidas');
ylim([0,20]);
xlim([0,100]);
hold on
plot([medDef medDef],ylim,'r-'); %hago una raya en la mediana


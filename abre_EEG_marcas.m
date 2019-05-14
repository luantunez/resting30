
% Abrir los datos como txt
close all
clear all
clc
os            = 'win';%'win';
if strcmp(os,'win')
%     fileIn        = 'C:\Users\Dropbox\EEG_laura\';
%     fileOut       = 'C:\Users\Dropbox\EEG_laura\prea\';
%     addpath('C:\Program Files\MATLAB\eeglab13_4_3b')
%     eeglab
%     localizacion  = 'C:\Users\luz\Dropbox\EEG_laura\prea\eeg\30locations.xyz';
% 

    fileIn        =   'C:\Users\Usuario\Dropbox\EEG_laura\';
    fileOut       =   'C:\Users\Usuario\Dropbox\EEG_laura\prea\';
    addpath('C:\Users\Usuario\Documents\MATLAB\eeglab13_5_4b');
    eeglab
    localizacion  = 'C:\Users\Usuario\Dropbox\EEG_laura\prea\eeg\30locations.xyz';
    
     elseif strcmp(os,'linux')  
%     fileIn        = 'C:\Users\laura\Dropbox\EEG_laura\48horas\';
%     fileOut       = 'C:\Users\laura\Dropbox\EEG_laura\prea\';
%     localizacion  = 'C:\Users\laura\Dropbox\EEG_laura\prea\eeg\30locations.xyz';
%     addpath('C:\Users\Usuario\Documents\MATLAB\eeglab13_5_4b')
%   eeglab
end


nombre        = 'flo';
nombreEEG     = '-10112016-priming';
fecha         = '2016-10-11'; 
% Carga datos comportamentales
load([fileOut,'datos_',nombre,'.mat']);
open([fileOut,'datos_',nombre,'.mat']);

latencias    = respuesta(:,2);
num_no_resp  = find(respuesta(:,2)==999);
num_marcas   = 2*length(latencias)-length(num_no_resp);


freq          = 256;
Externo       = 1; %Puede der 1 o  2


%% Levanta los datos
EEG         = pop_importdata('dataformat','ascii','nbchan',0,'data',[fileIn,nombre,nombreEEG,'.TXT'],'srate',freq,'pnts',0,'xmin',0);
EEG.setname = nombre;
EEG         = eeg_checkset( EEG );
ChExt       = EEG.data(19+Externo,:);
tiempos     = (1:size(EEG.data,2))*1/freq;
%% Busca marcas
temp       = smooth(ChExt,5); time = smooth(tiempos,5);
diferencia = diff(temp)';
cont=0;
for i=1:length(diferencia)
    %if diferencia(i)>0       %OJOOOOOOO%VER POR QUE ESTE VALOR de 10%%%%%%%%%%%%%%%%%%%%
     if diferencia(i)>10 
        aumento(i)=diferencia(i);
        cont=cont+1;
    else
        aumento(i)=0;
    end
end

%busco picos
temp = [0 0 diff(aumento)];
locs = [];pks=[];
cont=1;
for i=3:length(temp)-1
    if (temp(i+1)-temp(i)==0 && temp(i)-temp(i-1)>0 && temp(i)>10)
        pks(cont)=temp(i); locs(cont)=i; cont=cont+1;
    elseif (temp(i+1)-temp(i)<0 && temp(i)-temp(i-1)>0 && temp(i)>10)
        pks(cont)=temp(i); locs(cont)=i; cont=cont+1;
    end
   
end




marcasEEG = time(locs);
clf
figure
subplot(1,2,1)
plot(time,temp,'k-')
hold on
plot(time,[0 0 diff(aumento)],'r-')
% set(gca,'xlim',[0 260])
plot(time(locs), pks,'b*')
if (cont-1)==num_marcas
    annotation('textbox', [0.67 0.42 0.21 0.26],...
    'String',{'Numero de marcas correctas'}, 'FontSize',36,...
    'FontName','Abyssinica SIL',...
    'LineStyle','none'); 
end
%% Matriz de marcas 
% UNION CON DATOS COMPORTAMENTALES

temp = -999;
for i=1:length(num_no_resp)
    temp    = [temp (2*num_no_resp(i))-(i-1)];
end
temp = [temp 999];

for j=2:length(temp)
    pasa = [];
    for i=1:length(marcasEEG)
       if (i>=temp(j-1) && temp(j)>i)
            pasa =  [pasa i];
       end
    end
    ind{j-1}=pasa;
end
marcas = [];
for n=1:length(ind)
    marcas = [marcas marcasEEG(ind{n})' 0];
end
for i=1:length(marcas)/2
    ver(i) = (marcas(2*i)-marcas(2*i-1));
end

clf;
figure
set(gcf,'position',[78  515  1504  269])
plot(ver,'ro','markersize',10,'markerfacecolor','r')
hold on
plot(latencias/1000,'ko','markersize',12')
%plot(latencias,'ko','markersize',12')
for i=1:length(num_no_resp)
    plot([num_no_resp(i) num_no_resp(i)],ylim)
end
%%
prompt = 'Todas las marcas del EEG corresponden a marcas comportamentales';
dlg_title = 'complete para continuar (si/no)';
num_lines = 1;
def = {'si','hsv'};
answer=inputdlg(prompt,dlg_title,num_lines,def);



if strcmp(answer,'si')
    for i=1:length(marcas)/2
        matriz(i,1) = marcas(2*i-1);
        matriz(i,2) = marcas(2*i);
        matriz(i,3) = respuesta(i,3);
        matriz(i,4) = respuesta(i,4);
    end
else
    errordlg('ver todo el programa','File Error');
end


%% saca los canales externos

EEG = pop_select( EEG,'channel',[1:19 22:32] );
EEG = eeg_checkset( EEG );
if strcmp(nombre,'mai')
    for i=1:length(resp)
       clear temp
       temp = resp(i).corr;
       temp = temp(temp<168);
       EEG.event(i).estim  = matriz(temp,1);
       EEG.event(i).resp   = matriz(temp,2);
       EEG.event(i).cond   = resp(i).cond;
       EEG.event(i).matriz = matriz;
    end
elseif strcmp(nombre,'afr')
    for i=1:length(resp)
       clear temp
       temp = resp(i).corr;
       temp = temp(temp<178);
       EEG.event(i).estim  = matriz(temp,1);
       EEG.event(i).resp   = matriz(temp,2);
       EEG.event(i).cond   = resp(i).cond;
       EEG.event(i).matriz = matriz;
    end
elseif strcmp(nombre,'jyt')
     for i=1:length(resp)
       clear temp
       temp = resp(i).corr;
       temp = temp(temp<177);
       EEG.event(i).estim  = matriz(temp,1);
       EEG.event(i).resp   = matriz(temp,2);
       EEG.event(i).cond   = resp(i).cond;
       EEG.event(i).matriz = matriz;
     end
elseif strcmp(nombre,'vim')
     for i=1:length(resp)
       clear temp
       temp = resp(i).corr;
       temp = temp(temp<180);
       EEG.event(i).estim  = matriz(temp,1);
       EEG.event(i).resp   = matriz(temp,2);
       EEG.event(i).cond   = resp(i).cond;
       EEG.event(i).matriz = matriz;
     end
else
    for i=1:length(resp)
        EEG.event(i).estim  = matriz(resp(i).corr,1);
        EEG.event(i).resp   = matriz(resp(i).corr,2);
        EEG.event(i).cond   = resp(i).cond;
        EEG.event(i).matriz = matriz;
    end
end
% EEG.event.matriz = matriz;
% guarda localización de canales
EEG=pop_chanedit(EEG, 'load',{ localizacion 'filetype' 'autodetect'});
EEG = eeg_checkset( EEG );
% Guarda los datos como .set
EEG = pop_saveset( EEG, 'filename',[nombre,'.set'],'filepath',fileOut);
EEG = eeg_checkset( EEG );
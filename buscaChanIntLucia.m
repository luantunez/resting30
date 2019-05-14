function  badchannels = buscaChanIntLucia(sujname)

if strcmp(sujname,'s1')
        badchannels = [3];
elseif strcmp(sujname,'s2')
        badchannels = [5,13,30];
elseif strcmp(sujname,'s3')
        badchannels = [5,13,15];
elseif strcmp(sujname,'s4')
        badchannels = [13,15];
elseif strcmp(sujname,'s5')
        badchannels = [14];
elseif strcmp(sujname,'s6')
        badchannels = [15];
elseif strcmp(sujname,'s7')
        badchannels = [7,23];
elseif strcmp(sujname,'s8')
        badchannels = [];%duda
elseif strcmp(sujname,'s9')
        badchannels = [15,1,30];
elseif strcmp(sujname,'s10')
        badchannels = [7,13,15];
elseif strcmp(sujname,'s11')
        badchannels = [25];
elseif strcmp(sujname,'s12')
        badchannels = [25];
elseif strcmp(sujname,'s13')
        badchannels = [29];
elseif strcmp(sujname,'s14')
        badchannels = [];%duda
elseif strcmp(sujname,'s15')
        badchannels = [13,21];
elseif strcmp(sujname,'s16')
        badchannels = [9,6,16];
elseif strcmp(sujname,'s17')
        badchannels = [14,15];
elseif strcmp(sujname,'s18')
        badchannels = [];%X
elseif strcmp(sujname,'s19')
        badchannels = [13];
elseif strcmp(sujname,'s20')
        badchannels = [5,11,16,19,26];
elseif strcmp(sujname,'s21')
        badchannels = [];
elseif strcmp(sujname,'s22')
        badchannels = [];
elseif strcmp(sujname,'s23')
        badchannels = [3,23]; 
elseif strcmp(sujname,'s24')
        badchannels = [13,15];
elseif strcmp(sujname,'s25')
        badchannels = [6,7,29];
elseif strcmp(sujname,'s26')%duda
        badchannels = [15]; 
elseif strcmp(sujname,'s27')
        badchannels = [6,7];
elseif strcmp(sujname,'s28')%X
        badchannels = [];
elseif strcmp(sujname,'s29')
        badchannels = [9,22];
elseif strcmp(sujname,'s30')%X
        badchannels = [];
elseif strcmp(sujname,'s31')
        badchannels = [18];
elseif strcmp(sujname,'s32')
        badchannels = [5];
elseif strcmp(sujname,'s33')
        badchannels = [13];
elseif strcmp(sujname,'s34') 
        badchannels = [6,20];
    end
   


end
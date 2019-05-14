function [CumRho, CumPhi,  CumMatdif, EjeX, EjeF, ParElec] = DataAnalyzer2(MatSig, Fs, Frange, Trange, WinSig, Step)
%DataAnalyzer
%   Detailed explanation goes here

 Ntrials = size(MatSig,3)

 %Ntrials = 6 
 
 % Calculando fase trial final.
 [Rho, Phi0, EjeX, EjeF] = espectrograma2( MatSig(:,:,Ntrials), Fs, Frange, Trange, WinSig, Step);
 
 for T = 1:Ntrials
     T
     Mt = MatSig(:,:,T);
     
     [Rho, Phi, EjeX, EjeF] = espectrograma2( Mt, Fs, Frange, Trange, WinSig, Step);
     [Matdif, ParElec] = difphaser3(Phi, 1);
     
    % [Matdif, MatDifShuffle, ParElec] = difphaser3NSH(Phi, Phi0, 1);
     
     if T==1
         CumRho = Rho;
         CumPhi = Phi;
         Phi0 = Phi;
         CumMatdif = Matdif;
       %  CumShuffle = MatDifShuffle;
     else
         CumRho = CumRho + Rho;
         CumPhi = CumPhi + Phi;
         CumMatdif = CumMatdif + Matdif;
      %   CumShuffle = MatDifShuffle + CumShuffle;
         Phi0 = Phi;
     end
     
 end
 
         CumRho = CumRho/Ntrials;
         CumPhi = CumPhi/Ntrials;
         CumMatdif = CumMatdif/Ntrials;
      %   CumShuffle = CumShuffle/Ntrials;


end


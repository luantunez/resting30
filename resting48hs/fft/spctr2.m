function    [Samp, Sph, EjeF] = spctr2(s, SampFreq, FreqRange)
%
%  [Samp, Sph, EjeF] = spctr2(s, SampFreq, FreqRange);
% spctr Computes the spectral amplitude and phase
% of a signal or matrix of signals 's' based on fft transform.
% if 's' is a 2D or 3D matrix, fourier proceed on each column independently.
% Use 'permute' if transposition of a ND matrix is necesary
%
% NOTE!! Asumes that there are more points than independent signals!!
%
% Input variables
%
%     s        : signal or matrix of signals. Admits 4D arrays ASUMES THAT
%                EACH COLUMN IS AN INDEPENDENT SIGNAL.
%
%    SampFreq  : Sampling frequency in Hz.
%
%    FreqRange : range of frequencies to be analized eg [10:.1:50]This
%                means 10 to 50 Hz in .1 Hz step.
%
% Output Variables 
%
%     Samp    : Spectral amplitude of signal 's'
%
%     Sph     : Spectral phase of signal 's' as a phasor (unitary complex
%               vector)
%
%     EjeF    : axis of analized frequencies. Each element of this vector contains 
%               the central frequency corresponding to each analized bin.
%

% Size of the signal matrix
Ndims = size(s);
%   size(s)
%    figure
%    plot(s)
%    kunde =yayo
% Frequency resolution desired in Hz 
FreqRes = FreqRange(2)-FreqRange(1); 

% number of points required to obtain a frequency resolution
% as requested in 'FreqRes' given that the sampling frequency is 'SampFreq'
N = SampFreq/FreqRes;

% new N is the next power of 2 of the original N
N = 2^nextpow2(N);

if N > Ndims(1)
  %  N
  %  warning('Not enough signal points for the demanded frequency resolution Increase the data points or reduce the frequency resolution', 'r')
end
% range of frequencies that are computed by the fft (in Hz)                     
  Frequencies = (0:N/2)*(SampFreq/N);
% range of indexes valid for the fft
  Indexes = [1:N/2+1];
 
  
% N points fourier transform of signal s
 S = fft(s,N);

% % range of frequencies that are computed by the fft (in Hz) 
% Frequencies = (0:Ndims(1)/2)*(SampFreq/Ndims(1));
% % range of indexes valid for the fft
% Indexes = [1:Ndims(1)/2+1];
% % N points fourier transform of signal s
% S = fft(s);

% phase information given as angles
Sph=angle(S);
% transforming angles into a phasor (unitary complex vector)
Sph=cos(Sph)+sqrt(-1)*sin(Sph);
  
% amplitudes
Samp=abs(S);


                          
% range of indexes corresponding to the frequency range specified by FRANGE
IRANGE = unique(interp1(Frequencies,Indexes,FreqRange,'nearest'));
    
% frequency axis as specified by FRANGE
EjeF = Frequencies(IRANGE);



       if Ndims(1) == 1
         Samp = Samp(IRANGE);
         Sph  = Sph (IRANGE);
       elseif length(Ndims) == 2
           Samp = Samp(IRANGE,:);
           Sph  = Sph (IRANGE,:);
       elseif length(Ndims) == 3
           Samp = Samp(IRANGE,:,:);
           Sph  = Sph (IRANGE,:,:);
       else
           Samp = Samp(IRANGE,:,:,:);
           Sph  = Sph (IRANGE,:,:,:);
       end
       
       





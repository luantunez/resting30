function [Mz] = Cnorm(M, n)

% Cnorm(M,n) uses the first 'n' rows of matrix 'M' to compute 
% the C normalization of 'M', such that:
%
%    Let Mn be equal to M(1:n,:).   (The first 'n' rows of 'M') 
%
%    then 
%         Mz = (M - mean(Mn))
%
%  Note that normalization procceds on EACH COLUMN INDEPENDENTLY
%  and that 'M' can be a column vector, BUT NOT a row vector
%  see also Znorm
%
%  E.Rodriguez  2003

[r,c] = size(M);

Mz = (M - repmat(mean(M(1:n,:)), r, 1));

% replaces NaN by zeros
[I,J] = find(isnan(Mz));
Mz(I,J)=0;
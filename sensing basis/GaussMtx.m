function [ Phi ] = GaussMtx( M, N )
%GAUSSMTX GENERATES GAUSS MATRIX
%   M: row
%   N: line
%   Phi: Gauss matrix

Phi = sqrt(1/ N) * randn(M, N);

end


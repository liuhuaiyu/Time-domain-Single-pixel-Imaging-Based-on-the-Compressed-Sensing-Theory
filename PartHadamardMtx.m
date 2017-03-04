function [ Phi ] = PartHadamardMtx( M, N )
%PARTHADAMARDMTX GENERATES PART HADAMARD MATRIX
%   M: row
%   N: line, must be power of 2
%   Phi: part hadamard matrix

Phi = hadamard(N) / sqrt(N);
index = randperm(N);
Phi = Phi(index(1: M), :);

end


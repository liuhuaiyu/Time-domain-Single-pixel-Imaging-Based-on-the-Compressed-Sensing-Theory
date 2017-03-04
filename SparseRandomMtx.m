function [ Phi ] = SparseRandomMtx( M, N, d )
%SPARSERANDOMTX GENERATES SPARSERANDOMMTX
%   M: row
%   N: line
%   d: d<M, number of 1 in every column, usually choose 4, 8, 10 or 16

Phi = zeros(M, N);  
for ii = 1: N  
    ColIdx = randperm(M);  
    Phi(ColIdx(1: d), ii) = 1;  
end 

end


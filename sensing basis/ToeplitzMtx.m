function [ Phi ] = ToeplitzMtx( M, N, Option )
%TOEPLITZMTX GENERATES TOEPLITZ MATRIX
%   M: row
%   N: line
%   Option: choose the kind of random vector u
%       Option=1: Gauss
%       Option=2: Bernoulli

if Option == 1  
    u = randn(1,2*N-1); 
elseif Option == 2
    u = randi([0,1],1,2*N-1);  
    u(u==0) = -1;  
else
    error('Use [ Phi ] = ToeplitzMtx( M, N, 1 ) or [ Phi ]= ToeplitzMtx( M, N, 2 ) instead');
end

Phi_t = toeplitz(u(N: end), fliplr(u(1: N)));
Phi = Phi_t(1: M, :);  
    
end


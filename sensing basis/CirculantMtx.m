function [ Phi ] = CirculantMtx( M, N, Option )
%CIRCULANTMTX GENERATES CIRCULANT MATRIX
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
    error('Use [ Phi ] = CirculantMtx( M, N, 1 ) or [ Phi ]= CirculantMtx( M, N, 2 ) instead');
end

Phi_t = toeplitz(circshift(u,[1,1]),fliplr(u(1:N)));  
Phi = Phi_t(1:M,:);

end


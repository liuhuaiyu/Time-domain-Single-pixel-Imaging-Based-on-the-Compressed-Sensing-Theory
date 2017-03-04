function [ Phi ] = BernoulliMtx( M, N, Option )
%BERNOULLIMTX GENERATES BERNOULLI MATRIX
%   M: row
%   N: line
%   Option: choose the kind of BERNOULLI MATRIX
%       Option = 1: 1/sqrt(N)(p=1/2) or -1/sqrt(N)(p=1/2)
%       Option = 2: sqrt(3/N)(p=1/6) or 0(p=2/3) or -sqrt(3/N)(p=1/6)

if Option == 1
    Phi = randi([0,1],M,N); 
    Phi(Phi==0) = -1;  
    Phi = Phi/sqrt(N);
elseif Option == 2
    Phi = randi([-1,4],M,N); 
    Phi(Phi==2) = 0;  
    Phi(Phi==3) = 0;  
    Phi(Phi==4) = 0;
    Phi = Phi*sqrt(3/N);  
else
    error('Use [ Phi ] = BernoulliMtx( M, N, 1 ) or [ Phi ]= BernoulliMtx( M, N, 2 ) instead');
end

end


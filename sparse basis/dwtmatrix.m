function [ ww ] = dwtmatrix( N,wtype,wlev )  
%DWTMTX GENERATES DISCRETE WAVELET TRANSFORM MATRIX  
%   N is the dimension of ww  
%   wtype is the wavelet type  
%   wlev is the number of decomposition level   
%   wtype can be:
%       'db1' or 'haar', 'db2', ... ,'db10', ... , 'db45'  
%       'coif1', ... , 'coif5'  
%       'sym2', ... , 'sym8', ... ,'sym45'  
%       'bior1.1', 'bior1.3', 'bior1.5'  
%       'bior2.2', 'bior2.4', 'bior2.6', 'bior2.8'  
%       'bior3.1', 'bior3.3', 'bior3.5', 'bior3.7'  
%       'bior3.9', 'bior4.4', 'bior5.5', 'bior6.8'  
%       'rbio1.1', 'rbio1.3', 'rbio1.5'  
%       'rbio2.2', 'rbio2.4', 'rbio2.6', 'rbio2.8'  
%       'rbio3.1', 'rbio3.3', 'rbio3.5', 'rbio3.7'  
%       'rbio3.9', 'rbio4.4', 'rbio5.5', 'rbio6.8'
%NOTE: 
%   use wlev_max = wmaxlev(N,wtype) to check whether your input wlev is allowed
%   The extension mode must be Periodization('per') 

[h,g]= wfilters(wtype,'d');         %Decomposition low&high pass filter  
L=length(h);                        %Filter length  
h_1 = fliplr(h);                    %Flip matrix left to right  
g_1 = fliplr(g);  
loop_max = log2(N);  
loop_min = double(int8(log2(L)))+1;  
if wlev>loop_max-loop_min+1  
    fprintf('\nWaring: wlev is too big\n');  
    fprintf('The biggest wlev is %d\n',loop_max-loop_min+1);  
    wlev = loop_max-loop_min+1;  
end  
ww=1;  
for loop = loop_max-wlev+1:loop_max  
    Nii = 2^loop;  
    p1_0 = [h_1 zeros(1,Nii-L)];  
    p2_0 = [g_1 zeros(1,Nii-L)];  
    p1 = zeros(Nii/2,Nii);  
    p2 = zeros(Nii/2,Nii);  
    for ii=1:Nii/2  
        p1(ii,:)=circshift(p1_0',2*(ii-1)+1-(L-1)+L/2-1)';  
        p2(ii,:)=circshift(p2_0',2*(ii-1)+1-(L-1)+L/2-1)';  
    end  
    w1=[p1;p2];  
    mm=2^loop_max-length(w1);  
    w=[w1,zeros(length(w1),mm);zeros(mm,length(w1)),eye(mm,mm)];  
    ww=ww*w;  
    clear p1;clear p2;  
end  
  
end


function [corrAns, char, d] = nback_bp(color,nback,seq)
load('barpie_data.mat');
R = dt(:,color)';
n =nback;
if nargin<3
    seq = [2 3 2 5 6 8 6 8 4 8 10 2 11 2 11 3 15 6 15 8];
end

Rs = R(seq);
%  appending zeros to maintain robustness
% disp(['n-backtask:' ' ' 'n=' num2str(n)])
z = zeros(1,length(Rs)+n+n);   % number to to be replaced by n;
z(1,(n+1):end-n) = Rs;         % number 3 is n+1
% performing the n-back algorithm
d = zeros(size(Rs));

for i = 1:length(z)-n
    if z(i+n) == z(i)
        corrAns(i) = 3;
        char(i) = 'E';
    elseif z(i+n) < z(i)
        corrAns(i) = 2;
        char(i) = 'N';
        
    else
        corrAns(i) = 1;
        char(i) = 'Y';
    end
end
end
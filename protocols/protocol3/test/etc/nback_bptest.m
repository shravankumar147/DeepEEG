function [corrAns, char] = nback_bptest(c,nb,R,seq)
%% tested on
% nb = 1; c = 3; s = 1:10;R = [1 2 1 5 4 9 3 4 4 7]
% [corrAns, char] = nback_bptest(c,nb,R,s) 
% [corrAns, char] = nback_bptest(c,nb,R,s)

load('barpie_data.mat');
if nargin<3
R = dt(:,c)';
end
n =nb;
if nargin<4
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
corrAns(end-(n-1):end) = [];
char(end-(n-1):end) = [];
end
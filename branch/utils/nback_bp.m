function [corrAns, char] = nback_bp(c, nb, seq, type, th)
load('barpie_data.mat');
R = dt(:,c)';
n =nb;
if nargin<3
    seq = [2 3 2 5 6 8 6 8 4 8 10 2 11 2 11 3 15 6 15 8];
end

if nargin<5
    th = 50;
end

Rs = R(seq);
%  appending zeros to maintain robustness
% disp(['n-backtask:' ' ' 'n=' num2str(n)])
z = zeros(1,length(Rs)+n+n);   % number to to be replaced by n;
z(1,(n+1):end-n) = Rs;         % number 3 is n+1
% performing the n-back algorithm
d = zeros(size(Rs));
if n==0 && strcmp(type,'bar')
    p = Rs>th;
    for l = 1:length(p)
        if p(l)==1
            corrAns(l) = 1;
            char(l) = 'Y';
        else
            corrAns(l) = 2;
            char(l) = 'N';
        end
    end
elseif n==0 && strcmp(type,'pie')
    p = max(dt');
    p = p(seq);
    for l = 1:length(p)
        if p(l) == Rs(l)
            corrAns(l) = 1;
            char(l) = 'Y';
        else
            corrAns(l) = 2;
            char(l) = 'N';
        end
    end
    
    
else    
    for i = 1:length(z)-n
        %         if z(i+n) == z(i)
        %             corrAns(i) = 3;
        %             char(i) = 'E';
        %         elseif z(i+n) < z(i)
        if z(i+n) < z(i)
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
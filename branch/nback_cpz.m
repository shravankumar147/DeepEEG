function [corrAns, char] = nback_cpz(n,s,ch)
if nargin<3
    ch = 14 ;% char "s"
end
% seq=[2 3 2 5 6 8 6 8 4 8];
% seq = [1 1 1 1 1 1 1 1 1 1 1 1];
%
% outputs ::
% corrAns : keys to be pressed on key board
% char : m or n
%
%  appending zeros to maintain robustness
% disp(['n-backtask:' ' ' 'n=' num2str(n)])
z = zeros(1,size(s,2)+n+n);   % number to to be replaced by n;
z(1,(n+1):end-n) = s;         % number 3 is n+1
% performing the n-back algorithm
d = zeros(size(s));
for i = 1:length(z)-n
    d(i) = z(i+n) - z(i);
end
% evaluating which character to be pressed on keyboard
corrAns = zeros(size(s)); char = zeros(size(s));
if n==0
    p = (s==ch);
    for l = 1:length(p)
        if p(l)==1
            corrAns(l) = 1;
            char(l) = 'Y';
        else
            corrAns(l) = 0;
            char(l) = 'N';
        end
    end
end


corrAns(end-(n-1):end) = [];
char(end-(n-1):end) = [];

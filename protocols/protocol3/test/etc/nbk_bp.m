load('barpie_data.mat');
R = dt(:,color)';
n =nback;

    seq = [2 3 2 5 6 8 6 8 4 8 10 2 11 2 11 3 15 6 15 8];


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
% % evaluating which character to be pressed on keyboard
% corrAns = zeros(size(Rs)); char = zeros(size(Rs));
% for i = 1:length(d)
%     if d(i)<0
%         corrAns(i) = 2;
%         char(i) = 'N';
%     elseif d(i)>0
%         corrAns(i) = 1;
%         char(i) = 'Y';
%     else
%         corrAns(i) = 3;
%         char(i) = 'E';
%     end
% end
function [Ir, K2P] = imshuffle(n)
%% English Characters for n-back experiments
% Shravankumar, CVIT, IITH
% Reading the image paths
imds = imageDatastore('nback\stimuli\','FileExtensions', {'.jpg', '.png', '.tif'});
I = imds.Files;
% counting the number of images in the folder
l = length(imds.Files);
seq = [2 3 2 5 6 8 6 8 4 8 10 2 11 2 11 3 15 6 15 8];
% seq = Shuffle(seq);
%% Keys to press by the user (1 or 77)= m, (0 or 78) = n;
[corrAns, ~] = nback(n,seq);
K2P = corrAns; % [78 78 77 78 78 77 77 78 77 78 78 78 77 77]
%% Image Dataset loading section
Ir=[];
for p = 1:length(seq)
    L = seq(p);
    Ir = [Ir;imread(I{L})];    
end

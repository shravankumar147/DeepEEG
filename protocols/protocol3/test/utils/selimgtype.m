function [I,len,size1] = selimgtype(type)
%% Select type of stimuli you want to present
% Shravankumar, CVIT, IIITH
% example
% [I,l,sz1] = selimgtype('bar')
% [I,l,sz1] = selimgtype('pie')
% [I,l,sz1] = selimgtype('char')
% [I,l,sz1] = selimgtype('pos')

s1 = 'bar';
s2 = 'pie';
s3 = 'char';
s4 = 'pos';
if strcmp(s1,type)
    disp('bar')
    %% Reading the image paths
imds = imageDatastore('input\bar\','FileExtensions', {'.jpg', '.png', '.tif'});
I = imds.Files;
I1 = imread(I{1});
size1 = size(I1,1);
% counting the number of images in the folder
len = length(imds.Files);
    
elseif strcmp(s2,type)
    disp('pie')
%% Reading the image paths
imds = imageDatastore('input\pie\','FileExtensions', {'.jpg', '.png', '.tif'});
I = imds.Files;
I1 = imread(I{1});
size1 = size(I1,1);
% counting the number of images in the folder
len = length(imds.Files);
elseif strcmp(s3,type)
    disp('char')
    %% Reading the image paths
imds = imageDatastore('input\nback\stimuli\','FileExtensions', {'.jpg', '.png', '.tif'});
I = imds.Files;
I1 = imread(I{1});
size1 = size(I1,1);
% counting the number of images in the folder
len = length(imds.Files);
elseif strcmp(s4,type)
    disp('pos')
    %% Reading the image paths
imds = imageDatastore('input\positions\','FileExtensions', {'.jpg', '.png', '.tif'});
I = imds.Files;
I1 = imread(I{1});
size1 = size(I1,1);
% counting the number of images in the folder
len = length(imds.Files);
else
    disp('try : bar,pie,char,pos')    
end

end
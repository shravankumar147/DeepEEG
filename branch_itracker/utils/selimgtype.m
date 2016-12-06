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
s5 = 'instr';

imds = imageDatastore(strcat('input\',type,'\'),'FileExtensions', {'.jpg', '.png', '.tif'});
I = imds.Files;
I1 = imread(I{1});
size1 = size(I1,1);
% counting the number of images in the folder
len = length(imds.Files);
 
end
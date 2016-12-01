function batch_imresize(type,save)
if nargin < 2
    save = 0;
end

if strcmp(type,'bar')
    imd = imageDatastore('bar\');
elseif strcmp(type,'pie')
    imd = imageDatastore('pie\');
else
    return;
end
I = imd.Files;
for i = 1:16
Ib{i} = readimage(imd,i);
I = Ib{i};
I = imresize(I,0.6);
name = type;
fname = [name num2str(1999+i) '.png'];
imshow(I)
if save
imwrite(I,fname)
fprintf('saving image: %s\n', fname)
end
end
end

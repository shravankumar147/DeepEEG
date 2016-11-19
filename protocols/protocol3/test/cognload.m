function cognload()
%% Shravankumar, CVIT, IIITH
% Date : 16-11-2016
% example
% choose one out of four types : bar, pie, char, pos
% cognload('bar')
%% UserData
% stay_quit();
[outfile, output, subid, subage, gender, group, type] = userlog();
%% Screen setup
[win,rect] = screenSetup();
KbName('UnifyKeyNames');
spaceKey = KbName('space'); escKey = KbName('ESCAPE');

%% load files here to show 
% imds = imageDatastore('input\barfigs\');
% I = imds.Files;
% l = length(imds.Files);
%% Instruction Images
% Reading the image paths
% inst = imageDatastore('input\barfigs\','FileExtensions', {'.jpg', '.png', '.tif'});
% I = inst.Files;
% I1 = imread(I{1});
% sz1 = size(I1,1);
% % counting the number of images in the folder
% le = length(inst.Files);
%%###################################%%
%% choose one out of four types : bar, pie, char, pos
[I,le,sz1] = selimgtype(type);
%%###################################%%
Ir=[];
for q = 1:le
    Ir = [Ir;imread(I{q})];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
% stay_quit() 
%% Main Loop
fixCross(win,rect);
for loop = 1:le
    %% Play the slide    
    showimg(Ir,win,loop,sz1)
    WaitSecs(3)
    [~,x,y,~,ar] = getResponse(win,rect,'How much proportion is the highlighted bar(red) \ncompared to the previous highlighted bar(red)');
    [rate] = rater(x,ar);
    fprintf(outfile,'%s\t %s\t %s\t %s\t %s\t %d\t %d\t %d\t\n', subid, subage, gender, group, type ,x, y, rate);
end % end of loop
sca;
fclose(outfile);
end %end of cognload

%% Functions

%% read imagae
function showimg(img,win,loop,sz1)
        Screen('FillRect', win , [0 0 0]);
        % present the stimulus
        t = loop-1;
        Screen('DrawTexture', win,Screen('MakeTexture', win, img(sz1*(t)+1:((t+1)*sz1),:,:)));
        Screen('Flip', win); % must flip for the stimulus to show up on the mainwin
        %ShowCursor('hand'); 
end

%% Input to user & Get Response
function [clicks,x,y,whichButton,allRects] = getResponse(win,rect,question)
[screenXpixels, screenYpixels] = Screen('WindowSize', win);
[xCenter, yCenter] = RectCenter(rect);
baseRect = [0 0 100 100];
% Screen X positions of our three rectangles
squareXpos = [screenXpixels * 0.35 screenXpixels * 0.45 screenXpixels * 0.55 screenXpixels * 0.65 screenXpixels * 0.75];
numSqaures = length(squareXpos);
% Make our rectangle coordinates
allRects = nan(4, 3);
for i = 1:numSqaures
    allRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(i), yCenter);
end 

% Draw the rect to the screen
Screen('FillRect', win, [255 255 255], allRects);


Screen('TextSize', win, 50);
DrawFormattedText(win,'1',screenXpixels * 0.35,'center',[0 0 0]);
DrawFormattedText(win,'2',screenXpixels * 0.45,'center',[0 0 0]);
DrawFormattedText(win,'3',screenXpixels * 0.55,'center',[0 0 0]);
DrawFormattedText(win,'4',screenXpixels * 0.65,'center',[0 0 0]);
DrawFormattedText(win,'5',screenXpixels * 0.75,'center',[0 0 0]);

DrawFormattedText(win,question,'center',screenYpixels * 0.25,[255 255 255]);
DrawFormattedText(win,'Click on any rectangle','center',screenYpixels * 0.75,[255 255 255]);
Screen('Flip', win);
ShowCursor('hand');
[clicks,x,y,whichButton] = GetClicks(win,1);

end
%% Rater function::
function [rate] = rater(x,ar)

if (x>ar(1,1) && x < ar(3,1))
    rate=1;
elseif (x>ar(1,2) && x < ar(3,2))
    rate=2;
elseif (x>ar(1,3) && x < ar(3,3))
    rate=3;
elseif (x>ar(1,4) && x < ar(3,4))
    rate=4;
else
    rate=5;
end
end
 
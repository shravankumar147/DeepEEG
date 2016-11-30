%% Input to user & Get Response

function [clicks,x,y,whichButton,allRects,rt] = getResponse_cp(win,rect)
% Get Response for Character and Position Tasks
[screenXpixels, screenYpixels] = Screen('WindowSize', win);
[~, yCenter] = RectCenter(rect);
baseRect = [0 0 75 75];
% Screen X positions of our three rectangles
squareXpos = [screenXpixels * 0.45 screenXpixels * 0.55 ];
numSqaures = length(squareXpos);
% Make our rectangle coordinates
allRects = nan(4, 3);
for i = 1:numSqaures
    allRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(i), yCenter);
end 


%%
% Draw the rect to the screen
Screen('FillRect', win, [255 255 255], allRects);
Screen('TextSize', win, 25);

DrawFormattedText(win,'Yes  ',screenXpixels * 0.432,'center',[0 0 0]);
DrawFormattedText(win,'No   ',screenXpixels * 0.535,'center',[0 0 0]);

% DrawFormattedText(win,question,'center',screenYpixels * 0.25,[255 255 255]);
% DrawFormattedText(win,'Click on any rectangle','center',screenYpixels * 0.75,[255 255 255]);

Screen('Flip', win);
ShowCursor('hand');
timeStart = GetSecs;
[clicks,x,y,whichButton] = GetClicks(win,0);
rt = 1000.*(GetSecs-timeStart); % reaction time is added
end
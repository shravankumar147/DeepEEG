%% Input to user & Get Response
function [clicks,x,y,whichButton] = getResponse(win, image)
%% 
line1 = 'Please Rate';
line2 = '\n 1 One  ';
line3 = '\n 2 Two  ';
line4 = '\n 3 Three';
line5 = '\n 4 Four ';
line6 = '\n 5 Five ';
line7 = '\n 6 Six  ';

Screen('TextSize', win, 50);
DrawFormattedText(win,[line1 line2 line3 line4 line5 line6 line7]);
Screen('Flip', win);
%%
Screen('FillRect', win);
% present the Response Chart
Screen('DrawTexture', win,Screen('MakeTexture', win, image));
Screen('Flip', win); % must flip for the stimulus to show up on the mainwin
ShowCursor('hand');
[clicks,x,y,whichButton] = GetClicks(win,1);
end
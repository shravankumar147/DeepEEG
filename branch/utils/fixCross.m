%% fixation cross
% Drawing the fixation cross
function fixCross(win,rect)
[X,Y] = RectCenter(rect);
FixCross = [X-1,Y-40,X+1,Y+40;X-40,Y-1,X+40,Y+1];
Screen('FillRect', win, [0,0,0]);
Screen('FillRect', win, [255,255,255], FixCross');
Screen('Flip', win);
HideCursor(win);
WaitSecs(1);
end
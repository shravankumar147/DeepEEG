%% read imagae
function showimg(img,win,loop,sz1,Q,idx)
Screen('FillRect', win , [0 0 0]);
% present the stimulus
t = loop-1;

Screen('DrawTexture', win,Screen('MakeTexture', win, img(sz1*(t)+1:((t+1)*sz1),:,:)));
if loop > idx
    Screen('TextSize', win, 35); %
    Screen('TextFont', win,'Times'); %
    DrawFormattedText(win, Q, 80, 720, [255 255 255]);
else
    Screen('DrawTexture', win,Screen('MakeTexture', win, img(sz1*(t)+1:((t+1)*sz1),:,:)));
end

Screen('Flip', win); % must flip for the stimulus to show up on the mainwin
%ShowCursor('hand');
end
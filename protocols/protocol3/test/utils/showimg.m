%% read imagae
function showimg(img,win,loop,sz1)
Screen('FillRect', win , [0 0 0]);
% present the stimulus
t = loop-1;
Screen('DrawTexture', win,Screen('MakeTexture', win, img(sz1*(t)+1:((t+1)*sz1),:,:)));
Screen('Flip', win); % must flip for the stimulus to show up on the mainwin
%ShowCursor('hand');
end
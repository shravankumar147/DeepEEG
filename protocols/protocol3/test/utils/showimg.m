%% read imagae
function showimg(img, win, loop, sz1, type, Q, idx, rect)
Screen('FillRect', win , [0 0 0]);
% present the stimulus
t = loop-1;
%%
Screen('DrawTexture', win,Screen('MakeTexture', win, img(sz1*(t)+1:((t+1)*sz1),:,:)));
%%
Screen('TextSize', win, 35); %
Screen('TextFont', win,'Times'); %
%     DrawFormattedText(win, Q, rect(3)*0.0586, rect(4)*(1-0.0576), [255 255 255]);
DrawFormattedText(win, Q, 'center', rect(4)*(1-0.0576), [255 255 255]);
%%
Screen('Flip', win); % must flip for the stimulus to show up on the mainwin
if strcmp(type,'bar') || strcmp(type,'pie')
    WaitSecs(4)     %adjust display duration for bars and pies
else
    WaitSecs(2)     %adjust display duration for spatial and chars
end
Screen('FillRect', win , [0 0 0]);
Screen('Flip', win);
% HideCursor('hand');
end

% if loop > idx
%     Screen('TextSize', win, 35); %
%     Screen('TextFont', win,'Times'); %
% %     DrawFormattedText(win, Q, rect(3)*0.0586, rect(4)*(1-0.0576), [255 255 255]);
% DrawFormattedText(win, Q, 'center', rect(4)*(1-0.0576), [255 255 255]);
% 
% else
%     Screen('DrawTexture', win,Screen('MakeTexture', win, img(sz1*(t)+1:((t+1)*sz1),:,:)));
% end
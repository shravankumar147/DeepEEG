%% read imagae
function showimg(img, win, loop, sz1, type, Q, idx, rect)
Screen('FillRect', win , [0 0 0]);
% present the stimulus
t = loop-1;
%%
Screen('DrawTexture', win,Screen('MakeTexture', win, img(sz1*(t)+1:((t+1)*sz1),:,:)));
%%
Screen('TextSize', win, 30); %
Screen('TextFont', win, 'Consolas');
%     DrawFormattedText(win, Q, rect(3)*0.0586, rect(4)*(1-0.0576), [255 255 255]);


color=[[255 255 255];[0 255 0]];
for i=1:size(Q,1)
    DrawFormattedText(win, Q(i,:), 'center', rect(4)*(1-0.0576),color(i,:));
end

%%
Screen('Flip', win); % must flip for the stimulus to show up on the mainwin
if strcmp(type,'bar') || strcmp(type,'pie')
    WaitSecs(1)     %adjust display duration for bars and pies
else
    WaitSecs(1)     %adjust display duration for spatial and chars
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
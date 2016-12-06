function instruction_show(win, inst, gt)
if nargin < 2
    inst = 'Observe and memorize the variations\n\n click to continue';
end
if nargin < 3
    gt = 1;
end
    Screen('TextSize', win, 30);
    Screen('TextFont', win, 'Consolas');
    color=[[255 255 255];[0 255 0]];
    for i=1:size(inst,1)
     DrawFormattedText(win, inst(i,:), 'center', 'center',color(i,:));
    end
  
    if gt ~= 0 
        [screenXpixels, screenYpixels] = Screen('WindowSize', win);
        DrawFormattedText(win, 'Please click to continue.', 'center', screenYpixels * 0.75, [255 255 255]);
    end
    Screen('Flip', win);
    ShowCursor('hand');
    if gt == 1
        GetClicks(win,0);
    end
    
    
end

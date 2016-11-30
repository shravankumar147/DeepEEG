function instruction_show(win, inst, gt)
if nargin < 2
    inst = 'Observe and memorize the variations\n\n click to continue';
end
if nargin < 3
    gt = 1;
end
    Screen('TextSize', win, 35);
    Screen('TextFont', win, 'Times');
    DrawFormattedText(win, inst, 'center', 'center', [255 255 255]);
    Screen('Flip', win);
    ShowCursor('hand');
    if gt == 1
        GetClicks(win,0)
    end
end

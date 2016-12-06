function clr_inst(win, inst)
if nargin < 2
    inst = 'Observe the graph and memorize the variations';
end
    Screen('TextSize', win, 30);
    Screen('TextFont', win, 'Courier');
    DrawFormattedText(win, inst, 'center', 'center', [255 255 255]);
    Screen('Flip', win);
    end

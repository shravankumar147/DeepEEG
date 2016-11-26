function instruct_user(win)

% Draw text in the middle of the screen in Courier in white
Screen('TextSize', win, 80);
Screen('TextFont', win, 'Courier');
DrawFormattedText(win, 'Hello World', 'center', 'center', [255 255 255]);
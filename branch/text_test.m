% Clear the workspace and the screen
close all;
clearvars;
sca

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers
Screen('Preference', 'SkipSyncTests', 1);
screens = Screen('Screens');

% Select the external screen if it is present, else revert to the native
% screen
screenNumber = max(screens);

% Define black, white and grey
black = BlackIndex(screenNumber);
white = WhiteIndex(screenNumber);
grey = white / 2;

% Open an on screen window and color it grey
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);

% Set the blend funciton for the screen
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% Get the size of the on screen window in pixels
% For help see: Screen WindowSize?
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window in pixels
% For help see: help RectCenter
[xCenter, yCenter] = RectCenter(windowRect);


line1 = 'Hello World';

idx=2;
q  = ['A sequence of characters in will be displayed in random order.\n\n Click     if you have seen the                slides ago'];
qh = ['                                                              \n\n       YES                      same character           '];          

Q=[q;qh];

line3 = 'This is the third line a bigger line,\nlong line, very long line';


% Draw text in the upper portion of the screen with the default font in red

% Draw text in the middle of the screen in Courier in white
Screen('TextSize', window, 30);
Screen('TextFont', window, 'Courier');
c=[[1 1 0];[0 1 0]]
for i=1:size(Q,1)
DrawFormattedText(window, Q(i,:), 'center', screenYpixels * 0.5,c(i,:));
end
% Screen('TextSize', window, 80);
% Screen('TextFont', window, 'Courier');
% DrawFormattedText(window, line23, 'center', 'center', white);
% 


% Flip to the screen
Screen('Flip', window);

% Now we have drawn to the screen we wait for a keyboard button press (any
% key) to terminate the demo
KbStrokeWait;

% Clear the screen
sca;

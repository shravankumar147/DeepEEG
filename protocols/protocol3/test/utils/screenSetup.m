%% Screen setup
function [win,rect] = screenSetup(screenid)
%% 
% Select screen for display of movie:
if nargin<1
screenid = max(Screen('Screens'));
end
%% Screen Parameters
Screen('Preference', 'SkipSyncTests', 1);
% Open 'windowrect' sized window on screen, with black [0] background color:
[win,rect] = Screen('OpenWindow', screenid, 0);
% Set the blend funciton for the screen
% Screen('BlendFunction', win, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
end

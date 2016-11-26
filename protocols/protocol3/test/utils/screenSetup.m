%% Screen setup
function [win,rect] = screenSetup()
%% 
% Select screen for display of movie:
screenid = max(Screen('Screens'));
%% Screen Parameters
Screen('Preference', 'SkipSyncTests', 1);
% Open 'windowrect' sized window on screen, with black [0] background color:
[win,rect] = Screen('OpenWindow', screenid, 0);
% Set the blend funciton for the screen
% Screen('BlendFunction', win, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
end

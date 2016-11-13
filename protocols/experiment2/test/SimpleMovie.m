function[x_loc, y_loc] = SimpleMovie(~, ~)
%% Shravankumar, CVIT, IIITH
% Date : 12-11-2016
% To show videos and take responses on given scale

%% 
% Select screen for display of movie:
screenid = max(Screen('Screens'));
%% Screen Parameters
Screen('Preference', 'SkipSyncTests', 1);
% Open 'windowrect' sized window on screen, with black [0] background color:
[win,rect] = Screen('OpenWindow', screenid, 0);
% Set the blend funciton for the screen
% Screen('BlendFunction', win, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
%% Specif the files to paly
%% database loading into imds variable
imds = datastore('testVideos\','FileExtensions', '.mp4','Type', 'image');
I = imds.Files;
l = length(imds.Files);
R = imread('rating.png');
%% creating a file to write log
fid = fopen('log\response.xls','a+');
fprintf(fid,'%s\t %s\t %s\t %s\t\n', 'fname', 'x', 'y', 'rating');
%%
% Drawing the fixation cross
fixCross(win,rect)
%% Main Loop
for loop = 1:2
    moviename= [I{randi([1,l])}];
    %% Play the movie
    playmovie(moviename,win);
    fixCross(win,rect);
    [~,x,y,~] = getResponse(win, R);
    [rate] = rater(x);
    x_loc = x; 
    y_loc = y;
    fprintf(fid,'%s\t %d\t %d\t %d\t\n', moviename ,x, y, rate);
    WaitSecs(2)    
end % end of loop
sca;
fclose(fid);
end % end of the function


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Play the movie:: function
function playmovie(moviename,win)
% Check if Psychtoolbox is properly installed:
AssertOpenGL;
% Wait until user releases keys on keyboard:
KbReleaseWait;

try
    
    % Open movie file:
    movie = Screen('OpenMovie', win, moviename);
    
    % Start playback engine:
    Screen('PlayMovie', movie, 1);
    
    % Playback loop: Runs until end of movie or keypress:
    while ~KbCheck
        % Wait for next movie frame, retrieve texture handle to it
        tex = Screen('GetMovieImage', win, movie);
        
        % Valid texture returned? A negative value means end of movie reached:
        if tex<=0
            % We're done, break out of loop:
            break;
        end
        
        % Draw the new texture immediately to screen:
        Screen('DrawTexture', win, tex);
        
        % Update display:
        Screen('Flip', win);
        
        % Release texture:
        Screen('Close', tex);
    end
    
    % Stop playback:
    Screen('PlayMovie', movie, 0);
    
    % Close movie:
    Screen('CloseMovie', movie);
    
    % Close Screen, we're done:
    %             sca;
    
catch %#ok<CTCH>
    sca;
    psychrethrow(psychlasterror);
end

return

end
%% fixation cross
% Drawing the fixation cross
function fixCross(win,rect)
[X,Y] = RectCenter(rect);
FixCross = [X-1,Y-40,X+1,Y+40;X-40,Y-1,X+40,Y+1];
Screen('FillRect', win, [192,192,192])
Screen('FillRect', win, [255,255,255], FixCross');
Screen('Flip', win);
WaitSecs(1)
end
%% Input to user & Get Response
function [clicks,x,y,whichButton] = getResponse(win, image)
%% 
line1 = 'Please Rate';
line2 = '\n 1 One  ';
line3 = '\n 2 Two  ';
line4 = '\n 3 Three';
line5 = '\n 4 Four ';
line6 = '\n 5 Five ';
line7 = '\n 6 Six  ';

Screen('TextSize', win, 50);
DrawFormattedText(win,[line1 line2 line3 line4 line5 line6 line7]);
Screen('Flip', win);
%%
Screen('FillRect', win);
% present the Response Chart
Screen('DrawTexture', win,Screen('MakeTexture', win, image));
Screen('Flip', win); % must flip for the stimulus to show up on the mainwin
ShowCursor('hand');

[clicks,x,y,whichButton] = GetClicks(win,1);

end
%% Rater function::
function [rate] = rater(x)
%%
x1 = [487, 550];
x2 = [575, 635];
x3 = [660 720];
x4 = [748 807];
x5 = [833 895];
%%
if (x >= min(x1) && x<=max(x1))
    rate = 1;
elseif (x >= min(x2) && x<=max(x2))
    rate =2;
elseif (x >= min(x3) && x<=max(x3))
    rate =3;
elseif (x >= min(x4) && x<=max(x4))
    rate =4;
elseif (x >= min(x5) && x<=max(x5))
    rate =5;
end
end



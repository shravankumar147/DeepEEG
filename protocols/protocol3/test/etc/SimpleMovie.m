function SimpleMovie(~, ~)
%% Shravankumar, CVIT, IIITH
% Date : 12-11-2016
% To show videos and take responses on given scale
%% UserData
[outfile, ~, subid, subage, gender, group] = userlog();
%% Screen setup
[win,rect] = screenSetup();
%% Specif the files to paly
% database loading into imds variable
imds = datastore('testVideos\','FileExtensions', '.mp4','Type', 'image');
I = imds.Files;
l = length(imds.Files);
R = imread('rating.png');
%% Main Loop
for loop = 1:2
    moviename= [I{randi([1,l])}];
    %% Play the movie
    fixCross(win,rect);
    playmovie(moviename,win);
    [~,x,y,~] = getResponse(win, R);
    [rate] = rater(x);
    fprintf(outfile,'%s\t %s\t %s\t %s\t %s\t %d\t %d\t %d\t\n', subid, subage, gender, group, moviename ,x, y, rate);
    WaitSecs(2)    
end % end of loop
sca;
fclose(outfile);
end % end of the function

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%% User log
function [outfile, output, subid, subage, gender, group] = userlog()
%% UserData
% Login prompt and open file for writing data out
prompt = {'Outputfile', 'Subject''SNumber:', 'Age', 'Gender', 'Group'};
defaults = {'userRate', '1', '18', 'F', 'cvit'};
answer = inputdlg(prompt, 'userRate', 2, defaults);
[output, subid, subage, gender, group] = deal(answer{:}); % all input variables are strings
response = [output gender subage  group subid '.xls'];

if exist(response)==2 % check to avoid overiding an existing file
    fileproblem = input('That file already exists! Append a .x (1), overwrite (2), or break (3/default)?');
    if isempty(fileproblem) || fileproblem==3
        return;
    elseif fileproblem==1
        response = [response '.x'];
    end
end
outfile = fopen(response,'w+'); % open a file for writing data out
fprintf(outfile, 'Subid\t Subage\t Gender\t Group\t Fname\t x\t y\t Rating\t \n');
end




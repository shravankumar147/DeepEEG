function cognload_edit()
%% Shravankumar, CVIT, IIITH
% Date : 16-11-2016
% example
% choose one out of four types : bar, pie, char, pos
% cognload('bar')
%% Function call
addpath('utils\');
%% UserData
% stay_quit();
[outfile, output, subid, subage, gender, group, type] = userlog();
%% Screen setup
[win,rect] = screenSetup();
KbName('UnifyKeyNames');
spaceKey = KbName('space'); escKey = KbName('ESCAPE');

%% n-back algorithm
% Selecting a particular order to show images :
n_cp = 2;
n_bp = 1;
color =3;
seq = seqgen(n_cp);
s = seq(randi([1,size(seq,1)]),:);
[corrAns_cp, ~] = nback_cp(n_cp, s);
[corrAns_bp, ~, ~] = nback_bp(color,n_bp,s);

% s = seq(1,:);
%% choose one out of four types : 1.bar, 2.pie, 3.char, 4.pos ==> 1, 2, 3, 4
k = 0;
for mm = 1:5 % This controls how many blocks you want to run
    n = [1 3 2 4];
    if length(n) >= mm
        k = k+1;
        type = stacktype(n(k));
        [I,le,sz1] = selimgtype(type);
        %%###################################%%
        Ir=[];
        for q = 1:le % have to change to le
            L = s(q);
            Ir = [Ir;imread(I{L})]; % Here Every image in the folder stacked in to array Ir
        end
    else
        continue;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%
    % stay_quit()
    %% Main Loop
    fixCross(win,rect);
    for loop = 1:2    % This loop controls how many stimuli's to show to the participant.
        %% Play the slide
        showimg(Ir,win,loop,sz1)
        WaitSecs(2)
        %% contineu or come out
        keyIsDown=0;
        while 1
            [keyIsDown, ~, keyCode] = KbCheck;
            FlushEvents('keyDown');
            if keyIsDown
                if keyCode(escKey)
                    ShowCursor; Screen('CloseAll'); sca;
                    return;
                end
            else
                if strcmp(type,'bar') || strcmp(type,'pie')
                    question_bp = ['Is the current red bar bigger or smaller than \n the red bar' num2str(n_bp) 'back before'];
                    [~,x,~,~,ar,rt] = getResponse_bp(win,rect,question_bp);
                    [rate] = rater(x,ar);
                    acc = abs(corrAns_bp(loop) - rate); % have to change according to the question asked 
                elseif strcmp(type,'char') || strcmp(type,'pos')
                    question_cp = ['Did you see this before' num2str(n_cp) 'slides'];
                    [~,x,~,~,ar,rt] = getResponse_cp(win,rect,question_cp);
                    [rate] = rater(x,ar);
                    acc = abs(corrAns_cp(loop) - rate);
                end
                status = evaluater(acc);
%                 [rate] = rater(x,ar);
%                 acc = abs(corrAns - rate);
                fprintf(outfile,'%s\t %s\t %s\t %s\t %s\t %d\t %d\t %d\t %d\t %s\t %3.2f\t \n',...
                                subid, subage, gender, group, type, corrAns_cp(loop), corrAns_bp(loop), rate, ~acc, status, rt);
                break;
            end
        end
        WaitSecs(0.5);
    end % end of loop
end %end of cognload
sca;
fclose(outfile);
movefile('*.xls','log\');
end


%% Functions
%% read imagae
function showimg(img,win,loop,sz1)
        Screen('FillRect', win , [0 0 0]);
        % present the stimulus
        t = loop-1;
        Screen('DrawTexture', win,Screen('MakeTexture', win, img(sz1*(t)+1:((t+1)*sz1),:,:)));
        Screen('Flip', win); % must flip for the stimulus to show up on the mainwin
        %ShowCursor('hand'); 
end
%% Rater function::
function [rate] = rater(x,ar)

if (x>ar(1,1) && x < ar(3,1))
    rate=1;
elseif (x>ar(1,2) && x < ar(3,2))
    rate=2;
elseif (x>ar(1,3) && x < ar(3,3))
    rate=3;
elseif (x>ar(1,4) && x < ar(3,4))
    rate=4;
else
    rate=5;
end
end
 
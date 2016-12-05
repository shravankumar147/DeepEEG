% function practice_session()
%% Shravankumar, CVIT, IIITH
% Date : 16-11-2016
% example
% choose one out of four types :char, pos, bar, pie,
% function call
clear all
addpath('utils\');
%  UserData
[outfile, subid, subage, gender, group] = userlog();
% Screen setup
[win,rect] = screenSetup(2);
KbName('UnifyKeyNames');
spaceKey = KbName('space'); escKey = KbName('ESCAPE');

% Variables
N3 = [
    3     1     2     3     2     3     1     2     3     1
    4     2     1     4     1     4     2     1     4     2
    1     2     3     1     3     2     1     2     3     1
    3     2     4     1     4     2     1     2     4     1
    2     1     3     2     1     2     3     1     3     2
    1     1     4     2     1     2     4     1     4     2
    3     1     3     2     1     3     2     3     2     1
    4     2     4     1     2     4     1     4     1     2
    ];%8 sessions

nb_blocks = size(N3,1);
nb_stimuli = 12;
k = 0;
r = randi([0 1]);
% threshold for 0-back for BAR Graphs
th = 50;
% char "s"
ch = 14 ;

n_cp = [0 1 2 3 0 1 2 3 0 3];% session wise n back
n_bp = n_cp;
% %% Instruction Images % Reading the image paths inst =
% imageDatastore('input\nback\stimuli\instructions','FileExtensions',
% {'.jpg', '.png', '.tif'}); I = inst.Files; I1 = imread(I{1}); size1 =
% size(I1,1); % counting the number of images in the folder le =
% length(inst.Files); Ir=[];
%
% for q = 1:le
%     Ir = [Ir;imread(I{q})];
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for ii = 1:le
%        t = ii-1;
%         Screen('DrawTexture', win,Screen('MakeTexture', win,
%         Ir(size1*(t)+1:((t+1)*size1),:,:)));

%ShowCursor('hand');
% end

%%
for mm = 1:nb_blocks % This controls how many blocks you want to runs
    for nn = 1:size(N3,2)
        n = N3(mm,nn);
        if length(n_cp) >= nn
            idx = n_cp(nn); % idx is n-back
            seq = seqgen(idx);
            s = seq(randi([1,size(seq,1)]),:); % randomly selecting one out of 4 sequences for 2-back task
            type = stacktype(n);
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
        %% Main Loop
        % color [1.blue; 2.cyan; 3.red; 4.green]
        % a rondom number is generated to choose one of the four colors
        c =randi([1,4]);
        % Based on the c value any one of the color is choosen by the below
        % function
        % color [1.blue; 2.cyan; 3.red; 4.green]
        clr = chooseClr(c);
        month = choosemnth(c); yr = yrgen(s) ;
        [Q, Q1] = type_instructions(type, idx, month);
        instruction_show(win, Q,1 );
        fixCross(win,rect);
        WaitSecs(0.5)
        % This loop controls how many stimuli's to show to the participant.
        for loop = 1:nb_stimuli
            [corrAns_cp, ~] = nback_cp(idx, s, type, ch); % generating correct answers before hand to evaluate participant performence :: char & position task
            [corrAns_bp, ~] = nback_bp(c, idx, s, type, th); % generating correct answers before hand to evaluate participant performence :: bar & pie task
            %% Play the slide
            showimg(Ir,win,loop,sz1, type,Q1,idx, rect)
            % continue or come out
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
                        
                        if loop > idx
                            [~,x,~,buttons,ar,rt] = getResponse_bp(win,rect);
                            resp = any(buttons);
                            if resp
                                [rate] = rater(x,ar,2);
                                acc = abs(corrAns_bp(loop) - rate); % have to change according to the question asked
                                corrAns_cp(loop) = 0;
                            else
                                rate = 0;
                                acc = 1;
                                corrAns_cp(loop) = 0;
                            end
                        else
                            break;
                        end
                    elseif strcmp(type,'char') || strcmp(type,'pos')
                        clr = 'none';
                        if loop > idx
                            [~,x,~,buttons,ar,rt] = getResponse_cp(win,rect);
                            resp = any(buttons);
                            if resp
                                [rate] = rater(x,ar,2);
                                acc = abs(corrAns_cp(loop) - rate);
                                corrAns_bp(loop) = 0;
                            else
                                rate = 0;
                                acc = 1;
                                corrAns_bp(loop) = 0;
                            end
                        else
                            break;
                        end
                    end
                    status = evaluater(acc);
                    fprintf(outfile,'%s\t %s\t %s\t %s\t %s\t %d\t %d\t %d\t %d\t %s\t %d\t %d\t %s\t %3.2f\t \n',...
                        subid, subage, gender, group, type, corrAns_cp(loop), idx, corrAns_bp(loop), idx, clr, rate, ~acc, status, rt);
                    break;
                end
            end
            WaitSecs(0.5);
        end % end of loop
        if mod(nn,2) == 0
            instruction_show(win, 'Sit Back and Relax. \n\nPlease Do Not Move',0 )
            WaitSecs(5) %adjust between trials wait time say 10secs
        end
    end % end of stimuli
    WaitSecs(0.5) %adjust waiting time between set of two trials
end %end of nb_blocs
sca;
fclose(outfile);

% movefile('*.xls','log\');
% end



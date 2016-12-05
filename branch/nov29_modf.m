% function nov29_modf()
%% Shravankumar, CVIT, IIITH
% Date : 16-11-2016
% example
% choose one out of four types : bar, pie, char, pos
% function call
% ----------------------------
%   PRACTICE SESSION
% ----------------------------
practice_session()
% ----------------------------
%   ACTUAL SESSION
% ----------------------------
clear all
addpath('utils\');
%  UserData
[outfile, subid, subage, gender, group] = userlog();
% Screen setup
[win,rect] = screenSetup();
KbName('UnifyKeyNames');
spaceKey = KbName('space'); escKey = KbName('ESCAPE');
% choose one out of four types : 1.bar, 2.pie, 3.char, 4.pos ==> 1, 2, 3, 4
nb_blocks = 4; nb_stimuli = 4; k = 0; r = randi([0 1]);
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
n_cp = [0 1 2 3 0 1 2 3 0 3];% session wise n back
n_bp = n_cp;
%%
for mm = 1:nb_blocks % This controls how many blocks you want to runs   
    for nn = 1:size(N3,2)
        n = N3(mm,nn);
        if length(n_cp) >= nn
        idx = n_cp(nn); % idx is n-back
        seq = seqgen(idx);
        s = seq(randi([1,size(seq,1)]),:); % randomly selecting one out of 4 sequences for 2-back task
        
        %if length(n) >= mm
        %k = k+1;
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
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Main Loop
%         instruction_show(win);
            c =randi([1,4]);     % color [1.blue; 2.cyan; 3.red; 4.green]
            clr = chooseClr(c); % color [1.blue; 2.cyan; 3.red; 4.green] a string to show user/ participant: which color to compare
            month = choosemnth(c); yr = yrgen(s) ;

        in1 = ['Using' num2str(idx) '-back' '\n ' 'Type :' type];
        instruction_show(win, in1,1 );
        [Q] = type_instructions(type, idx);
        instruction_show(win, Q,1 );
        fixCross(win,rect);
        WaitSecs(0.5)
        for loop = 1:nb_stimuli    % This loop controls how many stimuli's to show to the participant.

            
            [corrAns_cp, ~] = nback_cp(idx, s); % generating correct answers before hand to evaluate participant performence :: char & position task
            [corrAns_bp, ~] = nback_bp(c,idx,s); % generating correct answers before hand to evaluate participant performence :: bar & pie task
            %% Play the slide
            showimg(Ir,win,loop,sz1)
            if strcmp(type,'bar') || strcmp(type,'pie')
                WaitSecs(1)     %adjust display duration for bars and pies
            else
                WaitSecs(1) %adjust display duration for spatial and chars
            end
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
                        
                        if loop > idx
                            %                         if strcmp(type,'bar')
                            %                             Q1 = ['Evaluate : ' month num2str(yr(loop)) '-' clr ' > ' ...
                            %                                 month num2str(yr(loop-(n_bp))) '-'  clr ];
                            %                         else strcmp(type,'pie')
                            %                            Q1 = ['Evaluate : ' month num2str(yr(loop)) '-' clr ' > ' ...
                            %                                 month num2str(yr(loop-(n_bp))) '-'  clr ];
                            %                         end
                            [~,x,~,~,ar,rt] = getResponse_bp(win,rect);
                            [rate] = rater(x,ar,2);
                            acc = abs(corrAns_bp(loop) - rate); % have to change according to the question asked
                            corrAns_cp(loop) = 0;
                        else
                            break;
                        end
                    elseif strcmp(type,'char') || strcmp(type,'pos')
                        clr = 'none';
                        if loop > idx
                            [~,x,~,~,ar,rt] = getResponse_cp(win,rect);
                            [rate] = rater(x,ar,2);
                            acc = abs(corrAns_cp(loop) - rate);
                            corrAns_bp(loop) = 0;
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
            instruction_show(win, 'Sit Back and Relax...! \nPlease Do Not Move',0 )
            WaitSecs(0.5) %adjust between trials wait time say 10secs
        end
    end
    WaitSecs(1) %adjust waiting time between set of two trials
end %end of cognload
sca;
fclose(outfile);
% movefile('*.xls','log\');
% end



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
% choose one out of four types : 1. char, 2.pos , 3. bar, 4.pie ==> 1, 2, 3, 4
nb_blocks = 1; nb_stimuli = 6; k = 0; r = randi([0 1]); th = 50; ch = 14 ;% char "s"
N3 = [ 4 4 3 4
    4 1 4 2
    %      1     1     4     2     1     2     4     1     4     2
    ];%8 sessions


n_cp = [0 0 0 0];% session wise n back {easy + hard}
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
        %
        %         in1 = ['Using ' num2str(idx) '-back' '\n\n ' 'Type : ' type];
        %         instruction_show(win, in1,1 );
        [Q, Q1] = type_instructions(type, idx, month);
        instruction_show(win, Q,1 );
        fixCross(win,rect);
        WaitSecs(0.5)
        for loop = 1:nb_stimuli    % This loop controls how many stimuli's to show to the participant.
            [corrAns_cp, ~] = nback_cp(idx, s, type, ch); % generating correct answers before hand to evaluate participant performence :: char & position task
            [corrAns_bp, ~] = nback_bp(c, idx, s, type, th); % generating correct answers before hand to evaluate participant performence :: bar & pie task
            %% Play the slide
            showimg(Ir,win,loop,sz1,Q1,idx)
            
            if strcmp(type,'bar') || strcmp(type,'pie')
                WaitSecs(4)     %adjust display duration for bars and pies
            else
                WaitSecs(2) %adjust display duration for spatial and chars
            end
            Screen('FillRect', win , [0 0 0]);
            Screen('Flip', win);
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
                            [~,x,~,buttons,ar,rt] = getResponse_bp(win,rect);
                            resp = any(buttons);
                            if resp
                                [rate] = rater(x,ar,3);
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
                    %                 [rate] = rater(x,ar);
                    %                 acc = abs(corrAns - rate);
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
    end
    WaitSecs(0.5) %adjust waiting time between set of two trials
end %end of cognload
sca;
fclose(outfile);

% movefile('*.xls','log\');
% end



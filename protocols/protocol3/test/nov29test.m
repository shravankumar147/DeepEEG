function nov29test()
%% Shravankumar, CVIT, IIITH
% Date : 16-11-2016
% example
% choose one out of four types : bar, pie, char, pos
% function call
addpath('utils\');
%  UserData
[outfile, subid, subage, gender, group, n_bp, n_cp] = userlog();
% Screen setup
[win,rect] = screenSetup();
KbName('UnifyKeyNames');
spaceKey = KbName('space'); escKey = KbName('ESCAPE');
% choose one out of four types : 1.bar, 2.pie, 3.char, 4.pos ==> 1, 2, 3, 4
nb_blocks = 4; nb_stimuli = 4; k = 0; r = randi([0 1]);
% Selecting a particular order to show images :
n_cp = str2double(n_cp); % n-back for char and positions
n_bp = str2double(n_bp); % n-back for Bar and Pie
seq = seqgen(n_cp);
disp(seq)
%%
for mm = 1:nb_blocks % This controls how many blocks you want to runs 
    s = seq(randi([1,size(seq,1)]),:); % randomly selecting one out of 4 sequences for 2-back task
    disp(s)
    N1 = [1 3 1 4 1 3 4 1 3 1 4]; 
    N2 = [2 3 2 4 2 3 4 2 3 2 4];
    N3 = [3 4 4 3 3 4 3 4 3 4 3 ];
    lev = 'hard';
    if strcmp(lev,'easy')
        n = r*N1 + ~r*N2;
    else
        n = Shuffle(N3);
    end
    
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
    %% Main Loop
    instruction_show(win);
    fixCross(win,rect);
    WaitSecs(0.5)
    for loop = 1:nb_stimuli    % This loop controls how many stimuli's to show to the participant.
        c =randi([1,4]);     % color [1.blue; 2.cyan; 3.red; 4.green]
        clr = chooseClr(c); % color [1.blue; 2.cyan; 3.red; 4.green] a string to show user/ participant: which color to compare
        month = choosemnth(c); yr = yrgen(s) ;
        [corrAns_cp, ~] = nback_cp(n_cp, s); % generating correct answers before hand to evaluate participant performence :: char & position task
        [corrAns_bp, ~] = nback_bp(c,n_bp,s); % generating correct answers before hand to evaluate participant performence :: bar & pie task
        %% Play the slide        
        showimg(Ir,win,loop,sz1)
        if strcmp(type,'bar') || strcmp(type,'pie')
        WaitSecs(2)
        else
            WaitSecs(2)
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
                    
                    if loop > n_bp
                        if strcmp(type,'bar')
                            Q1 = ['Evaluate : ' month num2str(yr(loop)) '-' clr ' > ' ...
                                month num2str(yr(loop-(n_bp))) '-'  clr ];
                            
                        else strcmp(type,'pie')
                           Q1 = ['Evaluate : ' month num2str(yr(loop)) '-' clr ' > ' ...
                                month num2str(yr(loop-(n_bp))) '-'  clr ];

                        end
                        [~,x,~,~,ar,rt] = getResponse_bp(win,rect,Q1);
                        [rate] = rater(x,ar,3);
                        acc = abs(corrAns_bp(loop) - rate); % have to change according to the question asked
                        corrAns_cp(loop) = 0;
                    else 
                        break;
                    end
                elseif strcmp(type,'char') || strcmp(type,'pos')
                    clr = 'none';
                    if loop > n_cp
                        if strcmp(type,'char')
                            Q2 = ['Did you see this character before ' num2str(n_cp) ' slides back'];
                        elseif strcmp(type,'pos')
                            Q2 = ['Did you see this block before ' num2str(n_cp) ' slides back in the same posiotion'];
                        end
                        [~,x,~,~,ar,rt] = getResponse_cp(win,rect,Q2);
                        [rate] = rater(x,ar,2);
                        acc = abs(corrAns_cp(loop) - rate);
                        corrAns_bp(loop) = 0;
                    else                        
                        break;
                    end
                end
                status = evaluater(acc);
                %                 [rate] = rater(x,ar);
                %                 acc = abs(corrAns - rate);
                fprintf(outfile,'%s\t %s\t %s\t %s\t %s\t %d\t %d\t %d\t %d\t %s\t %d\t %d\t %s\t %3.2f\t \n',...
                    subid, subage, gender, group, type, corrAns_cp(loop), n_cp, corrAns_bp(loop), n_bp, clr, rate, ~acc, status, rt);
                break;
            end
        end
        WaitSecs(0.5);
    end % end of loop
    if mod(mm,2) == 0
    instruction_show(win, 'Sit Back and Relax...! \nPlease Do Not Move',0 )
    WaitSecs(1)
    end  
end %end of cognload
sca;
fclose(outfile);

% movefile('*.xls','log\');
end



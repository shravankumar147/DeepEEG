% function practice_session()
% Shravankumar, CVIT, IIITH
% Date : 16-11-2016
% example
% choose one out of four types :char, pos, bar, pie,
% function call


clear;
addpath('utils\');
addpath('tobii_api\');


%  UserData
[outfile, subid, subage, gender] = userlog();

%paramaeters
nb_stimuli = 3;
k = 0;
r = randi([0 1]);
% threshold for 0-back for BAR Graphs
th = 50;
% char "s"
ch = 14 ;

midx_trial_start   = 1;
midx_trial_end     = 2;
midx_session_start = 100;
midx_session_end   = 200;
midx_image         = 300;
midx_qestion       = 400;
midx_response      = 500;

comid              = 'COM1';


% Screen setup
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests', 1); 
Screen('Preference', 'VisualDebugLevel', 3);
Screen('Preference', 'SuppressAllWarnings', 1);
[win,rect] = screenSetup(0);
%[win,rect] = screenSetup(2);


%key setup
KbName('UnifyKeyNames');
spaceKey = KbName('space'); 
escKey = KbName('ESCAPE');

% Session sequence
% n_sessions = [
%     3     1     4     2     3     1     4     2     3     1     4     2
%     4     2     3     1     4     2     3     1     4     2     3     1
%     ];

n_sessions = [
    1     2     3     4     1     2     3     4     3     1     4     2
    4     2     3     1     4     2     3     1     4     2     3     1
    ];



n_cp = [
    0 1 0 1 2 3 2 3 1 0 1 0
    1 0 3 2 3 2 1 0 2 3 3 2
    ];% session wise n back

% n_cp = [
%     3 3 3 3 0 0 0 0  1 0 1 0
%     1 0 3 2 3 2 1 0 2 3 3 2
%     ];% session wise n back


n_bp = n_cp;


nb_blocks = size(n_sessions,1);



for s_id = 1:2%nb_blocks % This controls how many blocks you want to runs
    disp(['Trial' num2str(s_id) 'started'])
    system(['PortWrite ' comid ' ' num2str(midx_trial_start)]);
    for set_id = 1:4%size(n_sessions,2)
        disp(['Session' num2str(set_id) 'started'])
        system(['PortWrite ' comid ' ' num2str(midx_session_start)]);
        n= n_sessions(s_id,set_id);
        if length(n_cp(s_id,:)) >= set_id
            nback = n_cp(s_id,set_id); %n-back
            seq = seqgen(nback);
            s = seq(randi([1,size(seq,1)]),:); % randomly selecting one out of 4 sequences for 2-back task
            type = stacktype(n);
            [I,le,sz1] = selimgtype(type);
           
            Ir=[];
            for q = 1:le % have to change to le
                L = s(q);
                Ir = [Ir;imread(I{L})]; % Here Every image in the folder stacked in to array Ir
            end
        else
            continue;
        end
        
        
        % Main Loop
        % color [1.blue; 2.cyan; 3.red; 4.green]
        % a rondom number is generated to choose one of the four colors
        c =randi([1,4]);
        % Based on the c value any one of the color is choosen by the below
        % function
        % color [1.blue; 2.cyan; 3.red; 4.green]
        clr = chooseClr(c);
        month = choosemnth(c); yr = yrgen(s) ;
        [Q, Q1] = type_instructions(type, nback, month);
        instruction_show(win, Q,1 );
        fixCross(win,rect);
        WaitSecs(0.5);
        % This loop controls how many stimuli's to show to the participant.
        for loop = 1:nb_stimuli
            [corrAns_cp, ~] = nback_cp(nback, s, type, ch); % generating correct answers before hand to evaluate participant performence :: char & position task
            [corrAns_bp, ~] = nback_bp(c, nback, s, type, th); % generating correct answers before hand to evaluate participant performence :: bar & pie task
            % Play the slide
            disp(['Image ' num2str(loop) ' Displayed'])
            system(['PortWrite ' comid ' ' num2str(midx_image)]);
            showimg(Ir,win,loop,sz1, type,Q1,nback, rect);
            % continue or come out
            keyIsDown=0;
            while 1
                [keyIsDown, ~, keyCode] = KbCheck;
                FlushEvents('keyDown');
                if keyIsDown
                    if keyCode(escKey)
                        fclose(outfile);
                        ShowCursor; Screen('CloseAll'); sca;
                        return;
                    end
                else
                    if strcmp(type,'bar') || strcmp(type,'pie')
                        
                        if loop > nback
                             disp(['Question ' num2str(loop) ' Displayed'])
                             system(['PortWrite ' comid ' ' num2str(midx_qestion)]);
                             [~,x,~,buttons,ar,rt] = getResponse(win,rect);
                             disp(['Response ' num2str(loop) ' received'])
                             system(['PortWrite ' comid ' ' num2str(midx_response)]);
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
                        if loop > nback
                             disp(['Question ' num2str(loop) ' Displayed'])
                             system(['PortWrite ' comid ' ' num2str(midx_qestion)]);
                             [~,x,~,buttons,ar,rt] = getResponse(win,rect);
                             disp(['Response ' num2str(loop) ' received'])
                             system(['PortWrite ' comid ' ' num2str(midx_response)]);
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
                    fprintf(outfile,'%s\t %s\t %s\t %s\t %d\t %d\t %d\t %d\t %s\t %d\t %d\t %s\t %3.2f\t \n',...
                        subid, subage, gender, type, corrAns_cp(loop), nback, corrAns_bp(loop), nback, clr, rate, ~acc, status, rt);
                    break;
                end
            end
            WaitSecs(0.5);
        end % end of loop
        disp(['Session' num2str(set_id) 'end'])
        system(['PortWrite ' comid ' ' num2str(midx_session_end)]);
        if mod(set_id,2) == 0
            instruction_show(win, 'Sit Back and Relax. \n\nPlease Do Not Move',0 )
            WaitSecs(5) %adjust between trials wait time say 10secs
        end
    end % end of stimuli
    WaitSecs(0.5) %adjust waiting time between set of two trials
    
    disp(['Trial ' num2str(s_id) ' ended'])
    system(['PortWrite ' comid ' ' num2str(midx_trial_end)]);
    
end %end of nb_blocs
sca;
fclose(outfile);

% movefile('*.xls','log\');
% end



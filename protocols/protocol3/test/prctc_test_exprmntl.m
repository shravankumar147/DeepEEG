% function practice_session()
%% Shravankumar, CVIT, IIITH
% Date : 16-11-2016
% example
% choose one out of four types :char, pos, bar, pie,
% function call
clear all
addpath('utils\');
%  UserData


% [outfile, subid, subage, gender, group] = userlog();
% Screen setup
[win,rect] = screenSetup(2);
KbName('UnifyKeyNames');
spaceKey = KbName('space'); escKey = KbName('ESCAPE');
% Instructions
t = {'char', 'pos', 'bar', 'pie'};
for i = 1:4
I1 = instruction_example(t{i});
instruction_show(win, I1);
end
WaitSecs(2)
sca;


% % choose one out of four types : 1. char, 2.pos , 3. bar, 4.pie ==> 1, 2, 3, 4
% nb_blocks = 1; nb_stimuli = 6; k = 0; r = randi([0 1]); th = 50; ch = 14 ;% char "s"
% N3 = [ 4 3 2 1
%     4 1 4 2
%     %      1     1     4     2     1     2     4     1     4     2
%     ];%8 sessions
% 
% n_cp = [3 2 1 0];% session wise n back {easy + hard}
% n_bp = n_cp;
% % %% Instruction Images % Reading the image paths inst
% %%
% for mm = 1:nb_blocks % This controls how many blocks you want to runs
%     
%     
%     for nn = 1:size(N3,2)
%         n = N3(mm,nn);
%         if length(n_cp) >= nn
%             idx = n_cp(nn); % idx is n-back
%             seq = seqgen(idx);
%             s = seq(randi([1,size(seq,1)]),:); % randomly selecting one out of 4 sequences for 2-back task
%             
%             %if length(n) >= mm
%             %k = k+1;
%             type = stacktype(n);
%             [I,le,sz1] = selimgtype(type);
%             %%###################################%%
%             Ir=[];
%             for q = 1:le % have to change to le
%                 L = s(q);
%                 Ir = [Ir;imread(I{L})]; % Here Every image in the folder stacked in to array Ir
%             end
%         else
%             continue;
%         end
%         
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         %% Main Loop
%         c =randi([1,4]);     % color [1.blue; 2.cyan; 3.red; 4.green]
%         clr = chooseClr(c); % color [1.blue; 2.cyan; 3.red; 4.green] a string to show user/ participant: which color to compare
%         month = choosemnth(c); yr = yrgen(s) ;
%         [Q, Q1] = type_instructions(type, idx, month);
%         instruction_show(win, Q,1 );
%         fixCross(win,rect);
%         WaitSecs(0.5)
%         for loop = 1:nb_stimuli    % This loop controls how many stimuli's to show to the participant.
%             [corrAns_cp, ~] = nback_cp(idx, s, type, ch); % generating correct answers before hand to evaluate participant performence :: char & position task
%             [corrAns_bp, ~] = nback_bp(c, idx, s, type, th); % generating correct answers before hand to evaluate participant performence :: bar & pie task
%             %% Play the slide
%             showimg(Ir,win,loop,sz1, type,Q1,idx, rect)
%             resp2write(win, rect, type, loop, idx, corrAns_bp, corrAns_cp, clr, outfile, subid, subage, gender, group)
%         end % end of loop
%         if mod(nn,2) == 0
%             instruction_show(win, 'Sit Back and Relax. \n\nPlease Do Not Move',0 )
%             WaitSecs(5) %adjust between trials wait time say 10secs
%         end
%     end
%     WaitSecs(0.5) %adjust waiting time between set of two trials
% end %end of cognload
% sca;
% fclose(outfile);
% 
% % movefile('*.xls','log\');
% % end



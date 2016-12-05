function resp2write(win, rect, type, loop, idx, corrAns_bp, corrAns_cp, clr, outfile, subid, subage, gender, group)
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
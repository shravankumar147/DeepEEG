function stay_quit()
%% contineu or come out
KbName('UnifyKeyNames');
spaceKey = KbName('space'); escKey = KbName('ESCAPE'); 
        keyIsDown=0;
        while 1
            [keyIsDown, secs, keyCode] = KbCheck;
            if keyIsDown
                if keyCode(spaceKey)
                    disp('spspsps' )
                    break ;
                elseif keyCode(escKey)
                    ShowCursor;
                    fclose(outfile);
                    Screen('CloseAll');
                    return;
                end
            end
        end
        WaitSecs(0.3);
end
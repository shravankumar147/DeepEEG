function exitsession()
KbName('UnifyKeyNames');
spaceKey = KbName('space'); escKey = KbName('ESCAPE');
keyIsDown=0;
[keyIsDown, secs, keyCode] = KbCheck;
                FlushEvents('keyDown');
                if keyIsDown
                    nKeys = sum(keyCode);
                    if nKeys==1
                        if keyCode(escKey)
                            ShowCursor; Screen('CloseAll'); sca;
                            return;
                        end
                        keyIsDown=0; keyCode=0;
                    end
                end
end
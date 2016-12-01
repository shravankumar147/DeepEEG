clicks = 1;buttons=0;
tend= GetSecs + 10;
while GetSecs < tend && ~any(buttons)
    % If already down, wait for release...
    while any(buttons) && GetSecs < tend
        [xd,yd,buttons] = GetMouse([]);
    end;

    % Wait for a press or timeout:
    while ~any(buttons) && GetSecs < tend
        [xd,yd,buttons] = GetMouse([]);
    end;
end;
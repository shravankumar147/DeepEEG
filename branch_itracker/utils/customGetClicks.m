function [xd, yd, buttons] = customGetClicks(waitTime,win)
% if nargin < 2
%     win = [];
% end
buttons=0;
tend= GetSecs + waitTime;
while GetSecs < tend && ~any(buttons)
    % If already down, wait for release...
    while any(buttons) && GetSecs < tend
        [xd,yd,buttons] = GetMouse(win);
    end;

    % Wait for a press or timeout:
    while ~any(buttons) && GetSecs < tend
        [xd,yd,buttons] = GetMouse(win);
    end;
end;

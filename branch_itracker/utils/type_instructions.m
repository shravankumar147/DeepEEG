function [q,q1] = type_instructions(type, idx, month)
%% instruction to be displayed on the go
% Dec1 : created Q1 for displaying the questions under the every image.

s1 = 'bar'; % 3
s2 = 'pie'; % 4
s3 = 'char'; % 1
s4 = 'pos'; % 2

% ------------------------
%     s3 = 'char'; % 1
% ------------------------
if strcmp(type,s3)
    if idx ~= 0
        Q = ['A sequence of characters in will be displayed in random order.\n\n' ...
             'Click     if you have seen the                 '             ' slides ago'...
            ];
       Qh = ['                                                              \n\n' ...
             '      YES                      same character ' num2str(idx) '           '...
            ];
        Q1 = ['If you have seen this character  '             ' slides ago then click YES, otherwise NO'];
       Q1h = ['                                ' num2str(idx) '                                        '];
    else
        Q = ['A sequence of characters in will be displayed in random order.\n\n' ...
             'If you see the character     then click YES otherwise NO'];
       Qh = ['                                                              \n\n' ...
             '                         "S"                            ']; 
        Q1 = ['If you see the character     then click YES otherwise NO'];
       Q1h = ['                         "S"                            '];
    end
    % ------------------------
    %     s4 = 'pos'; % 2
    % ------------------------
elseif strcmp(type,s4)
    if idx~=0
        Q = ['A 3x3 grid will be displayed. \nIn which one cell will be highlighted each time.\n\n' ...
            'Click     if you have seen the                       '             '  slides ago,\n'...
            ];
       Qh = ['                              \n                                                \n\n' ...
            '      YES                      same cell highlighted ' num2str(idx) '            \n'...
            ];
        Q1 = ['If you have seen the same position highlighted '             '  slides ago then click YES, otherwise NO'];
       Q1h = ['                                               ' num2str(idx) '                                        '];
    else
        Q = ['A 3x3 grid will be displayed. \nIn which one cell will be highlighted each time.\n\n' ...
            'If the        cell of grid is highlighted then click     otherwise NO'];
       Qh = ['                              \n                                                \n\n' ...
            '       center                                        YES             '];
        Q1 = ['If the        cell of grid is highlighted then click YES otherwise NO'];
       Q1h = ['       center                                                        '];
    end
    % ------------------------
    %     s1 = 'bar'; % 3
    % ------------------------
elseif strcmp(type,s1)
    if idx ~= 0
        Q = ['A sequence of bar graphs for rainfall data from January to April over years will be displayed.\n\n' ...
             'Click     if you observe the rainfall for '    '     in the current year is higher than the rainfall\n' ...
             'for the same month '             '        ago'...
            ];
       Qh = ['                                                                                              \n\n' ...
             '      YES                                 ' month '                                                 \n' ...
             '                   ' num2str(idx) ' years    '...
            ];
        Q1 = ['If the rainfall for '    '    is greater than the rainfall for the same month  '             '  years ago'];
       Q1h = ['                    ' month '                                                  ' num2str(idx) '          '];
    else
        Q = ['A sequence of bar graphs for rainfall data from January to April over years will be displayed.\n\n' ...
            'Click     if you observe the rainfall for '    '    of the current year is higher than      '
            ];
       Qh = ['                                                                                              \n\n' ...
            '      YES                                 ' month '                                    50cms'
            ];
        Q1 = ['If the rainfall for '    '    is greater the      then click YES otherwise NO'];
       Q1h = ['                    ' month '                50cm                            '];
    end
    
    
    % ------------------------
    %     s2 = 'pie'; % 4
    % ------------------------
elseif strcmp(type,s2)
     if idx ~= 0
        Q = ['A sequence of pie charts for rainfall data from January to April over years will be displayed.\n\n' ...
             'Click     if you observe the rainfall for '    '    in the current year is higher than the rainfall\n' ...
             'for the same month '             '        ago'...
            ];
       Qh = ['                                                                                              \n\n' ...
             '      YES                                 ' month '                                                \n' ...
             '                   ' num2str(idx) ' years    '...
            ];
        Q1 = ['If the rainfall for '    '    is greater than the rainfall for the same month  '             '  years ago'];
       Q1h = ['                    ' month '                                                  ' num2str(idx) '          '];
    else
        Q = ['A sequence of pie charts for rainfall data from January to April over years will be displayed.\n\n' ...
            'Click     if you observe the rainfall for '    '    of the current year is higher than      '
            ];
       Qh = ['                                                                                              \n\n' ...
            '      YES                                 ' month '                                    50cms'
            ];
        Q1 = ['If the rainfall for '    '    is greater the      then click YES otherwise NO'];
       Q1h = ['                    ' month '                50cm                            '];
    end
    
end
q=[Q;Qh];
q1=[Q1;Q1h];


end







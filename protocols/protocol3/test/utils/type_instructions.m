function [Q,Q1] = type_instructions(type, idx, month)
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
        Q = ['In this task you will see a sequence of CHARACTERS in random order from A-U.\n\n' ...
            'You need to decide if you saw the same letter ' num2str(idx) '  slides ago,\n'...
            ' that is n = ' num2str(idx) '-back task'];
        Q1 = ['If you see this letter ' num2str(idx) '-slides ago then click YES, otherwise NO'];
    else
        Q = ['If you see the letter S then click YES otherwise NO'];
        Q1 = Q;
    end
    % ------------------------
    %     s4 = 'pos'; % 2
    % ------------------------
elseif strcmp(type,s4)
    if idx~=0
        Q = ['In this task you will see a 9x9 GRID. \nIn which one position highlighted each time in blue color.\n\n' ...
            'You need to remember the position and decide if you saw \nthe same position highlighted ' num2str(idx) ' slides ago,\n'...
            'that is n = ' num2str(idx) '-back task'];
        Q1 = ['If you see the sae position highlighted ' num2str(idx) '-slides ago then click YES, otherwise NO'];
    else
        Q = ['If the center position of grid is highlighted then click YES otherwise NO'];
        Q1 = Q;
    end
    % ------------------------
    %     s1 = 'bar'; % 3
    % ------------------------
elseif strcmp(type,s1)
    if idx ~= 0
        Q = ['In this task you will see BAR GRAPHS of Rainfall data from January to April over years.\n\n' ...
            'You need to decide if the rainfall in ' month ' of the current graph is higher than the rainfall \n' ...
            'from the same month in the graph shown ' num2str(idx) '-slides before'...
            ];
        Q1 = ['The current value of the ' month ' is greater than the value of the ' month '' num2str(idx) '-slides ago'...
            '\n                                   if TRUE click YES otherwise NO' ];
    else
        Q = ['In this task you will see BAR GRAPHS of Rainfall data from January to April over years.\n\n' ...
            'You need to decide if the rainfall in ' month ' of the current graph is higher than 50cms'
            ];
        Q1 = ['The Value of the ' month ' is greater the 50cm then click YES otherwise NO'];
    end
    
    
    % ------------------------
    %     s2 = 'pie'; % 4
    % ------------------------
elseif strcmp(type,s2)
    if idx~=0
        Q = ['In this task you will see PIE CHARTS of Rainfall data from January to April over years.\n\n' ...
            'You need to decide if the rainfall in ' month ' of the current chart is higher than the rainfall \n' ...
            'from the same month in the chart shown ' num2str(idx) '-slides before'];
        
        Q1 = ['The current value of the ' month ' is greater than the value of the ' month '' num2str(idx) '-slides ago'...
            '\n                                   if TRUE click YES otherwise NO' ];
    else
        Q = ['In this task you will see PIE CHARTS of Rainfall data from January to April over years.\n\n' ...
            'You need to decide if the rainfall in ' month ' of the current chart is highest'
            ];
        Q1 = ['The sector value of the ' month ' is the highest among all then click YES otherwise NO'];
    end
end
end
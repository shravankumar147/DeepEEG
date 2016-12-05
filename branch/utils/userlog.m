function [outfile, subid, subage, gender, group, n_bp, n_cp] = userlog()
%% UserData
% Login prompt and open file for writing data out
prompt = {'Outputfile', 'Subject''SNumber:', 'Age', 'Gender', 'Group'};
defaults = {'NueroScience', '1', '18', 'F', 'cvit'};
answer = inputdlg(prompt, 'userRate', 2, defaults);
[output, subid, subage, gender, group] = deal(answer{:}); % all input variables are strings
response = [output gender subage  group subid '.xls'];

if exist(response)==2 % check to avoid overiding an existing file
    fileproblem = input('That file already exists! Append a .x (1), overwrite (2), or break (3/default)?');
    if isempty(fileproblem) || fileproblem==3
        return;
    elseif fileproblem==1
        response = [response '.x'];
    end
end
outfile = fopen(response,'w+'); % open a file for writing data out
fprintf(outfile, 'Subid\t Subage\t Gender\t Group\t type\t CorrAns_CP\t n_cp\t CorrAns_BP\t n_bp\t COLOR\t Response\t Acc\t STATUS\t  RT\t \n');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
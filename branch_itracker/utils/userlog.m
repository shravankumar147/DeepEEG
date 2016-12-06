function [outfile,eyefile, subid, subage, gender,trialid] = userlog()
%% UserData
% Login prompt and open file for writing data out
prompt = {'Outputfile', 'Subject''SNumber:', 'Age', 'Gender','Trial No'};
defaults = {'participant', '1', '24', 'M','1'};
answer = inputdlg(prompt, 'userRate', 2, defaults);
[output, subid, subage, gender,trialid] = deal(answer{:}); % all input variables are strings
response = ['experiment_data\' output '_' trialid  '_' gender subage subid '.xls'];
eye_data = ['experiment_data\' output '_' trialid  '_' gender subage subid '_eye_data' '.xls'];

if exist(response)==2 % check to avoid overiding an existing file
    fileproblem = input('That file already exists! Append a .x (1), overwrite (2), or break (3/default)?');
    if isempty(fileproblem) || fileproblem==3
        return;
    elseif fileproblem==1
        response = [response '.x'];
    end
end
outfile = fopen(response,'w+'); % open a file for writing data out
fprintf(outfile, 'Subid\t Subage\t Gender\t type\t image_id\t reference_time\t image_time\t CorrAns_CP\t n_cp\t CorrAns_BP\t n_bp\t COLOR\t Response\t Acc\t STATUS\t  RT\t \n');
eyefile = fopen(eye_data,'w+');
fprintf(eyefile,'GazeX_px\t GazeY_px\t GazeTimestamp\t L\t R\t LeyeX_mm\t LeyeY_mm\t LeyeZ_mm\t ReyeX_mm\t ReyeY_mm\t ReyeZ_mm\t EyePosTimestamp\t \n');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
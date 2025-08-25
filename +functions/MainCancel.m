function MainCancel(h, e, Operators)
    % Prompt user for confirmation
    Answer = questdlg('Are you sure you want to close the window? All data will be deleted.', ...
                      'Confirm Exit', ...
                      'Yes', 'No', 'No');
    
    if strcmp(Answer, 'Yes')
        % Close all open windows
        close all force;
        
        % Clear specific program variables
        fields = fieldnames(Operators);
        for i = 1:numel(fields)
            Operators.(fields{i}) = [];
        end
    else
        return
    end
end

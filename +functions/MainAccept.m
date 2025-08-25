function MainAccept(h,e)
    % Check if results have already been exported
    Answer = questdlg('Have you already exported the generated results?', ...
                      'Confirm Export', ...
                      'Yes', 'No', 'No');
    
    if strcmp(Answer, 'Yes')
        % Close all windows
        close all force;
        disp('Interface closed. Operation completed.');
    elseif strcmp(Answer, 'No')
        return
    else
        % Action cancelled by the user
        disp('Operation cancelled by the user.');
    end
end

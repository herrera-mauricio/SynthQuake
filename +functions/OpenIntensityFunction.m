function OpenIntensityFunction(h,e,IF,Operators)


try
    index=get(IF.List,'value');
set(IF.p{2},'XData',nan,'YData',nan)
set(IF.p{1},'XData',nan,'YData',nan)

    % === Prompt user to select a file ===
    [file, ~] = uigetfile({'*.txt';'*.m';'*.slx';'*.*'}, 'Select an intensity function file');
    
    % === Exit if cancelled ===
    if isequal(file, 0)
           set(IF.Methods{index}.Edit{16},'String',strings(1));
        return;
    else
           set(IF.Methods{index}.Edit{16},'String',fullfile(file),'Enable','inactive');
    end
    

    % === Read file data ===
    Data = table2array(readtable(file));

Operators.Fr=Data(1);
Operators.ENV = Data(2:end)';
Operators.Time = 0:1/Operators.Fr:(length(Operators.ENV)-1)/Operators.Fr;


catch ME
    msg = sprintf('An error occurred in %s:\n%s', mfilename, ME.message);
    errordlg(msg, 'Execution Error');
end
end

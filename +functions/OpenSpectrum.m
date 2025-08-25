function Sa=OpenSpectrum(h,e,RSMethods,RSAxes,Operators)

Sa = nan(size(Operators.T));

try
    % === Prompt user to select file ===
    [file, ~] = uigetfile({'*.txt'}, 'Select a design spectrum file');
    
    % === Exit if cancelled ===
if isequal(file,0)
   
   if isempty(get(RSMethods{6}.Edit{2},'Value'))==1
   set(RSMethods{6}.Edit{2},'String',strings(1));
      return
   else
      return
   end
else
   set(RSMethods{6}.Edit{2},'String',fullfile(file),'Enable','inactive');
end

    % === Read file as table ===
    data = readtable(file);
    if size(data,2) < 2
        errordlg('File must contain two columns: Period [s] and Sa [g].', 'Invalid File');
        return;
    end

    % === Extract and sort data ===
    T_file = table2array(data(:,1))';
    Sa_file = table2array(data(:,2))';
    [T_file, idx] = sort(T_file);
    Sa_file = Sa_file(idx);

    % === Add extrapolation point if needed ===
    if max(T_file) < max(Operators.T)
        T_file(end+1) = 100;
        Sa_file(end+1) = 0;
    end

    % === Interpolate (with extrapolation defaulted to 0) ===
    Sa= interp1(T_file, Sa_file, Operators.T, 'linear', 0);
    Operators.Sa=Sa;
    set(RSAxes.p{1}, 'XData', Operators.T, 'YData', Sa);

catch ME
    % === Error management ===
    msg = sprintf('An error occurred in %s:\n\n%s', mfilename, ME.message);
    errordlg(msg, 'Execution Error');
end

end
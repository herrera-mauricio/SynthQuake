function OpenEathquake(h,e,MethodButtons,MainAxes,Save,IM,Operators)
try
set(Save.Button{3},'Enable','off');
functions.ClearAll([],[],MainAxes,MethodButtons,IM,Operators)
index=get(Operators.list,'value');

[file,~]=uigetfile({'*.txt';'*.m';'*.slx';'*.*'},'Select a file:');
if isequal(file,0)
   set(MethodButtons{index}.Edit{2},'String',strings(1));
   return
else
   set(MethodButtons{index}.Edit{2},'String',fullfile(file),'Enable','inactive');
end

H=table2array(readtable(file));

Operators.Fs=H(2);
Operators.Real_Motion=detrend(H(3:end)/H(1));

set(MethodButtons{index}.Edit{4},'string',num2str(H(2)))
set(MethodButtons{index}.Edit{6},'string','50','Enable','On')

figure(Operators.Main);

catch ME
    msg = sprintf('An error occurred in %s:\n%s', mfilename, ME.message);
    errordlg(msg, 'Execution Error');
    rethrow(ME);
end
end
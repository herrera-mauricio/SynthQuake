function CloseIF(h,e,Operators)

Cuadro=questdlg('Do you want to keep the results?', ...
    'Close', ...
    'Yes','No','Yes');
switch Cuadro
    case 'Yes'
        set(Operators.IF1,'visible','off')
        set(Operators.IF2,'visible','off')
        set(Operators.Main,'Visible','On')
    case 'No'
        Operators.ENV=nan;
        set(Operators.IF1,'visible','off')
        set(Operators.IF2,'visible','off')
        set(Operators.Main,'Visible','On')
end


end
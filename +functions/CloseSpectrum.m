function CloseSpectrum(h,e,MainAxes,Operators)

Cuadro=questdlg('Do you want to keep the results?', ...
    'Close', ...
    'Yes','No','yes');
switch Cuadro
    case 'Yes'
        set(MainAxes.pl{2,4},'XData',Operators.T,'YData',Operators.Sa)
        set(MainAxes.pl{4,4},'XData',Operators.T,'YData',0.9*Operators.Sa)
        set(MainAxes.pl{5,4},'XData',Operators.T,'YData',0.8*Operators.Sa)
    case 'No'

        % Limpiar curva principal del espectro en MainAxes 
        set(MainAxes.pl{2,4}, 'YData', nan, 'XData', nan);
        set(MainAxes.pl{4,4}, 'YData', nan, 'XData', nan);
        set(MainAxes.pl{5,4}, 'YData', nan, 'XData', nan);
end
        set(Operators.DS,'visible','off')
        set(Operators.Main,'Visible','On')

end
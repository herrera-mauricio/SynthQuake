function SaveSpectrum(h,e,MainAxes,Operators)

value=get(h,'String');
if strcmp(value,'Cancel')

% Limpiar curva principal del espectro en MainAxes (sube estas handles si no están accesibles)
set(MainAxes.pl{2,4}, 'YData', nan, 'XData', nan);  % espectro objetivo
set(MainAxes.pl{4,4}, 'YData', nan, 'XData', nan);  % espectro ajustado
set(MainAxes.pl{5,4}, 'YData', nan, 'XData', nan);  % espectro del registro real
else
set(MainAxes.pl{2,4},'XData',Operators.T,'YData',Operators.Sa)
set(MainAxes.pl{4,4},'XData',Operators.T,'YData',0.9*Operators.Sa)
set(MainAxes.pl{5,4},'XData',Operators.T,'YData',0.8*Operators.Sa)

end
set(Operators.DS,'visible','off')
set(Operators.Main,'Visible','On')
end
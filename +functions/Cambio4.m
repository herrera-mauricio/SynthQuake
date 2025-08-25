function Cambio4(h,e,RSMethods,ASNSR10,SoilType,UsageGroup,RSAxes,Table,Codes,Damping,Operators)

% Function to open Design Spectrum panel from main interface
k = isnan(Operators.ResampledReal_Motion);
if k == 1
    warndlg(['Before selecting the target Design/Response Spectrum, you must load a reference earthquake.' ...
        'Press the Load button.'],'Warning');
else
    set(Codes.List, 'Value', 1)
    functions.Cambio1(h,e,RSMethods,ASNSR10,SoilType,UsageGroup,RSAxes,Table,Codes,Damping,Operators)
    set(Operators.Main, 'Visible', 'Off')
    functions.CalcSpectrum([],[],RSMethods,ASNSR10,SoilType,UsageGroup,RSAxes,Table,Codes,Damping,Operators)
    set(Operators.DS, 'Visible', 'On')
end

end

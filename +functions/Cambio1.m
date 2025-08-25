function Cambio1(h,e,RSMethods,ASNSR10,SoilType,UsageGroup,RSAxes,Table,Codes,Damping,Operators)
index=get(Codes.List,'value');
for i=1:length(Codes.Hazard)
    set(Codes.Hazard{i},'visible','off')
end

set(Codes.Hazard{index},'visible','on')
functions.CalcSpectrum(h,e,RSMethods,ASNSR10,SoilType,UsageGroup,RSAxes,Table,Codes,Damping,Operators)
end
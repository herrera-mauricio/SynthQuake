function Cambio2(h,e,RSMethods,ASNSR10,SoilType,UsageGroup,RSAxes,Table,Codes,Damping,Operators)
index=get(RSMethods{1}.List{1},'value');
  
set(RSMethods{1}.List{2},'string',ASNSR10{index,2},'value',1)

functions.CalcSpectrum(h,e,RSMethods,ASNSR10,SoilType,UsageGroup,RSAxes,Table,Codes,Damping,Operators)
end
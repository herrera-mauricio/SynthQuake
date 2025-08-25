function Cambio6(h,e,IF,Operators)
index=get(IF.List,'value');

for i=1:length(IF.MethPanel)
    set(IF.MethPanel{i},'visible','off')
end

set(IF.MethPanel{index},'visible','on')
if length(IF.MethPanel)<6
functions.CalcIntensityFunctionGaussian(h,e,IF,Operators)
else
functions.CalcIntensityFunctionCacciola(h,e,IF,Operators)
end
end
function Cambio0(h,e,panel,MainAxes,MethodButtons,IM,Operators)
index=get(h,'value');
for i=1:length(panel)
    set(panel{i},'visible','off')
end
functions.ClearAll([],[],MainAxes,MethodButtons,IM,Operators)
set(panel{index},'visible','on')
end
function SaveIF(h,e,Operators)

value=get(h,'String');
if strcmp(value,'Cancel')
    Operators.ENV=nan;
end
set(Operators.IF1,'visible','off')
set(Operators.IF2,'visible','off')
set(Operators.Main,'Visible','On')

end
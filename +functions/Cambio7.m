function Cambio7(h,e,IF2,Axes,MethodButtons,IM,Operators)

%Función para abrir panel de Función de Intensidad desde la interfaz
%principal para el método de Ruido Gaussiano.


functions.ClearAll([],[],Axes,MethodButtons,IM,Operators)

Operators.z=0.05;


set(IF2.List,'Value',1)

set(IF2.Methods{1}.Edit{17},'Enable','on','BackgroundColor',[1 1 1],'string','50')
set(IF2.Methods{1}.Edit{5},'Enable','on','BackgroundColor',[1 1 1],'string','30')
set(IF2.Methods{1}.Edit{6},'Enable','on','BackgroundColor',[1 1 1],'string','5')
set(IF2.Methods{1}.Edit{7},'Enable','on','BackgroundColor',[1 1 1],'string','15')
set(IF2.Methods{1}.Edit{8},'Enable','inactive','BackgroundColor',[0.941 0.941 0.941])

set(IF2.Methods{2}.Edit{20},'Enable','on','BackgroundColor',[1 1 1],'string','50')
set(IF2.Methods{2}.Edit{5},'Enable','on','BackgroundColor',[1 1 1],'string','30')
set(IF2.Methods{2}.Edit{6},'Enable','on','BackgroundColor',[1 1 1],'string','5')
set(IF2.Methods{2}.Edit{7},'Enable','off','BackgroundColor',[0.941 0.941 0.941])
set(IF2.Methods{2}.Edit{8},'Enable','off','BackgroundColor',[0.941 0.941 0.941])

set(IF2.Methods{3}.Edit{23},'Enable','on','BackgroundColor',[1 1 1],'string','50')
set(IF2.Methods{3}.Edit{5},'Enable','on','BackgroundColor',[1 1 1],'string','30')
set(IF2.Methods{3}.Edit{6},'Enable','off','BackgroundColor',[0.941 0.941 0.941])
set(IF2.Methods{3}.Edit{7},'Enable','off','BackgroundColor',[0.941 0.941 0.941])
set(IF2.Methods{3}.Edit{8},'Enable','off','BackgroundColor',[0.941 0.941 0.941])

set(IF2.Methods{4}.Edit{29},'Enable','on','BackgroundColor',[1 1 1],'string','50')
set(IF2.Methods{4}.Edit{5},'Enable','on','BackgroundColor',[1 1 1],'string','30')
set(IF2.Methods{4}.Edit{6},'Enable','on','BackgroundColor',[1 1 1],'string','5')
set(IF2.Methods{4}.Edit{7},'Enable','off','BackgroundColor',[0.941 0.941 0.941])
set(IF2.Methods{4}.Edit{8},'Enable','off','BackgroundColor',[0.941 0.941 0.941])
set(IF2.Methods{4}.Edit{18},'string','0.5',...
    'enable','on','BackgroundColor',[1 1 1])

set(IF2.Methods{5}.Edit{16},'Enable','inactive','BackgroundColor',[1 1 1],'string',string(1))


functions.Cambio6(h,e,IF2,Operators)
set(Operators.Main,'Visible','Off')
functions.CalcIntensityFunctionGaussian(h,e,IF2,Operators)
set(Operators.IF2,'Visible','On')


end
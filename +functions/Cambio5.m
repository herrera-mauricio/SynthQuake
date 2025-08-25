function Cambio5(h,e,IF1,Operators)

%Función para abrir panel de Función de Intensidad desde la interfaz
%principal para el método de Cacciola.

k=isnan(Operators.ResampledReal_Motion); %get(MethodButtons{1}.Edit{2},'string'
if k==1
    warndlg(['Antes de Seleccionar la Función de Intensidad debe Cargar un sismo de referencia.' ...
        'Presione el botón Cargar.'],'Alerta');

else

set(IF1.List,'Value',1)

set(IF1.Methods{1}.Edit{17},'Enable','inactive','BackgroundColor',[0.941 0.941 0.941],'string',num2str(Operators.Fr))
set(IF1.Methods{1}.Edit{5},'string',num2str(Operators.Time(end)),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])
set(IF1.Methods{1}.Edit{6},'string',num2str(Operators.AIRM_t5),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])
set(IF1.Methods{1}.Edit{7},'string',num2str(Operators.AIRM_t95),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])
set(IF1.Methods{1}.Edit{8},'string',num2str(Operators.DsRM),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])

set(IF1.Methods{2}.Edit{20},'Enable','inactive','BackgroundColor',[0.941 0.941 0.941],'string',num2str(Operators.Fr))
set(IF1.Methods{2}.Edit{5},'string',num2str(Operators.Time(end)),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])
set(IF1.Methods{2}.Edit{6},'string',num2str(Operators.AIRM_t5),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])
set(IF1.Methods{2}.Edit{7},'string',num2str(Operators.AIRM_t95),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])
set(IF1.Methods{2}.Edit{8},'string',num2str(Operators.DsRM),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])

set(IF1.Methods{3}.Edit{23},'Enable','inactive','BackgroundColor',[0.941 0.941 0.941],'string',num2str(Operators.Fr))
set(IF1.Methods{3}.Edit{5},'string',num2str(Operators.Time(end)),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])
set(IF1.Methods{3}.Edit{6},'string',num2str(Operators.AIRM_t5),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])
set(IF1.Methods{3}.Edit{7},'string',num2str(Operators.AIRM_t95),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])
set(IF1.Methods{3}.Edit{8},'string',num2str(Operators.DsRM),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])

set(IF1.Methods{4}.Edit{29},'Enable','inactive','BackgroundColor',[0.941 0.941 0.941],'string',num2str(Operators.Fr))
set(IF1.Methods{4}.Edit{5},'string',num2str(Operators.Time(end)),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])
set(IF1.Methods{4}.Edit{6},'string',num2str(Operators.AIRM_t5),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])
set(IF1.Methods{4}.Edit{7},'string',num2str(Operators.AIRM_t95),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])
set(IF1.Methods{4}.Edit{8},'string',num2str(Operators.DsRM),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])
set(IF1.Methods{4}.Edit{18},'string',num2str(Operators.AI_RM(end)),...
    'enable','inactive','BackgroundColor',[0.941 0.941 0.941])

set(IF1.Methods{5}.Edit{17},'Enable','inactive','BackgroundColor',[0.941 0.941 0.941],'string',num2str(Operators.Fr))
set(IF1.Methods{5}.Edit{5},'string',num2str(Operators.Time(end)),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])
set(IF1.Methods{5}.Edit{6},'string',num2str(Operators.AIRM_t5),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])
set(IF1.Methods{5}.Edit{7},'string',num2str(Operators.AIRM_t95),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])
set(IF1.Methods{5}.Edit{8},'string',num2str(Operators.DsRM),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])

set(IF1.Methods{6}.Edit{14},'Enable','inactive','BackgroundColor',[0.941 0.941 0.941],'string',num2str(Operators.Fr))
set(IF1.Methods{6}.Edit{5},'string',num2str(Operators.Time(end)),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])
set(IF1.Methods{6}.Edit{6},'string',num2str(Operators.AIRM_t5),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])
set(IF1.Methods{6}.Edit{7},'string',num2str(Operators.AIRM_t95),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])
set(IF1.Methods{6}.Edit{8},'string',num2str(Operators.DsRM),'enable','inactive','BackgroundColor',[0.941 0.941 0.941])


set(IF1.ax,'XLim',[0 Operators.Time(end)])

functions.Cambio6(h,e,IF1,Operators)
set(Operators.Main,'Visible','Off')
functions.CalcIntensityFunctionCacciola(h,e,IF1,Operators)
set(Operators.IF1,'Visible','On')

end

end
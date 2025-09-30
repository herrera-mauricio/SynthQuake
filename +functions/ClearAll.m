function ClearAll(h,e,MainAxes,MethodButtons,IM,Operators)

set(MainAxes.pl{1,1},'XData',nan,'YData',nan); %Plot para el sismo o señal básica
set(MainAxes.pl{1,2},'XData',nan,'YData',nan); %Plot para la distribución de la energía de la señal básica
set(MainAxes.pl{1,3},'XData',nan,'YData',nan); %Plot para el sismo sintético obtenido
set(MainAxes.pl{1,4},'XData',nan,'YData',nan); %Plot para el espectro de respuesta del sismo o señal base
set(MainAxes.pl{2,2},'XData',nan,'YData',nan); %Plot para la distribución de la energía de la señal sintética
set(MainAxes.pl{2,4},'XData',nan,'YData',nan); %Plot para el Espectro de diseño objetivo   
set(MainAxes.pl{3,4},'XData',nan,'YData',nan); %PLot para el espectro de respuesta de la señal sintética
set(MainAxes.pl{4,4},'XData',nan,'YData',nan); %PLot para el espectro de respuesta de la señal sintética
set(MainAxes.pl{5,4},'XData',nan,'YData',nan); %PLot para el espectro de respuesta de la señal sintética
set(MainAxes.pl{1,5},'XData',nan,'YData',nan); %Plot para el Espectro de diseño objetivo   
set(MainAxes.pl{2,5},'XData',nan,'YData',nan); %PLot para el espectro de respuesta de la señal sintética
set(MainAxes.Mesh{1},'XData',nan,'YData',nan,'ZData',nan); %PLot para el espectrograma
set(MainAxes.Mesh{2},'XData',nan,'YData',nan,'ZData',nan); %PLot para el espectrograma

set(MainAxes.pl{1,8},'XData',nan,'YData',nan);
set(MainAxes.pl{1,9},'XData',nan,'YData',nan);
set(MainAxes.pl{1,10},'XData',nan,'YData',nan);
set(MainAxes.pl{2,9},'XData',nan,'YData',nan);
set(MainAxes.pl{1,11},'XData',nan,'YData',nan);
set(MainAxes.pl{1,12},'XData',nan,'YData',nan);
set(MainAxes.pl{1,13},'XData',nan,'YData',nan);
set(MainAxes.pl{2,12},'XData',nan,'YData',nan);

set(MethodButtons{1}.Edit{2},'String',strings(1));
set(MethodButtons{1}.Edit{4},'String',strings(1));
set(MethodButtons{1}.Edit{6},'String',strings(1));

set(MethodButtons{3}.Edit{2},'String',strings(1));
set(MethodButtons{3}.Edit{4},'String',strings(1));
set(MethodButtons{3}.Edit{6},'String',strings(1));

for i=13:24
    set(IM.Buttons{1}.Edit{i},'String',[])
    set(IM.Buttons{2}.Edit{i},'String',[])
end

set(IM.Buttons{3}.Edit{3},'String',[])
set(IM.Buttons{3}.Edit{4},'String',[])

        Operators.NFFT=nan; 
        Operators.Time=nan;
        Operators.Real_Motion=nan;
        Operators.ResampledReal_Motion=nan;
        Operators.T=nan;
        Operators.F=nan;
        Operators.w=nan;
        Operators.Sa=nan;
        Operators.Fr=nan;
        Operators.Fs=nan;
        Operators.AI_RM=nan;
        Operators.DsRM=nan;
        Operators.PSA_RM=nan;
        Operators.z=nan;
        Operators.Max_Iter=nan;
        Operators.TOL=nan;
        Operators.New_Motion=nan;
        Operators.PSA_NM=nan;
        Operators.Num_Iter=nan;
        Operators.R=nan;
        Operators.AI_NM=nan;
        Operators.DsNM=nan;
        Operators.AIRM_t5=nan;
        Operators.AIRM_t95=nan;
        Operators.AIRM_n5=nan;
        Operators.AIRM_n95=nan;
        Operators.ENV=nan;
        Operators.Dw=nan;
        Operators.CPSD_RM=nan;
        Operators.CPSD_NM=nan;
        Operators.SpectAmp_RM=nan;
        Operators.SpectFreq_RM=nan;
        Operators.SpectTime_RM=nan;
        Operators.SpectAmp_NM=nan;
        Operators.SpectFreq_NM=nan;
        Operators.SpectTime_NM=nan;

end
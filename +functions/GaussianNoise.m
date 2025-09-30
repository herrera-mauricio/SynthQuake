function GaussianNoise(h,e,Axes,MethodButtons,IM,Operators)

Time=Operators.Time;
Env=Operators.ENV;
n=length(Time); %número de datos del sismo sintético

noise=randn(1,n); %Ruido Gaussiano

%Función de intensidad
Motion=(((0.5-0.10)*rand(1)+0.10)/max(noise))*noise.*Env;

Operators.ResampledReal_Motion=Motion';
Operators.New_Motion=Motion;

functions.FrequencyData(h,e,Operators)

[AI_RM,AIRM_t5,AIRM_t95,AIRM_n5,AIRM_n95,DsRM]=functions.AriasIntensity(Operators.ResampledReal_Motion,Operators.Fr);
[PSA_RM,PSV_RM,PSD_RM]=functions.RSNewmark(Operators.ResampledReal_Motion,Operators.Fr,Operators.w(1:end-1),Operators.z);
[PSA_NM,PSV_NM,PSD_NM]=functions.RSNewmark(Operators.New_Motion,Operators.Fr,Operators.w(1:end-1),Operators.z);
[Operators.CPSD_RM,~]=cpsd(Operators.ResampledReal_Motion,Operators.ResampledReal_Motion,Operators.NFFT,Operators.NFFT/2,Operators.F,Operators.Fr);
[Operators.SpectAmp_RM,Operators.SpectFreq_RM,Operators.SpectTime_RM]=spectrogram(Operators.ResampledReal_Motion,128,64,128,Operators.Fr);   
[Operators.Real_Motion_Velocity,Operators.Real_Motion_Displacement]=functions.Acc_to_VelDisp(Operators.ResampledReal_Motion,Operators.Fr);

    Operators.AI_RM=AI_RM;
    Operators.AIRM_t5=AIRM_t5;
    Operators.AIRM_t95=AIRM_t95;
    Operators.AIRM_n5=AIRM_n5;
    Operators.AIRM_n95=AIRM_n95;
    Operators.DsRM=DsRM;
    Operators.PSA_RM=PSA_RM;
    Operators.PSV_RM=PSV_RM;
    Operators.PSD_RM=PSD_RM;

    Operators.PSA_NM=PSA_NM;
    Operators.PSV_NM=PSV_NM;
    Operators.PSD_NM=PSD_NM;

    Operators.PGA_RM=max(abs(Operators.ResampledReal_Motion));           %Peak Ground Acceleration [g]
    Operators.CAV_RM=max(cumtrapz(Operators.ResampledReal_Motion*981)/Operators.Fr); %Cumulative Absolute Velocity [cm/s] 
    Operators.Arms_RM=sqrt((1/(length(Operators.ResampledReal_Motion)/Operators.Fr))*max(cumtrapz((Operators.ResampledReal_Motion).^2)/Operators.Fr)); %Root-Mean Square of Acceleration [g]
    Operators.Ic_RM=(Operators.Arms_RM)^(3/2)*sqrt(length(Operators.ResampledReal_Motion)/Operators.Fr);    %Characteristic Intensity [-]
    Operators.ASI_RM=functions.CalcASI(Operators.T,Operators.PSA_RM);
    Operators.PGV_RM=max(abs(Operators.Real_Motion_Velocity));
    Operators.PGD_RM=max(abs(Operators.Real_Motion_Displacement));
    Operators.HI_RM=functions.CalcHI(Operators.T,Operators.PSV_RM);




    set(Axes.pl{1,1},'XData',Operators.Time,'YData',Operators.ResampledReal_Motion)
    set(Axes.pl{1,2},'XData',Operators.Time,'YData',Operators.AI_RM/max(Operators.AI_RM))
    set(Axes.pl{1,4},'XData',Operators.T,'YData',Operators.PSA_RM)
    set(Axes.pl{1,5},'XData',Operators.F,'YData',Operators.CPSD_RM)
    set(Axes.Mesh{1},'XData',Operators.SpectTime_RM,'YData',Operators.SpectFreq_RM,'ZData',abs(Operators.SpectAmp_RM))
    set(Axes.pl{1,8}, 'XData', Operators.Time, 'YData', Operators.Real_Motion_Velocity)
    set(Axes.pl{1,9}, 'XData', Operators.Time, 'YData', Operators.AI_RM / max(Operators.AI_RM))
    set(Axes.pl{1,11}, 'XData', Operators.Time, 'YData', Operators.Real_Motion_Displacement)
    set(Axes.pl{1,12}, 'XData', Operators.Time, 'YData', Operators.AI_RM / max(Operators.AI_RM))



set(MethodButtons{2}.Button{3},'Enable','on')
set(MethodButtons{2}.Button{4},'Enable','on')

    %Actualizar Panel IMs
    set(IM.Buttons{1}.Edit{13}, 'String', num2str(Operators.PGA_RM))
    set(IM.Buttons{1}.Edit{14}, 'String', num2str(Operators.PGV_RM))
    set(IM.Buttons{1}.Edit{15}, 'String', num2str(Operators.PGD_RM))
    set(IM.Buttons{1}.Edit{16}, 'String', num2str(Operators.CAV_RM))
    set(IM.Buttons{1}.Edit{17}, 'String', num2str(max(Operators.AI_RM)))
    set(IM.Buttons{1}.Edit{18}, 'String', num2str(max(Operators.Ic_RM)))
    set(IM.Buttons{1}.Edit{19}, 'String', num2str(max(Operators.Arms_RM)))
    set(IM.Buttons{1}.Edit{20}, 'String', num2str(max(Operators.ASI_RM)))
    set(IM.Buttons{1}.Edit{21}, 'String', num2str(max(Operators.HI_RM)))
    set(IM.Buttons{1}.Edit{22}, 'String', num2str(max(Operators.AIRM_t5)))
    set(IM.Buttons{1}.Edit{23}, 'String', num2str(max(Operators.DsRM)))
    set(IM.Buttons{1}.Edit{24}, 'String', num2str(max(Operators.AIRM_t95)))

end

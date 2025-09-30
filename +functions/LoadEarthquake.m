function LoadEarthquake(h,e,MethodButtons,MainAxes,Damping,IM,Operators)
index = get(Operators.list,'value');

if isempty(get(MethodButtons{index}.Edit{2},'string'))
    warndlg('Please select a reference earthquake file before loading.', 'Warning');
    return;
end

try
    Fr_input = str2double(get(MethodButtons{index}.Edit{6},'String'));
    Fs = Operators.Fs;

    if isempty(Fr_input) || isnan(Fr_input) || Fr_input <= 0 || Fr_input > Fs || Fr_input ~= round(Fr_input)
        warningMsg = sprintf(['Invalid resampling frequency (Fr). It must be a positive integer\n' ...
                              'less than or equal to the sampling frequency (Fs = %.2f Hz).\nDefaulting to Fs.'], Fs);
        warndlg(warningMsg, 'Validation Warning');
        Fr = Fs;
    else
        Fr = Fr_input;
    end

    Operators.Fr = Fr;

    if Fr == Fs
        Operators.ResampledReal_Motion = Operators.Real_Motion;
    else
        Operators.ResampledReal_Motion = resample(Operators.Real_Motion, Fr, Fs);
    end

    Operators.z = str2double(get(Damping.Edit{2},'string')) / 100;
    Operators.Time = 0:1/Fr:(length(Operators.ResampledReal_Motion)-1)/Fr;

    functions.FrequencyData(h,e,Operators);
    [AI_RM,AIRM_t5,AIRM_t95,AIRM_n5,AIRM_n95,DsRM] = functions.AriasIntensity(Operators.ResampledReal_Motion, Fr);
    [PSA_RM, PSV_RM, PSD_RM] = functions.RSNewmark(Operators.ResampledReal_Motion, Fr, Operators.w(1:end-1), Operators.z);
    [Operators.CPSD_RM, ~] = cpsd(Operators.ResampledReal_Motion, Operators.ResampledReal_Motion, ...
                                   Operators.NFFT, Operators.NFFT/2, Operators.F, Fr);

    [Operators.SpectAmp_RM,Operators.SpectFreq_RM,Operators.SpectTime_RM]=spectrogram(Operators.ResampledReal_Motion,128,64,128,Operators.Fr);   
    [Operators.Real_Motion_Velocity,Operators.Real_Motion_Displacement]=functions.Acc_to_VelDisp(Operators.ResampledReal_Motion,Fr);

    % Guardar resultados
    Operators.AI_RM = AI_RM;
    Operators.AIRM_t5 = AIRM_t5;
    Operators.AIRM_t95 = AIRM_t95;
    Operators.AIRM_n5 = AIRM_n5;
    Operators.AIRM_n95 = AIRM_n95;
    Operators.DsRM = DsRM;
    Operators.PSA_RM = PSA_RM;
    Operators.PSV_RM = PSV_RM;
    Operators.PSD_RM = PSD_RM;    
    
    Operators.PGA_RM=max(abs(Operators.ResampledReal_Motion));           %Peak Ground Acceleration [g]
    Operators.CAV_RM=max(cumtrapz(Operators.ResampledReal_Motion*981)/Operators.Fr); %Cumulative Absolute Velocity [cm/s] 
    Operators.Arms_RM=sqrt((1/(length(Operators.ResampledReal_Motion)/Operators.Fr))*max(cumtrapz((Operators.ResampledReal_Motion).^2)/Operators.Fr)); %Root-Mean Square of Acceleration [g]
    Operators.Ic_RM=(Operators.Arms_RM)^(3/2)*sqrt(length(Operators.ResampledReal_Motion)/Operators.Fr);    %Characteristic Intensity [-]
    Operators.ASI_RM=functions.CalcASI(Operators.T,Operators.PSA_RM);
    Operators.PGV_RM=max(abs(Operators.Real_Motion_Velocity));
    Operators.PGD_RM=max(abs(Operators.Real_Motion_Displacement));
    Operators.HI_RM=functions.CalcHI(Operators.T,Operators.PSV_RM);


    % Actualizar gráficas
    set(MainAxes.pl{1,1}, 'XData', Operators.Time, 'YData', Operators.ResampledReal_Motion)
    set(MainAxes.pl{1,2}, 'XData', Operators.Time, 'YData', Operators.AI_RM / max(Operators.AI_RM))
    set(MainAxes.pl{1,4}, 'XData', Operators.T, 'YData', Operators.PSA_RM)
    set(MainAxes.pl{1,5}, 'XData', Operators.F, 'YData', Operators.CPSD_RM)
    set(MethodButtons{index}.Edit{6}, 'String', num2str(Fr))
    set(MainAxes.Mesh{1},'XData',Operators.SpectTime_RM,'YData',Operators.SpectFreq_RM,'ZData',abs(Operators.SpectAmp_RM))
    
    set(MainAxes.pl{1,8}, 'XData', Operators.Time, 'YData', Operators.Real_Motion_Velocity)
    set(MainAxes.pl{1,9}, 'XData', Operators.Time, 'YData', Operators.AI_RM / max(Operators.AI_RM))
    set(MainAxes.pl{1,11}, 'XData', Operators.Time, 'YData', Operators.Real_Motion_Displacement)
    set(MainAxes.pl{1,12}, 'XData', Operators.Time, 'YData', Operators.AI_RM / max(Operators.AI_RM))



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
    
catch ME
    msg = sprintf('An error occurred in LoadEarthquake:\n%s', ME.message);
    errordlg(msg, 'Execution Error');
    rethrow(ME);
end

end
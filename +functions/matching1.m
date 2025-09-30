function matching1(h,e,MethodButtons,Axes,Save,IM,Operators)

i = isempty(get(MethodButtons{1}.Edit{2}, 'string'));
n = isnan(Operators.Sa);

if i == 1
    warndlg('Before running the analysis, you must browse and load a reference accelerogram.','Warning');
elseif n == 1
    warndlg('Before running the analysis, you must select a target design/response spectrum.','Warning');
else
    Operators.Max_Iter = str2double(get(MethodButtons{1}.Edit{8}, 'String'));
    Operators.TOL = str2double(get(MethodButtons{1}.Edit{10}, 'String')) / 100;

    k = isnan(Operators.Max_Iter);
    m = isnan(Operators.TOL);

    if k == 1 
        warndlg(['The entered value for the maximum number of iterations (Max. Iter.) is not valid. ', ...
                 'The value must be a positive integer greater than zero.'], 'Warning');
        New_Motion = nan(1, length(Operators.Time));
        PSA_NM = nan(1, length(Operators.T));
        Num_Iter = nan(1, 1);
        R = nan(1, 1);

    elseif m == 1
        warndlg(['The entered value for the maximum error (Max. Err.) is not valid. ', ...
                 'The value must be a positive number greater than zero.'], 'Warning');
        New_Motion = nan(1, length(Operators.Time));
        PSA_NM = nan(1, length(Operators.T));
        Num_Iter = nan(1, 1);
        R = nan(1, 1);

    elseif Operators.Max_Iter <= 0
        warndlg(['The entered value for the maximum number of iterations (Max. Iter.) is not valid. ', ...
                 'The value must be a positive integer greater than zero.'], 'Warning');
        New_Motion = nan(1, length(Operators.Time));
        PSA_NM = nan(1, length(Operators.T));
        Num_Iter = nan(1, 1);
        R = nan(1, 1);

    elseif Operators.TOL <= 0
        warndlg(['The entered value for the maximum error (Max. Err.) is not valid. ', ...
                 'The value must be a positive number greater than zero.'], 'Warning');
        New_Motion = nan(1, length(Operators.Time));
        PSA_NM = nan(1, length(Operators.T));
        Num_Iter = nan(1, 1);
        R = nan(1, 1);

    elseif Operators.Max_Iter ~= round(Operators.Max_Iter)
        warndlg(['The entered value for the maximum number of iterations (Max. Iter.) is not valid. ', ...
                 'The value must be a positive integer greater than zero.'], 'Warning');
        New_Motion = nan(1, length(Operators.Time));
        PSA_NM = nan(1, length(Operators.T));
        Num_Iter = nan(1, 1);
        R = nan(1, 1);

    elseif Operators.TOL > 1
        warndlg(['The entered value for the maximum error (Max. Err.) is larger than expected. ', ...
                 'Please review the input.'], 'Warning');
        [New_Motion, PSA_NM,PSV_NM,PSD_NM, Num_Iter, R] = functions.AlgEscalamiento( ...
            Operators.TOL, Operators.Max_Iter, Operators.ResampledReal_Motion, ...
            Operators.NFFT, Operators.Sa, Operators.PSA_RM, Operators.Fr, ...
            Operators.w, Operators.z);

    else
        [New_Motion, PSA_NM,PSV_NM,PSD_NM, Num_Iter, R] = functions.AlgEscalamiento( ...
            Operators.TOL, Operators.Max_Iter, Operators.ResampledReal_Motion, ...
            Operators.NFFT, Operators.Sa, Operators.PSA_RM, Operators.Fr, ...
            Operators.w, Operators.z);
    end

    Operators.New_Motion = New_Motion;
    Operators.PSA_NM = PSA_NM;
    Operators.PSV_NM = PSV_NM;
    Operators.PSD_NM = PSD_NM;
    Operators.Num_Iter = Num_Iter;
    Operators.R = R;

    [Operators.CPSD_NM, ~] = cpsd(Operators.New_Motion, Operators.New_Motion, ...
                                  Operators.NFFT, Operators.NFFT/2, Operators.F, Operators.Fr);

    [AI_NM, AINM_t5, AINM_t95, ~, ~, DsNM] = functions.AriasIntensity(Operators.New_Motion, Operators.Fr);
    Operators.AI_NM = AI_NM;
    Operators.AINM_t5=AINM_t5;
    Operators.AINM_t95=AINM_t95;
    Operators.DsNM = DsNM;

    [Operators.SpectAmp_NM, Operators.SpectFreq_NM, Operators.SpectTime_NM] = ...
        spectrogram(Operators.New_Motion, 128, 64, 128, Operators.Fr);
    
    [Operators.New_Motion_Velocity,Operators.New_Motion_Displacement]=functions.Acc_to_VelDisp(Operators.New_Motion,Operators.Fr);


    Operators.PGA_NM=max(abs(Operators.New_Motion));           %Peak Ground Acceleration [g]
    Operators.PGV_NM=max(abs(Operators.New_Motion_Velocity));
    Operators.PGD_NM=max(abs(Operators.New_Motion_Displacement));
    Operators.CAV_NM=max(cumtrapz(Operators.New_Motion*981)/Operators.Fr); %Cumulative Absolute Velocity [cm/s] 
    Operators.Arms_NM=sqrt((1/(length(Operators.New_Motion)/Operators.Fr))*max(cumtrapz((Operators.New_Motion).^2)/Operators.Fr)); %Root-Mean Square of Acceleration [g]
    Operators.Ic_NM=(Operators.Arms_NM)^(3/2)*sqrt(length(Operators.New_Motion)/Operators.Fr);    %Characteristic Intensity [-]
    Operators.ASI_NM=functions.CalcASI(Operators.T,Operators.PSA_NM);
    Operators.HI_NM=functions.CalcHI(Operators.T,Operators.PSV_NM);

    set(Axes.pl{1,3}, 'XData', Operators.Time, 'YData', Operators.New_Motion);
    set(Axes.pl{2,2}, 'XData', Operators.Time, 'YData', Operators.AI_NM / max(Operators.AI_NM));
    set(Axes.pl{3,4}, 'XData', Operators.T, 'YData', Operators.PSA_NM);
    set(Axes.pl{2,5}, 'XData', Operators.F, 'YData', Operators.CPSD_NM);
    set(Axes.Mesh{2}, 'XData', Operators.SpectTime_NM, ...
                      'YData', Operators.SpectFreq_NM, ...
                      'ZData', abs(Operators.SpectAmp_NM));

    set(Axes.pl{2,9},'XData',Operators.Time, 'YData', Operators.AI_NM / max(Operators.AI_NM));
    set(Axes.pl{1,10},'XData',Operators.Time, 'YData', Operators.New_Motion_Velocity);
    set(Axes.pl{2,12},'XData',Operators.Time, 'YData', Operators.AI_NM / max(Operators.AI_NM));
    set(Axes.pl{1,13},'XData',Operators.Time, 'YData', Operators.New_Motion_Displacement);


    set(Save.Button{3}, 'Enable', 'on');

    %Actualizar Panel IMs
    set(IM.Buttons{2}.Edit{13}, 'String', num2str(Operators.PGA_NM))
    set(IM.Buttons{2}.Edit{14}, 'String', num2str(Operators.PGV_NM))
    set(IM.Buttons{2}.Edit{15}, 'String', num2str(Operators.PGD_NM))
    set(IM.Buttons{2}.Edit{16}, 'String', num2str(Operators.CAV_NM))
    set(IM.Buttons{2}.Edit{17}, 'String', num2str(max(Operators.AI_NM)))
    set(IM.Buttons{2}.Edit{18}, 'String', num2str(max(Operators.Ic_NM)))
    set(IM.Buttons{2}.Edit{19}, 'String', num2str(max(Operators.Arms_NM)))
    set(IM.Buttons{2}.Edit{20}, 'String', num2str(max(Operators.ASI_NM)))
    set(IM.Buttons{2}.Edit{21}, 'String', num2str(max(Operators.HI_NM)))
    set(IM.Buttons{2}.Edit{22}, 'String', num2str(max(Operators.AINM_t5)))
    set(IM.Buttons{2}.Edit{23}, 'String', num2str(max(Operators.DsNM)))
    set(IM.Buttons{2}.Edit{24}, 'String', num2str(max(Operators.AINM_t95)))

    set(IM.Buttons{3}.Edit{3}, 'String', num2str(Operators.Num_Iter))
    set(IM.Buttons{3}.Edit{4}, 'String', num2str(Operators.R*100))


end

end

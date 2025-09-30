function ExportResults(h, e, Op)
%EXPORTRESULTSTOEXCEL Exports seismic signal processing results to an Excel or MAT file.
%
% The user selects either a .xlsx or .mat extension, and the function exports:
% 1. Time-domain accelerograms (reference and synthetic).
% 2. Pseudoacceleration response spectra.
% 3. Cross power spectral densities (CPSD).
% 4. Spectrogram matrices.
% 5. Computed intensity measures.

% Select output file and format
[file, path] = uiputfile({'*.xlsx'; '*.mat'}, 'Save Results to Excel or MAT file');
if isequal(file, 0)
    return; % Cancelled by user
end
fullPath = fullfile(path, file);
[~, baseName, ext] = fileparts(file);

%% Prepare all tables to export
% --- Sheet 1: Time Domain Data ---
Time = Op.Time';
Motion_Ref = Op.ResampledReal_Motion;
Motion_Syn = Op.New_Motion;
Energy_Ref = Op.AI_RM/max(Op.AI_RM);
Energy_Syn = Op.AI_NM/max(Op.AI_NM);

% Validar longitud de ENV
if isscalar(Op.ENV)
    Envelope = NaN(size(Time));
else
    Envelope = Op.ENV';  % asumir que tiene tamaño correcto
end

TimeData = table(Time, Motion_Ref, Motion_Syn, Envelope, Energy_Ref, Energy_Syn,...
    'VariableNames', {'Time [s]', 'Reference Accelerogram [g]', 'Synthetic Accelerogram [g]', 'Intensity Function (Envelope)','Energy Distribution - Reference','Energy Distribution - Synthetic'});

% --- Sheet 2: Spectral Data ---
Period = flip(Op.T');
PSA_RM = flip(Op.PSA_RM');
PSA_NM = flip(Op.PSA_NM');
Sa = flip(Op.Sa');
SpectralData = table(Period, PSA_RM, PSA_NM, Sa, ...
    'VariableNames', {'Period [s]', 'Response Spectrum - Reference [g]', 'Response Spectrum - Synthetic [g]', 'Design Spectrum [g]'});

% --- Sheet 3: Frequency Domain (CPSD) ---
Frequecy = Op.F';
CPSD_Ref = Op.CPSD_RM';
CPSD_Syn = Op.CPSD_NM';
CPSDData = table(Frequecy, CPSD_Ref, CPSD_Syn, ...
    'VariableNames', {'Frequency [Hz]', 'CPSD Reference [dB/Hz]', 'CPSD Synthetic [dB/Hz]'});

% --- Sheet 4: Spectrogram - Reference ---
headerNames = ["Time [s]", strcat("f = ", string(Op.SpectFreq_RM(:)), " Hz")'];
Spect_Abs = [Op.SpectTime_RM' abs(Op.SpectAmp_RM')];
Spect_RM = array2table(Spect_Abs);
Spec_Ref = renamevars(Spect_RM, 1:width(Spect_RM), headerNames);

% --- Sheet 5: Spectrogram - Synthetic ---
headerNames = ["Time [s]", strcat("f = ", string(Op.SpectFreq_NM(:)), " Hz")'];
Spect_Abs = [Op.SpectTime_NM' abs(Op.SpectAmp_NM')];
Spect_NM = array2table(Spect_Abs);
Spec_Syn = renamevars(Spect_NM, 1:width(Spect_NM), headerNames);

% --- Sheet 6: Intensity Measures ---
IM_Labels = {'PGA [g]'; 'PGV [m/s]'; 'PGD [m]'; 'CAV [cm/s]'; 'Ia [m/s]'; 'Ic [-]'; 'Arms [g]'; 'ASI [-]'; 'HI [m]'; 't5 [s]'; 'DS [s]'; 't95 [s]';'Num.Iter. [-]'; 'Max.Err. [%]'};
IM_Names = {'Peak Ground Acceleration';
            'Peak Ground Velocity';
            'Peak Ground Displacement';
            'Cumulative Absolute Velocity';
            'Arias Intensity';
            'Characteristic Intensity';
            'Root-Mean Square of Acceleration';
            'Acceleration Spectral Intensity';
            'Housner Intensity';
            'Time at 5% Arias Intensity';
            'Significant Duration';
            'Time at 95% Arias Intensity';
            'Number of iterations';
            'Error achieved in the response spectrum'};
IM_Ref = [Op.PGA_RM; Op.PGV_RM; Op.PGD_RM; Op.CAV_RM; max(Op.AI_RM); Op.Ic_RM; Op.Arms_RM; Op.ASI_RM; Op.HI_RM; Op.AIRM_t5; Op.DsRM; Op.AIRM_t95; 0; 0];
IM_Syn = [Op.PGA_NM; Op.PGV_NM; Op.PGD_NM; Op.CAV_NM; max(Op.AI_NM); Op.Ic_NM; Op.Arms_NM; Op.ASI_NM; Op.HI_NM; Op.AINM_t5; Op.DsNM; Op.AINM_t95; Op.Num_Iter; Op.R*100];
IMTable = table(IM_Labels, IM_Names, IM_Ref, IM_Syn, ...
    'VariableNames', {'IM', 'Description', 'Value Reference Accelerogram', 'Value Synthetic Accelerogram'});

%% Export based on file extension
try
    switch lower(ext)
        case '.xlsx'
            writetable(TimeData, fullPath, 'Sheet', 'Time Domain');
            writetable(SpectralData, fullPath, 'Sheet', 'Spectral Data');
            writetable(CPSDData, fullPath, 'Sheet', 'Frequency Domain');
            writetable(Spec_Ref, fullPath, 'Sheet', 'Spectrogram - Reference');
            writetable(Spec_Syn, fullPath, 'Sheet', 'Spectrogram - Synthetic');
            writetable(IMTable, fullPath, 'Sheet', 'Intensity Measures');
            msgbox(sprintf('Excel file successfully exported to:\n%s', fullPath), 'Export Complete');
        case '.mat'
            Results.TimeData.Time       = Time;
            Results.TimeData.Motion_Ref = Motion_Ref;
            Results.TimeData.Motion_Syn = Motion_Syn;
            Results.TimeData.Envelope   = Envelope;
            Results.TimeData.Energy_Ref = Energy_Ref;
            Results.TimeData.Energy_Syn = Energy_Syn;

            Results.Spectral.Period  = Period;
            Results.Spectral.PSA_Ref  = PSA_RM;
            Results.Spectral.PSA_Syn  = PSA_NM;
            Results.Spectral.Sa      = Sa;

            Results.PowerSpectrum.Frequencies = Frequecy;
            Results.PowerSpectrum.CPSD_Ref    = CPSD_Ref;
            Results.PowerSpectrum.CPSD_Syn    = CPSD_Syn;

            Results.Spectrograms.Ref.Amplitude = abs(Op.SpectAmp_RM);
            Results.Spectrograms.Ref.Frequency = Op.SpectFreq_RM;
            Results.Spectrograms.Ref.Time      = Op.SpectTime_RM;

            Results.Spectrograms.Syn.Amplitude = abs(Op.SpectAmp_NM);
            Results.Spectrograms.Syn.Frequency = Op.SpectFreq_NM;
            Results.Spectrograms.Syn.Time      = Op.SpectTime_NM;

            Results.IM.Labels = IM_Labels;
            Results.IM.Names  = IM_Names;
            Results.IM.Ref    = IM_Ref;
            Results.IM.Syn    = IM_Syn;

            save(fullPath, '-struct', 'Results');
            msgbox(sprintf('MAT file successfully exported to:\n%s', fullPath), 'Export Complete');
        otherwise
            error('Unsupported file extension: %s', ext);
    end
catch ME
    msg = sprintf('An error occurred in %s:\n%s', mfilename, ME.message);
    errordlg(msg, 'Execution Error');
    rethrow(ME);
end

end

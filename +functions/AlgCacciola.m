function [New_Motion, PSA_NM, Num_Iter, R] = AlgCacciola(TOL, Max_Iter, Time, Real_Motion, Env, NFFT, Sa, PSA_RM, Fr, w, Dw, z, DsRM)
% According to Cacciola, 2010.

R = 1;
Num_Iter = 0;
phi = 2 * pi * rand(1, NFFT);
Gu = functions.AprxPowerSprctrum(NFFT, w, Dw, z, Sa, PSA_RM, DsRM);
CorFunction = ones(1, NFFT); % inicial

while R > TOL
    Num_Iter = Num_Iter + 1;

    % Generar el ruido correctivo con la PSD actual
    Noise = functions.Harmonics(NFFT, Gu, CorFunction, w, Dw, Time, phi);

    % Construir señal sintética
    Cor_Motion = Env .* Noise;
    a = min(Sa ./ (PSA_RM + eps));  % escala según el espectro real
    New_Motion = a * Real_Motion + Cor_Motion';

    % Calcular nuevo espectro de respuesta
    [PSA_NM, ~, ~] = functions.RSNewmark(New_Motion, Fr, w(1:end-1), z);

    % Validar dimensión
    if length(PSA_NM) ~= length(Sa)
        error('Mismatch in vector length: PSA_NM (%d) vs Sa (%d)', length(PSA_NM), length(Sa));
    end

    % Calcular error relativo
    R = norm(Sa - PSA_NM) / norm(Sa);

    % === ACTUALIZACIÓN DE LA PSD CORRECTIVA (ECUACIÓN 26) ===
    Ratio = (Sa ./ (PSA_NM + eps)).^2;
    Ratio(~isfinite(Ratio)) = 1;
    Gu = Gu .* Ratio;  % actualización por retroalimentación

    % Evitar valores extremos
    Gu(Gu < 0) = 0;
    Gu(~isfinite(Gu)) = 0;

    % Limitar número de iteraciones
    if Num_Iter >= Max_Iter
        warning('AlgCacciola: maximum iterations reached (R = %.4f)', R);
        break
    end
end
end
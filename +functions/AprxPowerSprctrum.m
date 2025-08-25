function Gu = AprxPowerSprctrum(NFFT, w, Dw, z, Sa, PSA_prev, DsRM, Gu_prev)

% Parámetros espectrales
p = 0.5;
dU = sqrt(1 - (1/(1 - z^2))*(1 - 2/pi * atan(z/sqrt(1 - z^2))));
NU = DsRM / (2*pi) .* w * (-log(p))^-1;
nU = sqrt(2 * log(2 * NU .* (1 - exp(-dU^1.2 * sqrt(pi * log(2 * NU))))));

% Escalamiento del sismo real
a = min(Sa ./ PSA_prev);

% Si es primera iteración
if nargin < 8
    Gu = zeros(1, NFFT);
    wl = 1;
    for i = 1:NFFT
        if w(i) <= wl
            Gu(i) = 0;
        else
            delta = (Sa(i)^2 - a^2 * PSA_prev(i)^2)/nU(i)^2 - Dw * sum(Gu(1:i-1));
            Gu(i) = (4*z)/(pi*w(i) - 4*z*w(i-1)) * functions.UnitStep(delta) * delta;
        end
    end
else
    % Retroalimentación
    Ratio = (Sa ./ (PSA_prev + eps)).^2;
    Ratio(~isfinite(Ratio)) = 1;
    Gu = Gu_prev .* Ratio;
end

end
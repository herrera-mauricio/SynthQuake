function [vg, ug]=Acc_to_VelDisp(ag,fs)

    % Convierte aceleración [g] a velocidad [m/s]
    ceros=zeros(10000,1);
    ag_g = [ceros;ag(:);ceros];
    N = numel(ag_g);
    Ts = 1/fs;
    g0 = 9.80665;
    ag_si = detrend(ag_g * g0, 'linear');

    % Parámetros intrínsecos
    Tn   = 100000;
    zeta = 1;
    wn   = 2*pi*(1/Tn);

    % Espacio de estados
    A = [0 1; -wn^2 -2*zeta*wn];
    B = [0; -1];
    C = [1, 0;   % u
         0, 1];  % v
    D = [0; 0];

    % Simulación
    t = (0:N-1).' * Ts;
    sys = ss(A,B,C,D);
    y_state = lsim(sys, ag_si, t, [0;0]);

    % Recuperar desplazamiento y velocidad del terreno (cambio de signo)
    ug = detrend(-y_state(length(ceros)+1:end-length(ceros),1),10);
    vg = detrend(-y_state(length(ceros)+1:end-length(ceros),2),10);

    % Mantener orientación original
    if isrow(ag_g)
        vg = vg.';
        ug = ug.';
    end


end
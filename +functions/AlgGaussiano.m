function [New_Motion,PSA_NM,Num_Iter,R]=AlgGaussiano(TOL,Max_Iter,Operators)


New_Motion=Operators.New_Motion;
NFFT=Operators.NFFT;
Sa=Operators.Sa;
PSA_NM=Operators.PSA_NM;
Fr=Operators.Fr;
w=Operators.w;
z=Operators.z;

Num_Iter=0;
R=1;
while R>TOL

% Recálculo de la FFT para el ajuste de la señal sísmica
y=fft(New_Motion,NFFT);
Y=y(1:NFFT/2); %Amplitudes de Fourier


Num_Iter=Num_Iter+1;

% Función de Correlación
CorFunction1=Sa./PSA_NM; % Relación (Espectro de Diseño / Espectro de Respuesta)
R=norm(Sa-PSA_NM)/norm(Sa);

YY=Y.*[1 CorFunction1(2:end)];
New_Motion=detrend(ifft(YY,NFFT,'symmetric'));

% Recálculo del Espectro de Respuesta para el ajuste de la señal sísmica
[PSA_NM,~,~]=functions.RSNewmark(New_Motion,Fr,w(1:end-1),z);%Espectro de Respuesta en Pseudo-Acelereación

% Finalización del bucle while con un máximo de iteraciones
if Num_Iter==Max_Iter
    break
end


end

end
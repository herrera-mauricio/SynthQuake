function FrequencyData(h,e,Operators)

index=get(Operators.list,'value');

if index==3
Operators.NFFT=length(Operators.ResampledReal_Motion);
Operators.Dw=2*pi/(Operators.NFFT-1)/(1/Operators.Fr);
Operators.w=Operators.Dw:Operators.Dw:(Operators.NFFT-1)*Operators.Dw;
Operators.w=[Operators.w Inf];
Operators.T=2*pi./Operators.w;
F=1./Operators.T;
Operators.F=F(1:(Operators.NFFT-1)/2);
else
    Operators.NFFT=length(Operators.ResampledReal_Motion); %Número de puntos de la FFT
    Operators.F=linspace(0,Operators.Fr/2,Operators.NFFT/2-1); %Vector de frecuencia
    Operators.w=[2*pi*Operators.F Inf];
    Operators.T=2*pi./Operators.w;
end


end
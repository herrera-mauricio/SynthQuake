function Sa=EspectroColombiaNSR10(Aa,Av,SoilType,UsageGroup,w)

switch SoilType
    case 'Soil A'
Aux_Fa=[0.80 0.80 0.80 0.80 0.80 0.80];
Aux_Fv=[0.80 0.80 0.80 0.80 0.80 0.80];
    case 'Soil B'
Aux_Fa=[1.00 1.00 1.00 1.00 1.00 1.00];
Aux_Fv=[1.00 1.00 1.00 1.00 1.00 1.00];
    case 'Soil C'
Aux_Fa=[1.20 1.20 1.20 1.10 1.00 1.00];
Aux_Fv=[1.70 1.70 1.60 1.50 1.40 1.30];
    case 'Soil D'
Aux_Fa=[1.60 1.60 1.40 1.20 1.10 1.00];
Aux_Fv=[2.40 2.40 2.00 1.80 1.60 1.50];
    case 'Soil E'
Aux_Fa=[2.50 2.50 1.70 1.20 0.90 0.90];
Aux_Fv=[3.50 3.50 3.20 2.80 2.40 2.40];
end

Aux_AaAv=[0.0 0.1 0.2 0.3 0.4 0.5];

switch UsageGroup
    case 'Group I'
        I=1.00;
    case 'Group II'
        I=1.10;
    case 'Group III'
        I=1.25;
    case 'Group IV'
        I=1.50;
end
            
Fa=interp1(Aux_AaAv,Aux_Fa,Aa);
Fv=interp1(Aux_AaAv,Aux_Fv,Av);

T0=0.10*Av*Fv/Aa/Fa;
TC=0.48*Av*Fv/Aa/Fa;
TL=2.4*Fv;
w0=2*pi/T0;
wC=2*pi/TC;
wL=2*pi/TL;
Sa=zeros(1,length(w));
%Espectro de Diseño en Frecuecia
    for j=1:length(w)   
        if w(j)<=wL
            Sa(j)=1.2*Av*Fv*TL*I./((2*pi./w(j)).^2);            
        elseif (w(j)>wL) && (w(j)<=wC)
            Sa(j)=1.2*Av*Fv*I./(2*pi./w(j));            
        elseif (w(j)>wC) && (w(j)<=w0)
            Sa(j)=2.5*Aa*Fa*I;
        elseif w(j)==Inf
            Sa(j)=Aa*Fa*I;
        else 
            Sa(j)=2.5*Aa*Fa*I*(0.4+(0.6/T0).*(2*pi./w(j)));
        end
    end

end
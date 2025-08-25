function Sa=EspectroColombiaCali(MicroZone,UsageGroup,w)
%According to Decreto 411.0.20.0158 (Alcaldía de Santiago de Cali, 2014)

Aa=0.25;
Av=0.25;

switch MicroZone
    case 'Zone 1'
        TC=0.55; Fa=0.86; TL=3.00; Fv=0.99;
        T0=0.10*Av*Fv/Aa/Fa;
    case 'Zone 2'
        TC=0.45; Fa=1.20; TL=3.00; Fv=1.13;
        T0=0.10*Av*Fv/Aa/Fa;
    case 'Zone 3'
        TC=1.05; Fa=1.36; TL=2.00; Fv=2.98;
        T0=0.10*Av*Fv/Aa/Fa;
    case 'Zone 4A'
        TC=0.75; Fa=1.20; TL=2.00; Fv=1.88;
        T0=0.10*Av*Fv/Aa/Fa;
    case 'Zone 4B'
        TC1=0.70; Fa1=1.04; TL1=2.50; Fv1=1.52;
        T01=0.10*Av*Fv1/Aa/Fa1;
        TC2=1.60; Fa2=0.80; TL2=2.50; Fv2=2.67;
        T02=0.10*Av*Fv2/Aa/Fa2;
    case 'Zone 4C'
        TC1=0.45; Fa1=1.60; TL1=2.00; Fv1=1.50;
        T01=0.10*Av*Fv1/Aa/Fa1;
        TC2=1.50; Fa2=1.04; TL2=2.10; Fv2=3.25;
        T02=0.10*Av*Fv2/Aa/Fa2;
    case 'Zone 4D'
        TC=1.20; Fa=0.99; TL=2.00; Fv=2.48;
        T0=0.10*Av*Fv/Aa/Fa;
    case 'Zone 4E'
        TC=0.95; Fa=0.91; TL=3.00; Fv=1.81;
        T0=0.10*Av*Fv/Aa/Fa;
    case 'Zone 5'
        TC1=0.60; Fa1=1.12; TL1=2.50; Fv1=1.40;
        T01=0.10*Av*Fv1/Aa/Fa1;
        TC2=1.35; Fa2=0.83; TL2=2.50; Fv2=2.34;
        T02=0.10*Av*Fv2/Aa/Fa2;
    case 'Zone 6'
        TC=1.15; Fa=1.09; TL=2.50; Fv=2.61;
        T0=0.10*Av*Fv/Aa/Fa;
end  

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

Sa=zeros(1,length(w));
Sa1=zeros(1,length(w));
Sa2=zeros(1,length(w));

if strcmp(MicroZone,'Zone 4B') | strcmp(MicroZone,'Zone 4C') | strcmp(MicroZone,'Zone 5')
%Espectro de Diseño en Frecuecia
w01=2*pi/T01;
wC1=2*pi/TC1;
wL1=2*pi/TL1;
w02=2*pi/T02;
wC2=2*pi/TC2;
wL2=2*pi/TL2;

    for j=1:length(w)   
        if w(j)<=wL1
            Sa1(j)=1.2*Av*Fv1*TL1*I./((2*pi./w(j)).^2);            
        elseif (w(j)>wL1) && (w(j)<=wC1)
            Sa1(j)=1.2*Av*Fv1*I./(2*pi./w(j));            
        elseif (w(j)>wC1) && (w(j)<=w01)
            Sa1(j)=2.5*Aa*Fa1*I;
        elseif w(j)==Inf
            Sa1(j)=Aa*Fa1*I;
        else 
            Sa1(j)=2.5*Aa*Fa1*I*(0.4+(0.6/T01).*(2*pi./w(j)));
        end
        
        if w(j)<=wL2
            Sa2(j)=1.2*Av*Fv2*TL1*I./((2*pi./w(j)).^2);            
        elseif (w(j)>wL2) && (w(j)<=wC2)
            Sa2(j)=1.2*Av*Fv2*I./(2*pi./w(j));            
        elseif (w(j)>wC2) && (w(j)<=w02)
            Sa2(j)=2.5*Aa*Fa2*I;
        elseif w(j)==Inf
            Sa2(j)=Aa*Fa2*I;
        else 
            Sa2(j)=2.5*Aa*Fa2*I*(0.4+(0.6/T02).*(2*pi./w(j)));
        end
        Sa(j)=max(Sa1(j),Sa2(j));
    end

else 
w0=2*pi/T0;
wC=2*pi/TC;
wL=2*pi/TL;
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
end
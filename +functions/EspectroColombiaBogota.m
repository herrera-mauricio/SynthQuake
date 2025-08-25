function Sa=EspectroColombiaBogota(MicroZone,UsageGroup,w)

Aa=0.15;
Av=0.20;

switch MicroZone
    case 'CERROS'
        TC=0.62; Fa=1.35; TL=3.00; Fv=1.30; A0=0.18;
    case 'PIEDEMONTE A'
        TC=0.78; Fa=1.65; TL=3.00; Fv=2.00; A0=0.22;
    case 'PIEDEMONTE B'
        TC=0.56; Fa=1.95; TL=3.00; Fv=1.70; A0=0.26;
    case 'PIEDEMONTE C'
        TC=0.60; Fa=1.80; TL=3.00; Fv=1.70; A0=0.24;
    case 'LACUSTRE-50'
        TC=1.33; Fa=1.40; TL=4.00; Fv=2.60; A0=0.21;
    case 'LACUSTRE-100'
        TC=1.58; Fa=1.30; TL=4.00; Fv=3.20; A0=0.20;
    case 'LACUSTRE-200'
        TC=1.87; Fa=1.20; TL=4.00; Fv=3.50; A0=0.18;
    case 'LACUSTRE-300'
        TC=1.77; Fa=1.05; TL=5.00; Fv=2.90; A0=0.16;
    case 'LACUSTRE-500'
        TC=1.82; Fa=0.95; TL=5.00; Fv=2.70; A0=0.14;
    case 'LACUSTRE ALUVIAL-200'
        TC=1.63; Fa=1.10; TL=4.00; Fv=2.80; A0=0.17;
    case 'LACUSTRE ALUVIAL-300'
        TC=1.60; Fa=1.00; TL=5.00; Fv=2.50; A0=0.15;
    case 'ALUVIAL-50'
        TC=0.85; Fa=1.35; TL=3.50; Fv=1.80; A0=0.20;
    case 'ALUVIAL-100'
        TC=1.12; Fa=1.20; TL=3.50; Fv=2.10; A0=0.18;
    case 'ALUVIAL-200'
        TC=1.28; Fa=1.05; TL=3.50; Fv=2.10; A0=0.16;
    case 'ALUVIAL-300'
        TC=1.41; Fa=0.95; TL=3.50; Fv=2.10; A0=0.14;
    case 'DEPOSITO LADERA'
        TC=0.66; Fa=1.65; TL=3.00; Fv=1.70; A0=0.22;
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
T0=0.10*Av*Fv/Aa/Fa;
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
            Sa(j)=A0;
        else 
            Sa(j)=2.5*Aa*Fa*I*(0.4+(0.6/T0).*(2*pi./w(j)));
        end
    end
end
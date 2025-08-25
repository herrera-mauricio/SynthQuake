function Sa=EspectroEuro8(SoilType,SpectrumType,UsageGroup,agr,w)
%According to Eurocode 8: Part 1
z=5/100;

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


switch SpectrumType
    case 1
    switch SoilType
        case 'Soil A'
            S=1.0; TB=0.15; TC=0.40; TD=2.00;
        case 'Soil B'
            S=1.20 ;TB=0.15; TC=0.50; TD=2.00;
        case 'Soil C'
            S=1.15; TB=0.20; TC=0.60; TD=2.00;
        case 'Soil D'
            S=1.35; TB=0.20; TC=0.80; TD=2.00;
        case 'Soil E'
            S=1.40; TB=0.15; TC=0.50; TD=2.00;
    end
        case 2
    switch SoilType
        case 'Soil A'
            S=1.0; TB=0.05; TC=0.25; TD=1.20;
        case 'Soil B'
            S=1.35; TB=0.05; TC=0.25; TD=1.20;
        case 'Soil C'
            S=1.50; TB=0.10; TC=0.60; TD=1.20;
        case 'Soil D'
            S=1.80; TB=0.10; TC=0.30; TD=1.20;
        case 'Soil E'
            S=1.60; TB=0.15; TC=0.50; TD=2.00;
    end
end
    
ag=I*agr;
etha=max(sqrt(10/(5+100*z)),0.55);
wB=2*pi/TB;
wC=2*pi/TC;
wD=2*pi/TD;

Sa=zeros(1,length(w));
%Espectro de Diseño en Frecuecia
    for j=1:length(w)   
        if w(j)<=wD
            Sa(j)=ag*S*etha*2.5*TC*TD./((2*pi./w(j)).^2);            
        elseif (w(j)>wD) && (w(j)<=wC)
            Sa(j)=ag*S*etha*2.5*TC./(2*pi./w(j));            
        elseif (w(j)>wC) && (w(j)<=wB)
            Sa(j)=ag*S*etha*2.5;
        else 
            Sa(j)=ag*S*(1+(2*pi./w(j))/TB*(etha*2.5-1));
        end
    end
end       
function Sa=EspectroChileNormal(Zone,SoilType,UsageCategory,w)
%According to NCh433 (Norma Chilena Modificada, 2012) and DS61(Ministerio de Vivienda y Urbanismo, 2011)

switch Zone
    case 1
        A0=0.2;
    case 2
        A0=0.3;
    case 3
        A0=0.4;
end

switch SoilType
    case 'Soil A'
        S=0.9;
        T0=0.15;
        p=2;
    case 'Soil B'
        S=1;
        T0=0.3;
        p=1.5;
    case 'Soil C'
        S=1.05;
        T0=0.4;
        p=1.6;
    case 'Soil D'
        S=1.2;
        T0=0.75;
        p=1;
    case 'Soil E'
        S=1.3;
        T0=1.2;
        p=1;
end

switch UsageCategory
    case 'Group I'
        I=0.6;
    case 'Group II'
        I=1.0;
    case 'Group III'
        I=1.2;
    case 'Group IV'
        I=1.2;
end

alpha=zeros(1,length(w));

for i=1:length(w)
if w(i)==0
    alpha(i)=1;
else
alpha(i)=(1+4.5*((2*pi/w(i))/T0)^p)/(1+((2*pi/w(i))/T0)^3);
end
end

Sa=S*A0*I.*alpha;
end
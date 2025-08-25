function [AI,t5,t95,n5,n95,Ds,t1,n1]=AriasIntensity(Motion,Fs)

g=9.81; %gravedad en m/s

AI=pi/(2*g)*(cumtrapz((Motion*g).^2))/Fs; % Intensidad de Arias
Time=0:1/Fs:(length(Motion)-1)*1/Fs;

    con1=AI>=0.05*max(AI);
    con2=AI<=0.95*max(AI);
    con3=AI>=0.005*max(AI);
    to1=Time(con1);
    tf1=Time(con2);
    too=Time(con3);
    t1=too(1);
    t5=to1(1);
    t95=tf1(end);
    [~,n1]=find(Time==t1);
    [~,n5]=find(Time==t5);
    [~,n95]=find(Time==t95);
    
    Ds=t95-t5;
end
function ExStafford(h,e,IF,Operators)

Time=Operators.Time;
t5=Operators.AIRM_t5;
Ia=str2double(get(IF.Methods{4}.Edit{18},'string'));
Mw=str2double(get(IF.Methods{4}.Edit{19},'string'));
Rrup=str2double(get(IF.Methods{4}.Edit{20},'string'));
Vs30=str2double(get(IF.Methods{4}.Edit{21},'string'));
Ztor=str2double(get(IF.Methods{4}.Edit{22},'string'));

g=9.81;
b=[-6.0391 1.0895 1.8415 -0.2065 5.7575 -0.1383 -0.0239];
c=[0.3151 -0.003 -0.0957 -0.0104];


try

%Función de intensidad o envolvente propuesta por 
% P.J. Stafford, S. Sgobba, and G.C. Marano (2009)


m=b(1)+b(2)*Mw+(b(3)+b(4)*Mw)*log(sqrt(Rrup^2+b(5)^2))+b(6)*log(Vs30)+b(7)*Ztor;
s=exp(c(1)+c(2)*Rrup+c(3)*log(Vs30)+c(4)*Ztor);

    for i=1:length(Time)
        if Time(i)<=t5
            Phi(i)=0;
        elseif Time(i)>t5
            Phi(i)=sqrt((4*g*Ia)/((Time(i)-t5)*s*pi*sqrt(2*pi))*exp(-(log(Time(i)-t5)-m).^2./(2*s^2)));
        end
    end
    
Env=Phi/max(Phi);

a0=1/max(Phi);
Env=a0.*Phi;

Operators.ENV=Env;



catch ME

    msg = sprintf('An error occurred in %s:\n%s', mfilename, ME.message);
    errordlg(msg, 'Execution Error');
    rethrow(ME);

end
end
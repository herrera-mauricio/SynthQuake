function ExLiu(h,e,IF,Operators)

Time=Operators.Time;
t5=Operators.AIRM_t5;
a=str2double(get(IF.Methods{2}.Edit{15},'string'));
b=str2double(get(IF.Methods{2}.Edit{16},'string'));

try

    if a==b
  errordlg('Los valores ingresados para α y β no pueden ser iguales.','Alerta')
    elseif a<0 || b<0
  errordlg('Los valores ingresados para α y β no pueden ser negativos.','Alerta')
    elseif a>b
  errordlg('El valor ingresados para α no puede ser mayor que β.','Alerta')
    else

        for i=1:length(Time) 
            if Time(i)<t5
                Phi(i)=0;
            else
                Phi(i)=exp(-a*(Time(i)-t5))-exp(-b*(Time(i)-t5));
            end
        end
a0=1/max(Phi);
Env=a0.*Phi;

Operators.ENV=Env;

    end
catch ME

    msg = sprintf('An error occurred in %s:\n%s', mfilename, ME.message);
    errordlg(msg, 'Execution Error');
    rethrow(ME);

end
end
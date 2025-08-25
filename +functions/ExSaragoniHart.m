function ExSaragoniHart(h,e,IF,Operators)

Time=Operators.Time;
a=str2double(get(IF.Methods{3}.Edit{16},'string'));
b=str2double(get(IF.Methods{3}.Edit{17},'string'));
c=str2double(get(IF.Methods{3}.Edit{18},'string'));


try

    if a<0 || b<0 || c<0
        errordlg('Los valores ingresados para α, β o γ no pueden ser negativos.','Alerta')
    else
        Phi=a*Time.^(b-1).*exp(-c*Time);
        a0=1/max(Phi);
        
        Env=a0.*Phi;

        Operators.ENV=Env;
    end

catch ME

    msg = sprintf('An error occurred in %s:\n%s', mfilename, ME.message);
    errordlg(msg, 'Execution Error');
    rethrow(ME);

end
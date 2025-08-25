function ExLi1(h,e,IF,Operators)

ResampledReal_Motion=Operators.ResampledReal_Motion;
n=str2double(get(IF.Methods{5}.Edit{14},'string'));


try

    if n<0
        errordlg('The value entered for n cannot be negative.','Warning')
    else
        input=ResampledReal_Motion.^2;
        Phi=functions.smuth_sig(input,n)';
        a0=1/max(Phi);
        
        Env=a0.*Phi;

        Operators.ENV=Env;
    end

catch ME

    msg = sprintf('An error occurred in %s:\n%s', mfilename, ME.message);
    errordlg(msg, 'Execution Error');
    rethrow(ME);

end
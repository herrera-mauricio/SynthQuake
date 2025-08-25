function ExLi2(h,e,IF,Operators)

ResampledReal_Motion=Operators.ResampledReal_Motion;
Time=Operators.Time;

try
        input=ResampledReal_Motion.^2;
        Phi=functions.acc_envelope(input,Time)';
        a0=1/max(Phi);
        
        Env=a0.*Phi;

        Operators.ENV=Env;

catch ME

    msg = sprintf('An error occurred in %s:\n%s', mfilename, ME.message);
    errordlg(msg, 'Execution Error');
    rethrow(ME);

end
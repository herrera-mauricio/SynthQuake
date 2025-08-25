function ExJennings(h,e,IF,Operators)

Time=Operators.Time;
t5RM=Operators.AIRM_t5;
DsRM=Operators.DsRM;
[~,~,~,~,~,~,t1,~]=functions.AriasIntensity(Operators.ResampledReal_Motion,Operators.Fr);

b=str2double(get(IF.Methods{1}.Edit{14},'string'));

try

%Función de intensidad o envolvente (Piece-wise) propuesta por Jennings et
%al.,(1968)
T95RM=t5RM+DsRM;
i=1;
while i<=length(Time)
   if Time(i)>=0 && Time(i)<t1
        Env(i)=0;
   elseif Time(i)>=t1 && Time(i)<=t5RM
        Env(i)=((Time(i)-t1)/t5RM)^2;
    elseif Time(i)>t5RM && Time(i)<=T95RM
        Env(i)=1.0;
    elseif Time(i)>T95RM && Time(i)<=Time(end)
        Env(i)=exp(-b*(Time(i)-T95RM));
    end
    i=i+1;
end

Operators.ENV=Env;

catch

    msg = sprintf('An error occurred in %s:\n%s', mfilename, ME.message);
    errordlg(msg, 'Execution Error');
    rethrow(ME);
end
end
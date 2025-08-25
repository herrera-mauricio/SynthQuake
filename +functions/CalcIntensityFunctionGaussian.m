function CalcIntensityFunctionGaussian(h,e,IF,Operators)

index=get(IF.List,'value');

try

    if index==1
Operators.Fr=str2double(get(IF.Methods{1}.Edit{17},'string'));
Operators.Time=0:1/Operators.Fr:str2double(get(IF.Methods{1}.Edit{5},'string'));
set(IF.ax,'XLim',[0 Operators.Time(end)])
Operators.AIRM_t5=str2double(get(IF.Methods{1}.Edit{6},'string'));
Operators.AIRM_t95=str2double(get(IF.Methods{1}.Edit{7},'string'));
Operators.DsRM=Operators.AIRM_t95-Operators.AIRM_t5;
set(IF.Methods{1}.Edit{8},'string',num2str(Operators.DsRM));
functions.ExJennings(h,e,IF,Operators)
[~,~,t95,~,~,Ds]=functions.AriasIntensity(Operators.ENV,Operators.Fr);
set(IF.Methods{1}.Edit{7},'string',num2str(t95))
set(IF.Methods{1}.Edit{8},'string',num2str(Ds))

    elseif index==2
Operators.Fr=str2double(get(IF.Methods{2}.Edit{20},'string'));
Operators.Time=0:1/Operators.Fr:str2double(get(IF.Methods{2}.Edit{5},'string'));
Operators.AIRM_t5=str2double(get(IF.Methods{2}.Edit{6},'string'));
set(IF.ax,'XLim',[0 Operators.Time(end)])
functions.ExLiu(h,e,IF,Operators)
[~,~,t95,~,~,Ds]=functions.AriasIntensity(Operators.ENV,Operators.Fr);
set(IF.Methods{2}.Edit{7},'string',num2str(t95))
set(IF.Methods{2}.Edit{8},'string',num2str(Ds))

    elseif index==3
Operators.Fr=str2double(get(IF.Methods{3}.Edit{23},'string'));
Operators.Time=0:1/Operators.Fr:str2double(get(IF.Methods{3}.Edit{5},'string'));
set(IF.ax,'XLim',[0 Operators.Time(end)])
functions.ExSaragoniHart(h,e,IF,Operators)
[~,t5,t95,~,~,Ds]=functions.AriasIntensity(Operators.ENV,Operators.Fr);
set(IF.Methods{3}.Edit{6},'string',num2str(t5))
set(IF.Methods{3}.Edit{7},'string',num2str(t95))
set(IF.Methods{3}.Edit{8},'string',num2str(Ds))

    elseif index==4
Operators.Fr=str2double(get(IF.Methods{4}.Edit{29},'string'));
Operators.Time=0:1/Operators.Fr:str2double(get(IF.Methods{4}.Edit{5},'string'));
Operators.AIRM_t5=str2double(get(IF.Methods{4}.Edit{6},'string'));
set(IF.ax,'XLim',[0 Operators.Time(end)])
functions.ExStafford(h,e,IF,Operators)
[~,~,t95,~,~,Ds]=functions.AriasIntensity(Operators.ENV,Operators.Fr);
set(IF.Methods{4}.Edit{7},'string',num2str(t95))
set(IF.Methods{4}.Edit{8},'string',num2str(Ds))

    elseif index==5
        functions.OpenIntensityFunction(h,e,IF,Operators)
set(IF.ax,'XLim',[0 Operators.Time(end)])
[~,t5,t95,~,~,Ds]=functions.AriasIntensity(Operators.ENV,Operators.Fr);
set(IF.Methods{5}.Edit{14},'string',num2str(Operators.Fr))
set(IF.Methods{5}.Edit{5},'string',num2str(Operators.Time(end)))
set(IF.Methods{5}.Edit{6},'string',num2str(t5))
set(IF.Methods{5}.Edit{7},'string',num2str(t95))
set(IF.Methods{5}.Edit{8},'string',num2str(Ds))

    end

set(IF.p{2},'XData',Operators.Time,'YData',Operators.ENV)
set(IF.p{1},'XData',Operators.Time,'YData',Operators.ResampledReal_Motion/max(Operators.ResampledReal_Motion))
figure(Operators.IF2);
catch ME
    
    msg = sprintf('An error occurred in %s:\n%s', mfilename, ME.message);
    errordlg(msg, 'Execution Error');
    rethrow(ME);
    
end

end
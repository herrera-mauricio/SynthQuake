clc, close all, clear all; %#ok<CLALL>
Op = Operators;
warning off
iconPath = 'G:\Mi unidad\Univalle\4. Nueva Maestría\1 - Tesis\Código\SynthQuake/SQ_icon.png'; % Reemplaza con la ruta a tu archivo de icono

% === MAIN UI FIGURE ===
Op.Main = uifigure('Units','normalized','Position',[0.1 0.1 0.8 0.8],'NumberTitle','off','Name','SynthQuake',...
    'toolbar','none','CloseRequestFcn',@(h,e)functions.MainCancel(h,e,Op),'Icon',iconPath);

% === METHOD SELECTION PANEL ===
Op.ListPanel = uipanel('Parent',Op.Main,'Units','normalized','Position',[0 0.9 0.2 0.1],'Title','Signal Generation Methods','BorderType','none');
Op.Methods = {'Recorded Input – Direct Use of Accelerogram', ...
    'Stochastic Input – Gaussian White Noise', ...
    'Cacciola Method – Stochastic Spectral Correction (2010)'};

Op.list = uicontrol('Parent',Op.ListPanel,'Style','popupmenu','Units','normalized','OuterPosition',[0.05 0.2 0.9 0.6],...
    'String',Op.Methods);

% === INPUT PANELS FOR EACH METHOD ===
for i = length(Op.Methods):-1:1
    MethodPanel{i} = uipanel('Parent',Op.Main,'Units','normalized','Position',[0 0.15 0.2 0.75],'Visible','off','BorderType','none');
end
set(MethodPanel{1},'Visible','on')
% set(MethodPanel{3},'BackgroundColor','g')

MethodPanel1
MethodPanel2
MethodPanel3


% === BOTTOM PANEL BUTTONS ===
Save.Panel = uipanel('Parent',Op.Main,'Units','normalized','Position',[0 0 0.2 0.15],'BorderType','none');
Save.Button{1} = uicontrol('Parent',Save.Panel,'Units','normalized','Position',[0.05 0.1 0.425 0.35],'Style','pushbutton','String','Cancel');
Save.Button{2} = uicontrol('Parent',Save.Panel,'Units','normalized','Position',[0.525 0.1 0.425 0.35],'Style','pushbutton','String','Accept');
Save.Button{3} = uicontrol('Parent',Save.Panel,'Units','normalized','Position',[0.05 0.55 0.9 0.35],'Style','pushbutton','String','Export Results','Enable','off');

% === RESULTS PANEL ===
MainAxes.Panel = uipanel('Parent',Op.Main,'Units','normalized','Position',[0.2 0 0.8 1], ...
    'Title','Analysis Results: Time and Frequency Domains','BorderType','none');

MainAxes.Tabs{1} = uitabgroup(MainAxes.Panel,'Units','normalized','Position',[0.50 0.00 0.50 1.00]);
MainAxes.Tabs{2} = uitab(MainAxes.Tabs{1},'Title','Response Spectra');
MainAxes.Tabs{3} = uitab(MainAxes.Tabs{1},'Title','Power Spectral Density');
MainAxes.Tabs{4} = uitab(MainAxes.Tabs{1},'Title','Spectrogram');
MainAxes.Tabs{5} = uitab(MainAxes.Tabs{1},'Title','Intensity Measures and Others');

IMs

MainAxes.Titles = {'Reference Accelerogram','Energy Distribution','Synthetic Accelerogram','Design / Response Spectra','Power Spectral Density','Reference accelerogram epectrogram','Synthetic accelerogram epectrogram'};
MainAxes.xLabels = {'Time [s]','Time [s]','Time [s]','Period [s]','Frequency [Hz]','Time [s]','Time [s]'};
MainAxes.yLabels = {'Acceleration [g]','E / E_{max} [-]','Acceleration [g]','Pseudo-Acceleration [g]','Power / Frequency [dB/Hz]','Frequency [Hz]','Frequency [Hz]'};
MainAxes.zLabels = {'|A|'};

for i = 7:-1:1
    if i == 4
        MainAxes.ax{i} = axes('Parent',MainAxes.Tabs{2},'Units','normalized','Position',[0.10 0.10 0.85 0.85],'NextPlot','add');
    elseif i == 5
        MainAxes.ax{i} = axes('Parent',MainAxes.Tabs{3},'Units','normalized','Position',[0.10 0.10 0.85 0.85],'NextPlot','add');
    elseif i==6
        MainAxes.ax{i} = axes('Parent',MainAxes.Tabs{4},'Units','normalized','Position',[0.10 0.55 0.85 0.40],'NextPlot','add');
    elseif i==7
        MainAxes.ax{i} = axes('Parent',MainAxes.Tabs{4},'Units','normalized','Position',[0.10 0.10 0.85 0.40],'NextPlot','add');
    else
        MainAxes.ax{i} = axes('Parent',MainAxes.Panel,'Units','normalized','Position',[0.05 1-0.3*i 0.4 0.2],'NextPlot','add');
    end

    MainAxes.ax{i}.FontSize = 8;
    MainAxes.ax{i}.Title.String = MainAxes.Titles{i};
    MainAxes.ax{i}.Title.FontWeight = 'bold';
    MainAxes.ax{i}.Title.FontSize = 10;
    MainAxes.ax{i}.XLabel.String = MainAxes.xLabels{i};
    MainAxes.ax{i}.XLabel.FontWeight = 'normal';
    MainAxes.ax{i}.XLabel.FontSize = 10;
    MainAxes.ax{i}.YLabel.String = MainAxes.yLabels{i};
    MainAxes.ax{i}.YLabel.FontWeight = 'normal';
    MainAxes.ax{i}.YLabel.FontSize = 10;

    MainAxes.ax{i}.XMinorGrid = 'on';
    MainAxes.ax{i}.YMinorGrid = 'on';
    MainAxes.ax{2}.YLim = [0 1];
    MainAxes.ax{4}.XLim = [0 5];
    MainAxes.ax{6}.Title.String = 'Spectrogram';
    MainAxes.ax{6}.ZLabel.String = MainAxes.zLabels{1};
    MainAxes.ax{6}.ZLabel.FontWeight = 'normal';
    MainAxes.ax{6}.ZLabel.FontSize = 10;
    MainAxes.ax{6}.ZMinorGrid = 'on';
    MainAxes.ax{7}.Title.String = '';
    MainAxes.ax{7}.ZLabel.String = MainAxes.zLabels{1};
    MainAxes.ax{7}.ZLabel.FontWeight = 'normal';
    MainAxes.ax{7}.ZLabel.FontSize = 10;
    MainAxes.ax{7}.ZMinorGrid = 'on';
end

% === PLACEHOLDER PLOTS ===
MainAxes.pl{1,1} = plot(MainAxes.ax{1},nan,nan,'LineWidth',1,'color','#0072BD','LineStyle','-');
MainAxes.pl{1,2} = plot(MainAxes.ax{2},nan,nan,'LineWidth',1,'color','#0072BD','LineStyle','-');
MainAxes.pl{1,3} = plot(MainAxes.ax{3},nan,nan,'LineWidth',1,'color','#D95319','LineStyle','-');
MainAxes.pl{2,2} = plot(MainAxes.ax{2},nan,nan,'LineWidth',1,'color','#D95319','LineStyle','-');

MainAxes.pl{1,4} = plot(MainAxes.ax{4},nan,nan,'LineWidth',1,'color','#0072BD','LineStyle','-');
MainAxes.pl{2,4} = plot(MainAxes.ax{4},nan,nan,'LineWidth',1.5,'color','#77AC30','LineStyle','-');
MainAxes.pl{3,4} = plot(MainAxes.ax{4},nan,nan,'LineWidth',1,'color','#D95319','LineStyle','-');
MainAxes.pl{4,4} = plot(MainAxes.ax{4},nan,nan,'LineWidth',1,'color','#808080','LineStyle','-.');
MainAxes.pl{5,4} = plot(MainAxes.ax{4},nan,nan,'LineWidth',1,'color','#808080','LineStyle','--');

MainAxes.pl{1,5} = plot(MainAxes.ax{5},nan,nan,'LineWidth',1,'color','#0072BD','LineStyle','-');
MainAxes.pl{2,5} = plot(MainAxes.ax{5},nan,nan,'LineWidth',1,'color','#D95319','LineStyle','-');

MainAxes.Mesh{1} = mesh(MainAxes.ax{6},[]); MainAxes.Mesh{1}.EdgeColor = 'interp'; MainAxes.Mesh{1}.FaceColor = 'interp'; axis(MainAxes.ax{6},'ij');
MainAxes.Mesh{2} = mesh(MainAxes.ax{7},[]); MainAxes.Mesh{2}.EdgeColor = 'interp'; MainAxes.Mesh{2}.FaceColor = 'interp'; axis(MainAxes.ax{7},'ij');


MainAxes.lgd{1} = legend([MainAxes.pl{1,2} MainAxes.pl{2,2}], ...
    'Reference Accelerogram','Synthetic Accelerogram','Location','southeast');
MainAxes.lgd{2} = legend([MainAxes.pl{1,4} MainAxes.pl{2,4} MainAxes.pl{3,4} MainAxes.pl{4,4} MainAxes.pl{5,4}], ...
    'Response Spectrum - Reference','Target Design Spectrum','Response Spectrum - Synthetic','90% Target Design Spectrum','80% Target Design Spectrum');
MainAxes.lgd{3} = legend([MainAxes.pl{1,5} MainAxes.pl{2,5}], ...
    'Power Spectrum - Reference','Power Spectrum - Synthetic');
MainAxes.lgd{4} = legend([MainAxes.Mesh{1}], ...
    'Spectrogram - Reference','Location','southeast');
MainAxes.lgd{5} = legend([MainAxes.Mesh{2}], ...
    'Spectrogram - Synthetic','Location','southeast');

% === MODULES ===
DesignSpectrum
IntensityFunctionCacciola
IntensityFunctionGaussian

% === CALLBACK FOR METHOD SELECTION ===
set(Op.list,'Callback',@(h,e)functions.Cambio0(h,e,MethodPanel,MainAxes,MethodButtons,IM,Op))

% === CALLBACKS ===
set(MethodButtons{1}.Button{1},'Callback',@(h,e)functions.OpenEathquake(h,e,MethodButtons,MainAxes,Save,IM,Op))
set(MethodButtons{1}.Button{2},'Callback',@(h,e)functions.LoadEarthquake(h,e,MethodButtons,MainAxes,Damping,IM,Op))
set(MethodButtons{1}.Button{3},'Callback',@(h,e)functions.Cambio4(h,e,RSMethods,ASNSR10,SoilType,UsageGroup,RSAxes,Table,Codes,Damping,Op))
set(MethodButtons{1}.Button{4},'Callback',@(h,e)functions.matching1(h,e,MethodButtons,MainAxes,Save,IM,Op))

set(MethodButtons{2}.Button{5},'Callback',@(h,e)functions.Cambio7(h,e,IF2,MainAxes,MethodButtons,IM,Op))
set(MethodButtons{2}.Button{3},'Callback',@(h,e)functions.Cambio4(h,e,RSMethods,ASNSR10,SoilType,UsageGroup,RSAxes,Table,Codes,Damping,Op))
set(MethodButtons{2}.Button{6},'Callback',@(h,e)functions.GaussianNoise(h,e,MainAxes,MethodButtons,IM,Op))
set(MethodButtons{2}.Button{4},'Callback',@(h,e)functions.matching2(h,e,MethodButtons,MainAxes,Save,IM,Op))

set(MethodButtons{3}.Button{1},'Callback',@(h,e)functions.OpenEathquake(h,e,MethodButtons,MainAxes,Save,IM,Op))
set(MethodButtons{3}.Button{2},'Callback',@(h,e)functions.LoadEarthquake(h,e,MethodButtons,MainAxes,Damping,IM,Op))
set(MethodButtons{3}.Button{3},'Callback',@(h,e)functions.Cambio4(h,e,RSMethods,ASNSR10,SoilType,UsageGroup,RSAxes,Table,Codes,Damping,Op))
set(MethodButtons{3}.Button{5},'Callback',@(h,e)functions.Cambio5(h,e,IF1,Op))
set(MethodButtons{3}.Button{4},'Callback',@(h,e)functions.matching4(h,e,MethodButtons,MainAxes,Save,IM,Op))

set(Save.Button{1},'Callback',@(h,e)functions.MainCancel(h,e,Op))
set(Save.Button{2},'Callback',@(h,e)functions.MainAccept(h,e))
set(Save.Button{3},'Callback',@(h,e)functions.ExportResults(h,e,Op))

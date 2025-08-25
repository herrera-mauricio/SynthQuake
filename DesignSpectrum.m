% === DESIGN SPECTRUM MODULE ===

% Main window
Op.DS = uifigure('Units','normalized','Position',[0.2 0.1 0.5 0.7],'MenuBar','none', ...
    'NumberTitle','off','Name','SynthQuake: Elastic Acceleration Spectrum', ...
    'Visible','off','CloseRequestFcn',@(h,e)functions.CloseSpectrum(h,e,MainAxes,Op),'Icon',iconPath);

% Panel for seismic design code list
Codes.Panel = uipanel('Parent',Op.DS,'Units','normalized','Position',[0 0.9 1 0.1], ...
    'Title','Seismic Design Code');

% Names of the seismic codes
Codes.Names = {'Colombia - NSR-10 (AIS, 2010)', ...
    'Colombia - Seismic Microzonation of Bogotá (2010)', ...
    'Colombia - Seismic Microzonation of Cali (2005)', ...
    'Chile - Normal Use NCh433 (Chilean Standard, 2012)', ...
    'Eurocode 8 (European Union, 1998)', ...
    'User-defined Spectrum'};

% Dropdown menu with seismic code names
Codes.List = uicontrol('Parent',Codes.Panel,'Style','popupmenu','Units','normalized', ...
    'Position',[0.01 0.2 0.5 0.6],'String',Codes.Names);

% Panels for parameter input per code
Codes.Titles = {'Seismic Hazard Zone', ...
    'Seismic Microzone', ...
    'Seismic Microzone', ...
    'Seismic Hazard Zone', ...
    'Reference Acceleration / Spectrum Type', ...
    'Custom Spectrum'};

for i = length(Codes.Names):-1:1
    Codes.Hazard{i} = uipanel('Parent',Op.DS,'Units','normalized', ...
        'Position',[0 0.8 0.4 0.1],'Visible','off','Title',Codes.Titles{i});
    visual = {'on','off','off','off','off','off'};
    set(Codes.Hazard{i},'Visible',visual{i});
end

% === Panel for NSR-10 (Panel 1) ===
load ASNSR10.mat
RSMethods{1}.List{1} = uicontrol('Parent',Codes.Hazard{1},'Style','popupmenu','Units','normalized', ...
    'Position',[0.05 0.2 0.4 0.6],'String',{ASNSR10{:,1}});
j = get(RSMethods{1}.List{1},'Value');
RSMethods{1}.List{2} = uicontrol('Parent',Codes.Hazard{1},'Style','popupmenu','Units','normalized', ...
    'Position',[0.55 0.2 0.4 0.6],'String',ASNSR10{j,2});

% === Panel for Bogotá Microzonation (Panel 2) ===
RSMethods{2}.Names = {'CERROS','PIEDEMONTE A','PIEDEMONTE B','PIEDEMONTE C','LACUSTRE-50', ...
    'LACUSTRE-100','LACUSTRE-200','LACUSTRE-300','LACUSTRE-500','LACUSTRE ALUVIAL-200', ...
    'LACUSTRE ALUVIAL-300','ALUVIAL-50','ALUVIAL-100','ALUVIAL-200','ALUVIAL-300','DEPOSITO LADERA'};
RSMethods{2}.List = uicontrol('Parent',Codes.Hazard{2},'Style','popupmenu', ...
    'Units','normalized','Position',[0.1 0.2 0.8 0.6],'String',RSMethods{2}.Names);

% === Panel for Cali Microzonation (Panel 3) ===
RSMethods{3}.Names = {'Zone 1','Zone 2','Zone 3','Zone 4A','Zone 4B', ...
    'Zone 4C','Zone 4D','Zone 4E','Zone 5','Zone 6'};
RSMethods{3}.List = uicontrol('Parent',Codes.Hazard{3},'Style','popupmenu', ...
    'Units','normalized','Position',[0.1 0.2 0.8 0.6],'String',RSMethods{3}.Names);

% === Panel for Chile (Panel 4) ===
RSMethods{4}.Names = {'Zone 1','Zone 2','Zone 3'};
RSMethods{4}.List = uicontrol('Parent',Codes.Hazard{4},'Style','popupmenu', ...
    'Units','normalized','Position',[0.1 0.2 0.8 0.6],'String',RSMethods{4}.Names);

% === Panel for Eurocode 8 (Panel 5) ===
RSMethods{5}.Names = {'Type I','Type II'};
RSMethods{5}.Edit{1} = uicontrol('Parent',Codes.Hazard{5},'Style','Edit', ...
    'Units','normalized','Position',[0.05 0.2 0.25 0.6],'String','Agr [g] =','Enable','inactive','BackgroundColor',[0.941 0.941 0.941]);
RSMethods{5}.Edit{2} = uicontrol('Parent',Codes.Hazard{5},'Style','Edit', ...
    'Units','normalized','Position',[0.3 0.2 0.15 0.6],'String','0.25');
RSMethods{5}.List = uicontrol('Parent',Codes.Hazard{5},'Style','popupmenu', ...
    'Units','normalized','Position',[0.55 0.2 0.4 0.6],'String',RSMethods{5}.Names);

% === Panel for User-defined Spectrum (Panel 6) ===
RSMethods{6}.Edit{1} = uicontrol('Parent',Codes.Hazard{6},'Style','Edit', ...
    'Units','normalized','Position',[0.05 0.2 0.20 0.6], ...
    'String','File:','HorizontalAlignment','center', ...
    'Enable','inactive','BackgroundColor',[0.941 0.941 0.941]);
RSMethods{6}.Edit{2} = uicontrol('Parent',Codes.Hazard{6},'Style','Edit', ...
    'Units','normalized','Position',[0.25 0.2 0.40 0.6], ...
    'Enable','inactive','HorizontalAlignment','left');
RSMethods{6}.Button = uicontrol('Parent',Codes.Hazard{6},'Style','pushbutton', ...
    'Units','normalized','Position',[0.70 0.2 0.25 0.6], ...
    'String','Browse...','HorizontalAlignment','center');

% === Usage Group Panel ===
UsageGroup.Panel = uibuttongroup('Parent',Op.DS,'Units','normalized', ...
    'Position',[0.4 0.8 0.2 0.1],'Title','Usage Group');
UsageGroup.Names = {'Group I','Group II','Group III','Group IV'};
UsageGroup.List = uicontrol('Parent',UsageGroup.Panel,'Style','popupmenu', ...
    'Units','normalized','Position',[0.1 0.2 0.8 0.6],'String',UsageGroup.Names);

% === Soil Type Panel ===
SoilType.Panel = uibuttongroup('Parent',Op.DS,'Units','normalized', ...
    'Position',[0.6 0.8 0.2 0.1],'Title','Soil Type');
SoilType.Names = {'Soil A','Soil B','Soil C','Soil D','Soil E'};
SoilType.List = uicontrol('Parent',SoilType.Panel,'Style','popupmenu', ...
    'Units','normalized','Position',[0.1 0.2 0.8 0.6],'String',SoilType.Names);

% === Damping Panel ===
Damping.Panel = uibuttongroup('Parent',Op.DS,'Units','normalized', ...
    'Position',[0.8 0.8 0.20 0.1],'Title','Damping');
Damping.Edit{1} = uicontrol('Parent',Damping.Panel,'Style','edit', ...
    'Units','normalized','Position',[0.1 0.2 0.4 0.5], ...
    'String','ζ [%] =','Enable','inactive','BackgroundColor',[0.941 0.941 0.941]);
Damping.Edit{2} = uicontrol('Parent',Damping.Panel,'Style','edit', ...
    'Units','normalized','Position',[0.5 0.2 0.4 0.5],'String','5','Enable','on');

% === Table Panel ===
Table.Panel = uipanel('Parent',Op.DS,'Units','normalized','Position',[0.0 0.1 0.3 0.7]);
Table.Names.Col = {'Period [s]','Sa [g]'};
Table.Table = uitable('Parent',Table.Panel,'Units','normalized','Position',[0 0 1 1], ...
    'ColumnName',Table.Names.Col,'ColumnWidth',{'auto','auto'});

% === Plot Panel ===
RSAxes.Panel = uipanel('Parent',Op.DS,'Units','normalized','Position',[0.3 0.1 0.7 0.7]);

% Axes for plotting the design spectrum
RSAxes.ax = axes('Parent',RSAxes.Panel,'Units','normalized','Position',[0.1 0.125 0.85 0.80],'NextPlot','add');
RSAxes.ax.XLabel.String = 'Period [s]';
RSAxes.ax.XLabel.FontWeight = 'normal';
RSAxes.ax.YLabel.String = 'Pseudo-Acceleration [g]';
RSAxes.ax.YLabel.FontWeight = 'normal';
RSAxes.ax.XMinorGrid = 'on';
RSAxes.ax.YMinorGrid = 'on';
RSAxes.ax.XLim = [0 5];
RSAxes.ax.Toolbar.Visible = 'on';
RSAxes.p{1} = plot(RSAxes.ax,nan,nan);
RSAxes.p{1}.LineWidth = 1.5;
RSAxes.p{1}.Color = '#77AC30';

% === Action Buttons ===
Exit.Panel = uipanel('Parent',Op.DS,'Units','normalized','Position',[0 0 1 0.1]);
Exit.Button{1} = uicontrol('Parent',Exit.Panel,'Units','normalized','Style','pushbutton', ...
    'Position',[0.78 0.2 0.1 0.6],'String','Cancel');
Exit.Button{2} = uicontrol('Parent',Exit.Panel,'Units','normalized','Style','pushbutton', ...
    'Position',[0.89 0.2 0.1 0.6],'String','Accept');

% === Callback Assignments ===

% Spectrum calculation
set(Codes.List,'Callback',@(h,e)functions.Cambio1(h,e,RSMethods,ASNSR10,SoilType,UsageGroup,RSAxes,Table,Codes,Damping,Op));
set(SoilType.List,'Callback',@(h,e)functions.CalcSpectrum(h,e,RSMethods,ASNSR10,SoilType,UsageGroup,RSAxes,Table,Codes,Damping,Op));
set(UsageGroup.List,'Callback',@(h,e)functions.CalcSpectrum(h,e,RSMethods,ASNSR10,SoilType,UsageGroup,RSAxes,Table,Codes,Damping,Op));
set(RSMethods{1}.List{2},'Callback',@(h,e)functions.CalcSpectrum(h,e,RSMethods,ASNSR10,SoilType,UsageGroup,RSAxes,Table,Codes,Damping,Op));
set(RSMethods{1}.List{1},'Callback',@(h,e)functions.Cambio2(h,e,RSMethods,ASNSR10,SoilType,UsageGroup,RSAxes,Table,Codes,Damping,Op));
set(RSMethods{2}.List,'Callback',@(h,e)functions.CalcSpectrum(h,e,RSMethods,ASNSR10,SoilType,UsageGroup,RSAxes,Table,Codes,Damping,Op));
set(RSMethods{3}.List,'Callback',@(h,e)functions.CalcSpectrum(h,e,RSMethods,ASNSR10,SoilType,UsageGroup,RSAxes,Table,Codes,Damping,Op));
set(RSMethods{4}.List,'Callback',@(h,e)functions.CalcSpectrum(h,e,RSMethods,ASNSR10,SoilType,UsageGroup,RSAxes,Table,Codes,Damping,Op));
set(RSMethods{5}.Edit{2},'Callback',@(h,e)functions.CalcSpectrum(h,e,RSMethods,ASNSR10,SoilType,UsageGroup,RSAxes,Table,Codes,Damping,Op));
set(RSMethods{5}.List,'Callback',@(h,e)functions.CalcSpectrum(h,e,RSMethods,ASNSR10,SoilType,UsageGroup,RSAxes,Table,Codes,Damping,Op));
set(Damping.Edit{2},'Callback',@(h,e)functions.CalcSpectrum(h,e,RSMethods,ASNSR10,SoilType,UsageGroup,RSAxes,Table,Codes,Damping,Op));

% Open, Save, Close actions
set(RSMethods{6}.Button,'Callback',@(h,e)functions.LoadCustomSpectrum(h,e,RSMethods,RSAxes,Op));
set(Exit.Button{1},'Callback',@(h,e)functions.SaveSpectrum(h,e,MainAxes,Op));
set(Exit.Button{2},'Callback',@(h,e)functions.SaveSpectrum(h,e,MainAxes,Op));
set(Op.DS,'CloseRequestFcn',@(h,e)functions.CloseSpectrum(h,e,MainAxes,Op));
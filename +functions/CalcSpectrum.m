function CalcSpectrum(h,e,RSMethods,ASNSR10,SoilType,UsageGroup,RSAxes,Table,Codes,Damping,Operators)

% === Retrieve frequency and period vectors ===
F = Operators.F;
w = Operators.w;
T = Operators.T;

% === Read GUI selections ===
SoilValue = get(SoilType.List,'Value');
SoilList  = get(SoilType.List,'String');
Soil      = char(SoilList(SoilValue));

z = str2double(get(Damping.Edit{2},'String')) / 100;

GroupValue = get(UsageGroup.List,'Value');
GroupList  = get(UsageGroup.List,'String');
I          = char(GroupList(GroupValue));

index = get(Codes.List, 'Value');
DamFac = functions.DRF(z, T);

% === Initialize spectrum vector ===
Sa = nan(1, length(T));

% === Spectrum selection by index ===
switch index
    case 1  % NSR-10
        j = get(RSMethods{1}.List{1}, 'Value');
        k = get(RSMethods{1}.List{2}, 'Value');
        Aa = cell2mat(ASNSR10{j,3}(k));
        Av = cell2mat(ASNSR10{j,4}(k));
        Sa = functions.EspectroColombiaNSR10(Aa, Av, Soil, I, w);
        Sa = Sa .* DamFac;
        set([SoilType.Panel, Damping.Panel, UsageGroup.Panel], 'Enable', 'on');

    case 2  % Microzonificación Bogotá
        value = get(RSMethods{2}.List, 'Value');
        zones = get(RSMethods{2}.List, 'String');
        Sa = functions.EspectroColombiaBogota(zones{value}, I, w);
        Sa = Sa .* DamFac;
        set([SoilType.Panel], 'Enable', 'off');
        set([Damping.Panel, UsageGroup.Panel], 'Enable', 'on');

    case 3  % Microzonificación Cali
        value = get(RSMethods{3}.List, 'Value');
        zones = get(RSMethods{3}.List, 'String');
        Sa = functions.EspectroColombiaCali(zones{value}, I, w);
        Sa = Sa .* DamFac;
        set([SoilType.Panel], 'Enable', 'off');
        set([Damping.Panel, UsageGroup.Panel], 'Enable', 'on');

    case 4  % Chile
        zone = get(RSMethods{4}.List, 'Value');
        Sa = functions.EspectroChileNormal(zone, Soil, I, w);
        Sa = Sa .* DamFac;
        set([SoilType.Panel, Damping.Panel, UsageGroup.Panel], 'Enable', 'on');

    case 5  % Eurocode 8
        SpectrumType = get(RSMethods{5}.List, 'Value');
        agr = str2double(get(RSMethods{5}.Edit{2}, 'String'));

        set([SoilType.Panel, Damping.Panel, UsageGroup.Panel], 'Enable', 'on');

        if isnan(agr) || agr <= 0
            warndlg(['The entered reference acceleration (Agr) is invalid. ' ...
                     'It must be a number greater than zero.'], 'Warning');
        elseif agr > 1
            warndlg(['The entered reference acceleration (Agr) is higher than expected. ' ...
                     'Please verify.'], 'Warning');
            Sa = functions.EspectroEuro8(Soil, SpectrumType, I, agr, w);
        else
            Sa = functions.EspectroEuro8(Soil, SpectrumType, I, agr, w);
            Sa = Sa .* DamFac;
        end

    case 6  % Custom spectrum from file
        set([SoilType.Panel, Damping.Panel, UsageGroup.Panel], 'Enable', 'off');
        set(RSAxes.p{1}, 'XData', nan, 'YData', nan);
        set(RSMethods{6}.Edit{2}, 'String', strings(1));
        Sa=functions.OpenSpectrum(h,e,RSMethods,RSAxes,Operators);
end

% === Plot spectrum ===
set(RSAxes.p{1}, 'XData', T, 'YData', Sa);

% === Populate table ===
set(Table.Table, 'Data', [fliplr(T(2:end)); fliplr(Sa(2:end))]');
figure(Operators.DS);

% === Update operators ===
Operators.Sa = Sa;
Operators.T  = T;
Operators.z  = z;

end

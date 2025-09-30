function HI=CalcHI(T,PSV)

idx = (T >= 0.1) & (T <= 2.5);

T_sub = T(idx);
Sv_sub = PSV(idx);

[T_sub, sortIdx] = sort(T_sub);
Sv_sub = Sv_sub(sortIdx);

HI = trapz(T_sub, Sv_sub);

end
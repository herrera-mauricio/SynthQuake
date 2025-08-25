function ASI=CalcASI(T,PSA)

idx = (T >= 0.1) & (T <= 0.5);

T_sub = T(idx);
Sa_sub = PSA(idx);

[T_sub, sortIdx] = sort(T_sub);
Sa_sub = Sa_sub(sortIdx);

ASI = trapz(T_sub, Sa_sub);

end
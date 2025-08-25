function H=UnitStep(x)

if x<0
    H=0;
elseif x>0
    H=1;
else
    H=0.5;
end


end

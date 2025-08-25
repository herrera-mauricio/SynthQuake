function factor=DRF(z,T)
% z: razón de amortiguamiento (en decimal)
% T: vector de periodo
%According to "Improved damping reduction factor models for different
%response spectra" by Tao Liu, Wenze Wang, Huakun Wang and Binjian Su (2021)


a=[-1.360 1.197 -0.3672]; %F
b=[-1.102 0.6471 -2.522 -0.6621 %G
    2.815 0.6621 -2.159 1.141   %H
   -0.5125 0.5267 0.3707 0.1372 %I
   1.541 0.03206 1.515 -0.6225  %J
   3.160 0.5970 -2.218 -0.04897];%K

F=a(1)*(z-0.05)*(a(2)*log(z)^2+a(3)*log(z)+1);
G=b(1,1)*z^b(1,2)+b(1,3)*z+b(1,4);
H=b(2,1)*z^b(2,2)+b(2,3)*z+b(2,4);
I=b(3,1)*z^b(3,2)+b(3,3)*z+b(3,4);
J=b(4,1)*z^b(4,2)+b(4,3)*z+b(4,4);
K=b(5,1)*z^b(5,2)+b(5,3)*z+b(5,4);

factor=1+F*((G*T.^H)./(1+T)+I.*log(T)+J.*T.^K);
factor=[1 factor(2:end-1) 1];

end

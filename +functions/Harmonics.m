function Noise=Harmonics(NFFT,Gu,CorFunction,w,Dw,t,phi)

Armonicos=zeros(NFFT);

for i=1:NFFT

    if w(i)<Inf
    Armonicos(i,:)=sqrt(2*CorFunction(i).*Gu(i)*Dw).*cos(w(i).*t+phi(i));
    else
    Armonicos(i,:)=zeros(1,NFFT);
    end
end
Noise=sum(Armonicos,1);
end
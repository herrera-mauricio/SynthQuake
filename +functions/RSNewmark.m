function [Sa,Sv,Sd]=RSNewmark(Sismo,fs,wn,z)

PGA=max(abs(Sismo));

dt=1/fs;

for j=1:length(wn)

    m=1;
    k=wn(j)^2;
    c=2*wn(j)*z*m;

%Cálculos Iniciales
beta=1/4;
gamma=1/2;

Pg(1)=-m*Sismo(1);
U(1)=0;
U1(1)=0;
U2(1)=(Pg(1)-c*U1(1)-k*U(1))/m;


a1=(1/(beta*dt^2))*m+(gamma/(beta*dt))*c;
a2=(1/(beta*dt))*m+((gamma/beta)-1)*c;
a3=((1/(2*beta))-1)*m+dt*((gamma/(2*beta))-1)*c;
kg=k+a1;

    for i=1:length(Sismo)-1
   
   Pg(i+1)=-m*Sismo(i+1)+a1*U(i)+a2*U1(i)+a3*U2(i);
   U(i+1)=Pg(i+1)/kg;
   U1(i+1)=(gamma/(beta*dt))*(U(i+1)-U(i))+(1-(gamma/beta))*U1(i)+dt*(1-(gamma/(2*beta)))*U2(i);
   U2(i+1)=(1/(beta*dt^2))*(U(i+1)-U(i))-(1/(beta*dt))*U1(i)-((1/(2*beta))-1)*U2(i);
     
    end
    Sd(:,j)=max(abs(U));
    Sv(:,j)=Sd(:,j)*wn(j);
    Sa(:,j)=Sv(:,j)*wn(j);
end
Sa=[Sa PGA];
end
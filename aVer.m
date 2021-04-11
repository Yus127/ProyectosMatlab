g=9.81;
delta_t=0.1;
iteraciones= 100;
particulas = 50;

Pox=0;
Poy=5426;
Poz=0;
Po=[Pox,Poy,Poz];
%figure(1)

Aox_min = -100;
Aox_max = 100;
Aoy_min = 200;
Aoy_max = 300;
Aoz_min = -100;
Aoz_max = 100;

Fy = zeros(1,iteraciones);

for p=1:particulas-1
    masa= randBetween(0.1, 3);
    radio=masa;
    
    A = 4 * pi * radio ^ 2;
    Cd = 0.001;
    rho = 0.004;
    D = Cd * .5 * rho * A;
    
    Aox= randBetween(Aox_min, Aox_max);
    Aoy= randBetween(Aoy_min, Aoy_max);
    Aoz= randBetween(Aoz_min, Aoz_max);
    Ao= [Aox, Aoy, Aoz];
    
    Fw=-g*masa*delta_t;
    Fy(1)= Ao(2)*masa*delta_t+Fw;
    F=[Ao(1)*masa*delta_t, Ao(2)*masa*delta_t+Fw, Ao(3)*masa*delta_t];
    Xp=Po;
    Xc=Po;
    a=F/masa;

    Xs=zeros(1,iteraciones);
    Ys=zeros(1,iteraciones);
    Zs=zeros(1,iteraciones);

    Xn=verlet(Xc, Xp, a, delta_t);
    Xs(1)=Xn(1);
    Ys(1)=Xn(2);
    Zs(1)=Xn(3);

    for i=1:iteraciones-1
    Xp=Xc;
    Xc= Xn;
    
    distancia = [Xc(1)-Xp(1), Xc(2)-Xp(2), Xc(3)-Xp(3)];
    velocidad = distancia / delta_t;
    v2 = [velocidad(1)^2, velocidad(2)^2, velocidad(3)^2];
    resistencia = D * v2;
    
    Fy(i+1) = Fy(i)+Fw;
    F=[F(1)-resistencia(1), Fy(i)-resistencia(2), F(3)-resistencia(3)];
    
    a=F/masa;
    Xn=verlet(Xc,Xp, a, delta_t);
    Xs(i+1)=Xn(1);
    Ys(i+1)=Xn(2);
    Zs(i+1)=Xn(3);
    end
    scatter3(Xs, Zs, Ys)
    hold on
    
end
hold off
grid on 
drawnow
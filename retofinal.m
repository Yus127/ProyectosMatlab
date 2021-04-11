g=9.81

delta_t=0.1
iteraciones=100
particulas = 10

Pox=0
Poy=60
Poz=0
Po=[Pox,Poy,Poz]
figure(1)

Aox_min = -200
Aox_max = 200
Aoy_min = 200
Aoy_max = 300
Aoz_min = -200
Aoz_max = 200

Fy = zeros(1,iteraciones)

for p=1:particulas-1
    
    Aox= randBetween(Aox_min, Aox_max)
    Aoy= randBetween(Aoy_min, Aoy_max)
    Aoz= randBetween(Aoz_min, Aoz_max)
    Ao= [Aox, Aoy, Aoz]
    masa= randBetween(1, 5)
    Fw=-g*masa*delta_t
    %Ff=masa*k*
    Fy(1)= Ao(2)*masa*delta_t+Fw%-mkv
    F=[Ao(1)*masa*delta_t, Ao(2)*masa*delta_t+Fw, Ao(3)*masa*delta_t]
    Xp=Po
    Xc=Po
    a=F/masa

    Xs=zeros(1,iteraciones)
    Ys=zeros(1,iteraciones)
    Zs=zeros(1,iteraciones)

    Xn=verlet(Xc, Xp, a, delta_t)
    Xs(1)=Xn(1);
    Ys(1)=Xn(2);
    Zs(1)=Xn(3);

    for i=1:iteraciones-1
    Xp=Xc;
    Xc= Xn;
    Fy(i+1) = Fy(i)+Fw
    F=[F(1), Fy(i), F(3)];
    a=F/masa;
    Xn=verlet(Xc,Xp, a, delta_t)
    Xs(i+1)=Xn(1);
    
    Ys(i+1)=Xn(2);
    
    Zs(i+1)=Xn(3);
    end
    scatter3(Xs, Zs, Ys)
    hold on
end
hold off
%view([-46 31])

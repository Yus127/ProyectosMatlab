xi=300;xf=2600;yi=2300;yf=800;
x1=1280;y1=2670;x2=1800;y2=-230;
derra=input('Introduce el tipo de derrape (1,2,3): ');
peralt = input('Introduce el peralte en las curvas: ');
mk = input('La pista está 1=mojada o 0=seca: ');
if mk==0
    Mk=.4;
elseif mk==1
    Mk=0;
end

peralte =deg2rad(peralt);
velMax1 = zeros(1,10);
velMax2 = zeros(1,10);

yy= [yi;y1;y2;yf];
l=1;

x= xi:xf;
mitad= round(length(x)/2);
listaMax= zeros(1,10);
contador=0;
listaMax2= zeros(1,10);
contador2=0;
velocidadMax=zeros (1,length(x));
Matriz=[xi^3 xi^2 xi 1;x1^3 x1^2 x1 1;x2^3 x2^2 x2 1;xf^3 xf^2 xf 1;];
    
coeficientes =Matriz\yy;
a=coeficientes(1);
b=coeficientes(2);
c=coeficientes(3);
d=coeficientes(4);

x= xi:xf;

miFuncio= @(x) a*(x).^3+b*(x).^2+c*(x)+d;
y= miFuncio(x);

FuncionD1 = @(x) (a*(3*x.^2))+(b*(2*x))+(c);
FuncionD2 = @(x) (a*(6*x))+(b*(2)); 
EqLongitud = @(x) sqrt((1+((a*(3*x.^2))+(b*(2*x))+(c))).^2); 


LongitudPistaSimpson= integralS1(EqLongitud,xi,xf,100);

pendientes = FuncionD1(x);
concavidades = FuncionD2(x);

radio = (1+(pendientes.^2).^(3/2)) ./ abs(concavidades);
close all;
set(gcf,'Position',get(0,'Screensize'));
figure(1);
hold on;
grid on;
axis([0 3000 -5000 5000]);
text(xi-100, yi,'Inicio \rightarrow')
text(xi, yi-300, "x= "+xi+" y= "+yi);
text(xf, yf, '\leftarrow Fin')
text(xf, yf+300, "x= "+xf+" y= "+yf);
text(x1, y1+300, "x= "+x1+" y= "+y1);
text(x2, y2+300, "x= "+x2+" y= "+y2);

plot(x,y,'LineWidth', 10, 'color','k')
plot(x,y,'LineStyle', '--','color','w')
title('Reto: Simulación del recorrido de un tramo de pista de un auto de carreras F1')
xlabel('Eje X (m)')
ylabel('Eje Y(m)')
auto= plot(x(1),y(1),'LineWidth', 20, 'color','r');

posicion= text(3750, 4000, "x= "+x(1)+" y= "+y(1));


for i=1:length(x)
    
    if radio(i) <= 100
        pistaroja = text(x(i),y(i),'\','color','r', 'FontSize',15);
    end
     if abs(pendientes(i)) < 1
        pistaroja = text(x(i),y(i),'/','color','y', 'FontSize',15);
      
    end
    if abs(pendientes(i)) <1
      velocidadMax(i)= sqrt(9.81*radio(i)*((sin(peralte)+Mk*cos(peralte))/(cos(peralte)-Mk*sin(peralte))));  
      if i<mitad
          listaMax(i)= i;
          contador= contador+1;
      else
          listaMax2(i)= i;
          contador2= contador2+1;
      end
    end    
end
for k=1:mitad
    if velocidadMax(k)~=0
     velMax1(l)=velocidadMax(k);
     l=l+1;   
    end
end
l=1;
for k=mitad:length(x)
    if velocidadMax(k)~=0
     velMax2(l)=velocidadMax(k);
     l=l+1;   
    end
end
variableMax= (length(listaMax)-contador)+1;
variableMax2= (length(listaMax2)-contador2)+1;

xrandom1= round(variableMax + (length(listaMax)-variableMax) * rand());
xrandom2= round(variableMax2 + (length(listaMax2)-variableMax2) * rand());

velocidadLetrero1= min(velMax1)*3.6;
text(xi+250, yf+2*variableMax, "La velocidad máxima de esta curva es: "+velocidadLetrero1+" km/h")

velocidadLetrero2= min(velMax2)*3.6;
text(xf-variableMax,y2-1500, "La velocidad máxima de esta curva es: "+velocidadLetrero2+" km/h")
text(variableMax+xi+1000,y1, "La distancia de la pista es aproximadamente:  " +LongitudPistaSimpson+" m");
text(variableMax+xi+1000,y1-200, "El Mk es: "+Mk);
text(variableMax+xi+1000,y1-400, "El peralte es: "+peralt+"º")
text(variableMax+xi+1000,y1-600,['Tiempo de inicio= ' datestr(now,'HH:MM:SS')]);
%puntos intermedios
text(x1,y1,'·','color','r','FontSize',50);
text(x2,y2,'·','color','r','FontSize',50);

count = 0;

for i=1:5:length(x)
    delete(auto);
    delete(posicion);
    auto = text(x(i),y(i),'95','color','r','FontSize',30);
    posicion= text(variableMax+xi+1000,y1+200, "x= "+x(i)+" y= "+y(i));
    
    if abs(pendientes(i)) <1
        count = count +1;
        
        delete(auto);
        delete(posicion);
        j = plot(x(i),y(i),'LineWidth', 15, 'color','r');
        auto = text(x(i),y(i),'95','color','y','FontSize',30);
        posicion= text(variableMax+xi+1000,y1+200, "x= "+x(i)+" y= "+y(i));

        xtangente = x(i):x(i)+300;
        btangente = y(i)-pendientes(i)*x(i);
        ytangente= pendientes(i)*xtangente+btangente;
        plot(xtangente,ytangente)
        
        if count == 2;

        if x(i)>mitad
        xtangente = x(i):x(i)+80;
 
        btangente = y(i)-pendientes(i)*x(i);
        ytangente= pendientes(i)*xtangente+btangente-20;%20 metros arriba
        ytangente2= pendientes(i)*xtangente+btangente-30;
        
        plot(xtangente,ytangente,'g','LineWidth',10)
        plot(xtangente,ytangente2,'g','LineWidth',10)
        for o=0:1:10
            ytangente3= pendientes(i)*xtangente+btangente-20-o;
             plot(xtangente,ytangente3,'g','LineWidth',10)
        end
        else 
        xtangente = x(i):x(i)+80;
        btangente = y(i)-pendientes(i)*x(i);
        ytangente= pendientes(i)*xtangente+btangente+20;%20 metros arriba
        ytangente2= pendientes(i)*xtangente+btangente+30;
        
        plot(xtangente,ytangente,'g','LineWidth',10)
        plot(xtangente,ytangente2,'g','LineWidth',10)
        for o=0:1:10
            ytangente3= pendientes(i)*xtangente+btangente+20+o;
             plot(xtangente,ytangente3,'g','LineWidth',10)
        end
        end
        
        end
 
    end
        
     if (x(i)<=mitad+5) && (x(i)>=mitad)
            count=0;
        end
    if (derra==1) && (i>=xrandom1)
            delete(auto);
            delete(posicion);
            text(variableMax+300,y1+1000,"Se derrapó",'color','r','FontSize',20)
            
        for j=1:10:length(xtangente)
            delete(auto)
            delete(posicion)
 
            auto = text(xtangente(j),ytangente(j),'95','color','r','FontSize',30);
            posicion= text(variableMax+xi+1000,y1+200, "x= "+xtangente(j)+" y= "+ytangente(j));
             
            drawnow
        end
        break
     end
        
     if (derra==2) && (i>=xrandom2)
          delete(auto);
            delete(posicion);
           
            text(x2+200,y2-1700,"Se derrapó",'color','r','FontSize',20)
         for j=1:10:length(xtangente)
            delete(auto)
            delete(posicion)
            auto = text(xtangente(j),ytangente(j),'95','color','r','FontSize',30);
             posicion= text(variableMax+xi+1000,y1+200, "x= "+xtangente(j)+" y= "+ytangente(j));
             
            drawnow
        end
        break
    else
        delete(auto);
        delete(posicion);
     
        auto = text(x(i),y(i),'95','color','y','FontSize',30); 
        posicion= text(variableMax+xi+1000,y1+200, "x= "+x(i)+" y= "+y(i));
    
    end
    delete(auto);
    delete(posicion);
    delete(posicion);
       
    auto= text (x(i),y(i),'95','color','y', 'FontSize',40);
        posicion= text(variableMax+xi+1000,y1+200, "x= "+x(i)+" y= "+y(i));

    drawnow;
end
text(variableMax+xi+1000,y1-800,['Tiempo final= ' datestr(now,'HH:MM:SS')]);
cachau = text(x(length(x)),0,'¡Ka-Chow!','color','r','FontSize',20);


a=6;
cargasP=6;
cargasN=6;
d=1;
q1=1;
q2=-1;
n1=(cargasP-1)/2;
n2=(cargasN-1)/2;
k=1;
x1=-a/2;
x2=a/2;
for x = -10:d:10 
    for y = -10:d:10 
        sumx2=0;
        sumx1=0;
        sumy2=0;
        sumy1=0;
        display(x+" "+y);
        for y1 = -n1:d:n1
        E1x=(k*q1*(x-x1)/((x-x1)^2+(y-y1)^2)^(3/2));
        E2x=(k*q2*(x-x2)/((x-x2)^2+(y-y1)^2)^(3/2));
        sumx2=sumx2+E2x;
        sumx1=sumx1+E1x;
        plot(x1, y1, "O");
        end
        
        for y2 = -n2:d:n2
        E1y=(k*q1*(y-y2)/((x-x1)^2+(y-y2)^2)^(3/2));
        E2y=(k*q2*(y-y2)/((x-x2)^2+(y-y2)^2)^(3/2));
        sumy2=sumy2+E2y;
        sumy1=sumy1+E1y;
        plot(x2, y2, "O");
        end
        
        
        SUMX= sumx1+sumx2
        SUMY= sumy2+sumy1
        
        magnitud = sqrt(SUMX^2+SUMY^2);
        UnitarioX= SUMX/magnitud
        UnitarioY= SUMY/magnitud
        
        quiver(x,y,UnitarioX,UnitarioY,'color','b','linewidth',1.2,'autoscalefactor',1);
    
        hold on
        
     end
   
end

axis([-11 11 -11 11])

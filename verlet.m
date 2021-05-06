function Xn = verlet (Xc, Xp, acc, dt)
    Xn =2*Xc-Xp+acc*dt^2;
end


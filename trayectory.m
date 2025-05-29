function trayectory(Bz,z,mag,m,zo,dt,vz,gamma)
    w = -m*9.81; %Inicializar el peso
    % Inicializacion de vectores 
    
    zm(1) = zo;
    zmfree(1) = zo;
    vz(1) = 0.7;
    vzfree(1) = 0;
    tt(1) = 0;
    delta = 0.005;
    % cc = 1; % Contador no necesario por que se hara con un for 
    
    for i = 1:-1:-3
        % Derivar 
        Bz_forward=interpl(z, Bz, zm(i) + delta, 'linear','extrap');
        Bz_backward=interpl(z, Bz, zm(i) - delta, 'linear','extrap');
        dBz_dz = (Bz_forward - Bz_backward) / (2*delta);
        
        % Calcular la fuerza magnetica
        Fm(i) = -mag * dBz_dz;
        Ff = -gamma * vz(i); % Se calcula la fuerza de friccion
        F(i) = Fm(i) + w + Ff;
        a = F(i)/m;
        
        % Cinematica de la caida libre del iman
        zmfree(i+1) = zmfree(i) + vzfree(i)*dt + 0.5*(-9.81)*dt^2;
        vzfree(i+1) = vzfree(i) - 9.81*dt;
        
        % Modificar el tiempo 
        tt(i+1) = tt(i) +dt;
        
        if abs(vz(i+1)) < 1e-3
            break; %Se para el ciclo for 
        end
    
    end
    
    % Visualizar los resultados obtenidos
    
    figure(3)
    
    hold on
    plot(tt,zm,'r','LineWidth',2);
    plot(tt,zmfree,'-bb','LineWidth',2);
    xlabel('time (s)');
    ylabel('z position (m)');
    title('Position vs time of a Magnetic dipole falling through a current ring');
    legend('Fall over a current ring', 'Free fall (no Magnetic force)');
    axis([0 max(tt) -6 6])
end

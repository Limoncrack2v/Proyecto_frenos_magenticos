function [x, y, z, dx, dy, dz] = generar_solenoide(N, R)


    % 1) Generamos los ángulos uniformes de 0 a 2π (sin repetir el punto inicial).
    theta = linspace(0, 2*pi, N+1);
    theta(end) = [];  % eliminamos el último, que es idéntico al primero

    % 2) Coordenadas en el plano z=0
    x = R * cos(theta);
    y = R * sin(theta);
    z = zeros(1, N);  % toda la espira base en z = 0

    % 3) Calculamos dl = (x(i+1)-x(i), y(i+1)-y(i), z(i+1)-z(i)),
    %    cerrando el bucle al final (i = N → i+1 = 1).
    dx = zeros(1, N);
    dy = zeros(1, N);
    dz = zeros(1, N);
    for i = 1 : N-1
        dx(i) = x(i+1) - x(i);
        dy(i) = y(i+1) - y(i);
        dz(i) = z(i+1) - z(i);  % aquí siempre 0
    end
    % Cierre de la espira (de N a 1)
    dx(N) = x(1) - x(N);
    dy(N) = y(1) - y(N);
    dz(N) = z(1) - z(N);  % cero

end


function turns = turns(nl, N, R, sz, I)
    mo = 4*pi * 1e-7;
    km = mo * I / (4*pi);
    rw = 0.2;

    angulo = linspace(0, 2*pi, N + 1);
    angulo(end) = [];
    x = R * cos(angulo);
    y = R * sin(angulo);
    dx = R * -sin(angulo);
    dy = R * cos(angulo);
    dz = zeros(1, N);
    z = zeros(1, N);

    figure;
    hold on;
    axis equal;
    view(3);
    grid on;
    xlabel('Eje X');
    ylabel('Eje Y');
    zlabel('Eje Z');

    for k = 0:nl - 1
        z_espiral = z + k * ((nl - 1)/2);
        quiver3(x, y, z_espiral, dx, dy, dz, 'r', 'LineWidth',1.2);
    end
end


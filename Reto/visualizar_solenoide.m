function visualizar_solenoide(x, y, z, dx, dy, dz, nl, sz)

    figure;
    hold on;
    axis equal;
    view(3);
    grid on;
    xlabel('x (m)');
    ylabel('y (m)');
    zlabel('z (m)');
    title(sprintf('%d espiras de radio %.2f m, espaciadas %.2f m', nl, norm(x(1)), sz));

    % Graficar cada espira (usamos quiver3 para mostrar dl en cada segmento)
    for k = 0 : (nl-1)
        % Elevamos la base en z = k*sz
        z_espira = z + k * sz;  % si z(1)=0, las espiras quedan en z = 0, sz, 2sz, ...
        quiver3(x, y, z_espira, dx, dy, dz, 'r', 'LineWidth', 1.0, ...
                'MaxHeadSize', 0.3, 'AutoScale', 'off');
        % Opcional: también podemos dibujar la línea cerrada de la espira
        plot3(x, y, z_espira, 'k-', 'LineWidth', 0.8);
    end

    % Mostrar ejes
    grid on;
    legend('dl en cada segmento', 'Trayectoria de la corriente');
end

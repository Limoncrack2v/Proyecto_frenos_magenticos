function visualizar_campo(Bx_total, Bz_total, malla_x, malla_z)


    Nx = length(malla_x);
    Nz = length(malla_z);

    % Seleccionar la sección central en Y
    Ny = size(Bx_total, 2);
    idx_y_center = round(Ny / 2);

    % Extraer cortes X–Z (note: i indice x, k indice z)
    Bx_xz = squeeze(Bx_total(:, idx_y_center, :));  % Nx×Nz
    Bz_xz = squeeze(Bz_total(:, idx_y_center, :));  % Nx×Nz

    % Módulo del campo en X–Z
    Bmag_xz = sqrt(Bx_xz.^2 + Bz_xz.^2);  % Nx×Nz

    % Creamos mallas para pcolor/streamslice
    [Xgrid, Zgrid] = meshgrid(malla_x, malla_z);  
    % Observa: meshgrid( malla_x, malla_z ) → Xgrid(i,k) = malla_x(i), Zgrid(i,k) = malla_z(k)

    figure;
    clf;
    % 1) Mostrar el módulo (elevamos a 1/3 para “realzar” contrastes si es muy pequeño)
    pcolor(Xgrid, Zgrid, (Bmag_xz').^(1/3));
    shading interp;
    colormap(turbo);
    colorbar;
    hold on;

    % 2) Trazar líneas de campo (streamslice). 
    %    Observa que streamslice quiere vectores de tamaño (size(Zgrid)×size(Xgrid)),
    %    por eso pasamos Bx_xz' y Bz_xz'.
    hSL = streamslice(Xgrid, Zgrid, Bx_xz', Bz_xz', 4);
    set(hSL, 'Color', [1 1 1]*0.9);

    axis equal tight;
    xlabel('x (m)');
    ylabel('z (m)');
    title('Sección X–Z del campo magnético (módulo^{1/3} y líneas de flujo)');
    hold off;
end

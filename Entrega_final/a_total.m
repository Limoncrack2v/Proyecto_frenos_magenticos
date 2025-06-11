function a = a_total(z_val, v_val, Bz_vec, z_axis, mag, gamma, m)
    % 1) Derivada numérica central para dBz/dz
    delta = 0.005;  % intervalo pequeño
    Bz_forward  = interp1(z_axis, Bz_vec, z_val + delta, 'linear', 'extrap');
    Bz_backward = interp1(z_axis, Bz_vec, z_val - delta, 'linear', 'extrap');
    dBz_dz = (Bz_forward - Bz_backward) / (2 * delta);

    % 2) Fuerzas
    Fm = - mag * dBz_dz;      % magnetostática (si mag<0, Fm apunta hacia arriba)
    Ff = - gamma * v_val;     % fricción magnética (proporcional a v)
    Fg = - m * 9.81;          % peso (hacia abajo)

    % 3) Aceleración total = F_total / m
    F_total = Fm + Ff + Fg;
    a = F_total / m;
end

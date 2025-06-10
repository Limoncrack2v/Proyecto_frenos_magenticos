% -------------------------------------------------------------------------
%   Archivo: rk4_a_total.m
%
%   Contiene dos funciones:
%     1) rk4_step  →  un paso de Runge–Kutta 4 para el sistema:
%                       dz/dt = v
%                       dv/dt = a(z,v)
%     2) a_total   →  calcula la aceleración a partir de z y v, usando Bz, malla_z, mag, gamma, m.
%
%   IMPORTANTE: El nombre del archivo ("rk4_a_total.m") coincide con el nombre
%   de la primera función que aparece aquí (rk4_step). La segunda función
%   (a_total) queda como subfunción local.
% -------------------------------------------------------------------------

function [z_next, v_next] = runge_(z, v, dt, a_func)
% RK4_STEP: un paso de Runge–Kutta 4 para el sistema
%            dz/dt = v
%            dv/dt = a(z, v)
%
%   Entradas:
%     - z      : posición actual (escalar)
%     - v      : velocidad actual (escalar)
%     - dt     : paso de tiempo
%     - a_func : handle a función de aceleración,
%                tal que a = a_func(z, v)
%
%   Salidas:
%     - z_next : posición actualizada en t + dt
%     - v_next : velocidad actualizada en t + dt
%

    % 1) k1
    k1_z = v;
    k1_v = a_func(z, v);

    % 2) k2 (evaluamos en z + k1_z*dt/2, v + k1_v*dt/2)
    z_mid1 = z + (dt/2)*k1_z;
    v_mid1 = v + (dt/2)*k1_v;
    k2_z = v_mid1;
    k2_v = a_func(z_mid1, v_mid1);

    % 3) k3 (evaluamos en z + k2_z*dt/2, v + k2_v*dt/2)
    z_mid2 = z + (dt/2)*k2_z;
    v_mid2 = v + (dt/2)*k2_v;
    k3_z = v_mid2;
    k3_v = a_func(z_mid2, v_mid2);

    % 4) k4 (evaluamos en z + k3_z*dt, v + k3_v*dt)
    z_end  = z + dt * k3_z;
    v_end  = v + dt * k3_v;
    k4_z = v_end;
    k4_v = a_func(z_end, v_end);

    % 5) Combinación RK4
    z_next = z + (dt/6)*(k1_z + 2*k2_z + 2*k3_z + k4_z);
    v_next = v + (dt/6)*(k1_v + 2*k2_v + 2*k3_v + k4_v);
end


% -------------------------------------------------------------------------
%   Subfunción: a_total
%   Calcula la aceleración en función de (z, v), usando el campo Bz y parámetros.
% -------------------------------------------------------------------------
function a = a_total(z_val, v_val, Bz_vec, z_axis, mag, gamma, m)
% A_TOTAL: f(z,v) = aceleración total = (F_mag + F_fricción + F_gravedad)/m
%
%   Entradas:
%     - z_val  : posición actual (escalar)
%     - v_val  : velocidad actual (escalar)
%     - Bz_vec : vector 1×N con Bz en cada punto de z_axis
%     - z_axis : vector 1×N con las alturas donde está definido Bz_vec
%     - mag    : momento magnético (constante escalar)
%     - gamma  : coeficiente de fricción magnética
%     - m      : masa del imán (kg)
%
%   Salida:
%     - a : aceleración (m/s^2)
%

    % Definimos pequeño delta para derivada numérica
    delta = 0.005;

    % 1) Interpolar Bz adelante y atrás para estimar dBz/dz
    Bz_forward  = interp1(z_axis, Bz_vec, z_val + delta, 'linear', 'extrap');
    Bz_backward = interp1(z_axis, Bz_vec, z_val - delta, 'linear', 'extrap');
    dBz_dz = (Bz_forward - Bz_backward) / (2 * delta);

    % 2) Calcular fuerzas
    Fm = - mag * dBz_dz;       % fuerza magnética
    Ff = - gamma * v_val;      % fuerza de fricción magnética
    Fg = - m * 9.81;           % peso (hacia abajo)

    F_total = Fm + Ff + Fg;

    % 3) Devolver aceleración
    a = F_total / m;
end





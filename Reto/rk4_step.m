function [z_next, v_next] = rk4_step(z, v, dt, a_func)

    % 1) k1
    k1_z = v;
    k1_v = a_func(z, v);

    % 2) k2: en (z + k1_z*(dt/2), v + k1_v*(dt/2))
    z_mid1 = z + (dt/2) * k1_z;
    v_mid1 = v + (dt/2) * k1_v;
    k2_z = v_mid1;
    k2_v = a_func(z_mid1, v_mid1);

    % 3) k3: en (z + k2_z*(dt/2), v + k2_v*(dt/2))
    z_mid2 = z + (dt/2) * k2_z;
    v_mid2 = v + (dt/2) * k2_v;
    k3_z = v_mid2;
    k3_v = a_func(z_mid2, v_mid2);

    % 4) k4: en (z + k3_z*dt, v + k3_v*dt)
    z_end = z + dt * k3_z;
    v_end = v + dt * k3_v;
    k4_z = v_end;
    k4_v = a_func(z_end, v_end);

    % Combinación final de RK4
    z_next = z + (dt/6) * (k1_z + 2*k2_z + 2*k3_z + k4_z);
    v_next = v + (dt/6) * (k1_v + 2*k2_v + 2*k3_v + k4_v);
end


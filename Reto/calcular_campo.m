function [Bx_total, By_total, Bz_total] = calcular_campo(N, nl, x, y, z, dx, dy, dz, malla_x, malla_y, malla_z, km, sz)
    Bx_total = zeros(N, N, N);
    By_total = zeros(N, N, N);
    Bz_total = zeros(N, N, N);

    for i = 1:length(malla_x)
        for j = 1:length(malla_y)
            for k = 1:length(malla_z)
                Bx = 0; By = 0; Bz = 0;

                for n = 0:nl - 1
                    for l = 1:N
                        x0 = malla_x(i);
                        y0 = malla_y(j);
                        z0 = malla_z(k);

                        x_seg = x(l);
                        y_seg = y(l);
                        z_seg = z(l) + n * sz;

                        r_vec = [x0 - x_seg, y0 - y_seg, z0 - z_seg];
                        r_mag = norm(r_vec);

                        if r_mag == 0
                            continue;
                        end

                        dl = [dx(l), dy(l), dz(l)];
                        dB = km * cross(dl, r_vec) / (r_mag^3);

                        Bx = Bx + dB(1);
                        By = By + dB(2);
                        Bz = Bz + dB(3);
                    end
                end

                Bx_total(i,j,k) = Bx;
                By_total(i,j,k) = By;
                Bz_total(i,j,k) = Bz;
            end
        end
    end
end

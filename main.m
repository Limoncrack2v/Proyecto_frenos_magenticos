clear;          
clc;            
close all; 

nl = 5;
N = 20;
R = 1.5;
sz = 1;
I = 300;
mo = 4*pi * 1e-7;
km = mo * I / (4*pi);
rw = 0.2;
m = 10;

angulo = linspace(0, 2*pi, N + 1);
angulo(end) = [];

x = R * cos(angulo);
y = R * sin(angulo);

dx = R * -sin(angulo);
dy = R * cos(angulo);
dz = zeros(1, N);
z = zeros(1, N);
mag = 1000;
gamma = 0.1;
zo = 4.9;
vz = 0.7;
dt = 0.05;

mag = 1000;
gamma = 0.1;
zo = 4.9;
vz = 0.7;
dt = 0.05;
m = 10;

malla_x = linspace(-5, 5, N);
malla_y = linspace(-2, 2, N);
malla_z = linspace(-2, 6, N);
Bx_total = zeros(N, N, N);
By_total = zeros(N, N, N);
Bz_total = zeros(N, N, N);

turns(nl, N, R, sz, I)
field(N, nl, x, y, sz, z, dx, dy, dz, km, mo, rw)
trayectory(Bz_total,z,mag,m,zo,dt,vz,gamma)



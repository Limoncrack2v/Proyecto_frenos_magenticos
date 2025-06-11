## Simulación del Campo Magnético de un Solenoide en MATLAB

## Usage

Clone the repo and run the `main.m` file to see all the functios running, show the 3 graphs.

```
git clone https://github.com/Limoncrack2v/Proyecto_frenos_magenticos
```

## a_total.m

### Syntax

```matlab
a_total(z_val, v_val, Bz_vec, z_axis, mag, gamma, m)
```

| Parameter  | Type     | Description                                                                 |
|------------|----------|-----------------------------------------------------------------------------|
| `z_val`    | Float    | Current position along the Z-axis (meters).                                 |
| `v_val`    | Float    | Current velocity along the Z-axis (meters/second).                          |
| `Bz_vec`   | Vector   | Magnetic field values \( B_z \) sampled along the Z-axis.                   |
| `z_axis`   | Vector   | Corresponding Z positions for each value in `Bz_vec`.                       |
| `mag`      | Float    | Magnetic moment of the object (Ampere·meter²).                              |
| `gamma`    | Float    | Magnetic damping coefficient (kg/s), representing frictional force.         |
| `m`        | Float    | Mass of the object (kilograms).                                             |

### Output

a (Float): The total acceleration experienced by the object at position z_val.

### Example

```matlab
a = a_total(0.1, 0.2, linspace(0, 1, 100), linspace(-0.5, 0.5, 100), 0.01, 0.05, 0.02);
```

----------------------------------------------------------------------------------------------------------------------------------

## calcular_campo.m 

### Syntax 

```matlab
calcular_campo(N, nl, x, y, z, dx, dy, dz, malla_x, malla_y, malla_z, km, sz)
```

### Parameters

| Parámetro    | Tipo     | Descripción                                                                 |
|--------------|----------|-----------------------------------------------------------------------------|
| `N`          | Integer  | Número de segmentos por cada espira circular (afecta la resolución).         |
| `nl`         | Integer  | Número de espiras apiladas a lo largo del eje Z.                            |
| `x`, `y`, `z`| Float    | Coordenadas del punto de observación donde se desea calcular el campo.      |
| `dx`         | Float    | Separación entre segmentos en la dirección X (del mallado).                 |
| `dy`         | Float    | Separación entre segmentos en la dirección Y (del mallado).                 |
| `dz`         | Float    | Separación entre espiras en la dirección Z (del apilamiento).              |
| `malla_x`    | Vector   | Coordenadas X de los puntos del mallado.                                    |
| `malla_y`    | Vector   | Coordenadas Y de los puntos del mallado.                                    |
| `malla_z`    | Vector   | Coordenadas Z de los puntos del mallado.                                    |
| `km`         | Float    | Constante magnética \(\mu_0 \cdot I / (4\pi)\), para el cálculo del campo. |
| `sz`         | Float    | *Parámetro no usado.* Reservado para compatibilidad o uso futuro.           |

### Output

In a typical usage, you might see:
    - Arrows indicating the magnetic field direction around the solenoid.
    - Higher density and magnitude of the field inside the solenoid core.
    - A symmetric pattern of the magnetic field resembling a classic solenoidal field distribution.

### Example

```matlab
calcular_campo(N, nl, x, y, z, dx, dy, dz, malla_x, malla_y, malla_z, km, sz)
```

----------------------------------------------------------------------------------------------------------------------------------

## generar_solenoide.m

### Syntax

```matlab
generar_solenoide(N, R)
```

### Parameters

| Parámetro | Tipo     | Descripción                                                                 |
|-----------|----------|-----------------------------------------------------------------------------|
| `N`       | Integer  | Número de segmentos utilizados para discretizar una espira circular.         |
| `R`       | Float    | Radio de la espira circular que representa una vuelta del solenoide.         |


### Output

This will plot a circle of radius 1 with 100 discrete points representing the wire loop, lying in the plane.

### Example

```matlab
generar_solenoide(100, 1)
```

----------------------------------------------------------------------------------------------------------------------------------

## rk4_step.m

### Syntax

```matlab
[z_next, v_next] = rk4_step(z, v, dt, a_func)
```

### Parameters

| Parameter | Type     | Description                                                      |
|-----------|----------|------------------------------------------------------------------|
| `z`       | Float    | Current position (usually along z-axis) at the current time step.|
| `v`       | Float    | Current velocity at the current time step.                       |
| `dt`      | Float    | Time step size for the integration.                             |
| `a_func`  | Function | Handle to a function that calculates acceleration `a = a_func(z, v)`.|


### Example
```matlab
[z_next, v_next] = rk4_step(z, v, dt, a_func)
```

----------------------------------------------------------------------------------------------------------------------------------

## runge_a_total.m

### Syntax

```matlab
[z_next, v_next] = runge_(z, v, dt, a_func)
```

### Parameters

### Parámetros de `runge_`

| Parámetro | Tipo       | Descripción                                   |
|-----------|------------|-----------------------------------------------|
| `z`       | Float      | Posición actual (escalar).                     |
| `v`       | Float      | Velocidad actual (escalar).                    |
| `dt`      | Float      | Paso de tiempo para integración.              |
| `a_func`  | Function   | Handle a función que calcula aceleración: `a = a_func(z, v)`.|

---

### Parámetros de `a_total`

| Parámetro | Tipo       | Descripción                                              |
|-----------|------------|----------------------------------------------------------|
| `z_val`   | Float      | Posición actual (escalar).                               |
| `v_val`   | Float      | Velocidad actual (escalar).                              |
| `Bz_vec`  | Vector     | Vector con valores del campo magnético Bz a lo largo de `z_axis`. |
| `z_axis`  | Vector     | Vector con posiciones donde está definido `Bz_vec`.     |
| `mag`     | Float      | Momento magnético (constante escalar).                   |
| `gamma`   | Float      | Coeficiente de fricción magnética.                       |
| `m`       | Float      | Masa del imán (kg).                                     |

---

### Salidas

| Función  | Salida   | Tipo  | Descripción                          |
|----------|----------|-------|------------------------------------|
| `runge_` | `z_next` | Float | Posición actualizada en t + dt.    |
|          | `v_next` | Float | Velocidad actualizada en t + dt.   |
| `a_total`| `a`      | Float | Aceleración calculada en (z, v).   |


### Example

```matlab
[z_next, v_next] = runge_(z, v, dt, a_func)
```

----------------------------------------------------------------------------------------------------------------------------------

## simular_frenado_test.m

### Syntax

```matlab
[t, zm] = simular_frenado_test(Bz_total, malla_z)
```

### Parameters

### Parámetros de entrada

| Parámetro  | Tipo      | Descripción                                                                                      |
|------------|-----------|------------------------------------------------------------------------------------------------|
| `Bz_total` | Matriz 3D | Campo magnético Bz definido en una malla 3D con dimensiones (Nx × Ny × Nz).                     |
| `malla_z`  | Vector 1D | Vector con las posiciones en el eje z donde está definido el campo magnético `Bz_total`.       |

---

### Parámetros de salida

| Parámetro | Tipo    | Descripción                                      |
|-----------|---------|------------------------------------------------|
| `t`       | Vector  | Vector con los tiempos de simulación [s].      |
| `zm`      | Vector  | Vector con la posición del imán en el eje z [m].|

---

### Example
```matlab
[t, zm] = simular_frenado_test(Bz_total, malla_z)
```

----------------------------------------------------------------------------------------------------------------------------------


## visualizar_campo.m

### Syntax

```matlab
visualizar_campo(Bx_total, Bz_total, malla_x, malla_z)
```

### Parameters

### Example

```matlab
visualizar_campo(Bx_total, Bz_total, malla_x, malla_z)
```

----------------------------------------------------------------------------------------------------------------------------------

## visualizar_solenoide.m

### Syntax

```matlab
visualizar_solenoide(x, y, z, dx, dy, dz, nl, sz)
```

### Parameters

| Parámetro    | Tipo       | Descripción                                                                                   |
|--------------|------------|-----------------------------------------------------------------------------------------------|
| `Bx_total`   | Matriz 3D | Componente x del campo magnético en la malla 3D (dimensiones: Nx × Ny × Nz).                 |
| `Bz_total`   | Matriz 3D | Componente z del campo magnético en la malla 3D (dimensiones: Nx × Ny × Nz).                 |
| `malla_x`    | Vector 1D | Vector con las posiciones en el eje x donde está definido el campo magnético.                |
| `malla_z`    | Vector 1D | Vector con las posiciones en el eje z donde está definido el campo magnético.                |

---

### Example

```matlab
visualizar_campo(Bx_total, Bz_total, malla_x, malla_z)
```


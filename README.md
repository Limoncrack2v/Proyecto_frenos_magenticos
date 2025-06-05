## Simulación del Campo Magnético de un Solenoide en MATLAB

## Description


## Usage

Clone the repo and run the `main.m` file to see all the functios running, show the 3 graphs.

```
git clone https://github.com/Limoncrack2v/Proyecto_frenos_magenticos
```

## Generate Turns

### Description

### Syntax

```matlab
turns(nl, N, R, sz, I)
```

| Parameter | Type     | Description |
|-----------|----------|-------------|
| `nl`      | Integer  | Number of layers (loops) stacked along the Z-axis. Each layer is a circular current loop. |
| `N`       | Integer  | Number of segments used to discretize each circular loop (affects visual smoothness). |
| `R`       | Float    | Radius of each circular loop. |
| `sz`      | Float    | *Unused parameter.* Reserved for future use or legacy compatibility. |
| `I`       | Float    | Current flowing through each loop (used in magnetic constant calculation, though not visualized). |

### Output

This function does not return any output. It generates a 3D plot showing the vector directions of current flow in each circular loop arranged along the Z-axis.


### Internal Constants

- `mo = 4π × 10⁻⁷`: Magnetic permeability of free space (H/m).
- `rw = 0.2`: Wire radius (not used in calculations, could be for future enhancements).

### Visualization

- `quiver3` is used to plot arrows representing the current direction on each loop.
- Each loop is offset in the Z direction to form a helix-like stack.
- Red arrows (`'r'`) are used to indicate the vector field.
- Axes are labeled and grid is enabled for clarity.

### Example

```matlab
turns(5, 100, 1, 0.1, 10)
```
This will draw 5 circular loops of radius 1, each discretized into 100 segments, spaced evenly along the Z-axis, simulating a solenoid with current `I = 10`.

----------------------------------------------------------------------------------------------------------------------------------

## Magnetic Field

### Description

### Syntax 

```matlab
field(N, nl, x, y, sz, z, dx, dy, dz, km, mo, rw)
```

### Parameters

| Parameter | Type     | Description |
|-----------|----------|-------------|
| `N`       | Integer  | Number of segments in each loop and resolution of the 3D meshgrid. |
| `nl`      | Integer  | Number of loops (layers) in the solenoid. |
| `x`, `y`, `z` | Arrays | Position vectors of each segment in a loop. |
| `sz`      | Float    | Vertical spacing between loops. |
| `dx`, `dy`, `dz` | Arrays | Differential vector components (segment direction vectors) of the current elements. |
| `km`      | Float    | Magnetic constant `μ₀I / (4π)` used in the Biot-Savart law. |
| `mo`      | Float    | Magnetic permeability of free space (typically `4π × 10⁻⁷`). |
| `rw`      | Float    | Wire radius (not used in current calculations but may be reserved for future use). |


### Output

This function does not return a value but generates visual output:

- A call to `trayectory(...)` (assumed to visualize a particle trajectory, not defined in this function).
- A 2D plot showing a heatmap of magnetic field magnitude in the XZ plane and streamlines representing field direction.

### Calculation

- The field is calculated at every point of a 3D grid defined by `malla_x`, `malla_y`, and `malla_z`.
- The magnetic field contribution from each current segment is calculated using the **Biot–Savart law**:
  \\[ \vec{dB} = \frac{\mu_0 I}{4\pi} \frac{\vec{dl} \times \vec{r}}{r^3} \\]

### Visualization

- A slice at the center of the Y-plane (`y = 0`) is used to extract the XZ components of the field.
- The magnetic field magnitude is plotted using a colored heatmap (`pcolor`).
- `streamslice` is used to draw field lines for visualizing the direction of the field.
- The colormap is set to `turbo`, providing a vivid appearance.

### Notes

- The function expects that variables like `trayectory`, `mag`, `m`, `zo`, `dt`, `vz`, and `gamma` are defined elsewhere or globally. These are used in the `trayectory(...)` call.
- The parameter `rw` is not used directly.
- The visualization is professional and stylized to resemble physical simulation outputs.

### Example

```matlab
% Assuming x, y, z, dx, dy, dz are computed from a circular loop
field(50, 10, x, y, 0.1, z, dx, dy, dz, km, mo, rw)
```

This will calculate and visualize the magnetic field of a solenoid with 10 loops, using a 50×50×50 spatial resolution.

----------------------------------------------------------------------------------------------------------------------------------

## Trajectory
### Description

### Syntax

```matlab
trayectory(Bz, z, mag, m, zo, dt, vz, gamma)
```

### Parameters

| Parameter | Type     | Description |
|-----------|----------|-------------|
| `Bz`      | Array    | Z-component of the magnetic field along the Z-axis. |
| `z`       | Array    | Position values corresponding to `Bz`. |
| `mag`     | Float    | Magnetic moment of the falling object. |
| `m`       | Float    | Mass of the falling magnetic object. |
| `zo`      | Float    | Initial position along the Z-axis. |
| `dt`      | Float    | Time step for simulation. |
| `vz`      | Float    | Initial velocity of the object along the Z-axis. |
| `gamma`   | Float    | Friction (drag) coefficient modeling resistive force. |


### Output

The function does not return values, but produces a figure:

- **Figure 3**: A plot of position vs. time comparing:
  - The motion of the magnet falling through a magnetic field.
  - The motion of the same magnet under free fall (without magnetic forces).


### Core Mechanics

- Uses the finite difference method to approximate the derivative \( \frac{dB_z}{dz} \) for computing the magnetic force.
- The magnetic force is calculated using:
  \\[ F_m = -\mu \frac{dB_z}{dz} \\]
  where \( \mu \) is the magnetic moment.
- Includes gravitational force \( F_g = -mg \) and damping force \( F_f = -\gamma v \).
- Updates position and velocity using basic kinematics.

### Visualization

- Red line: Trajectory of the magnet influenced by the magnetic field.
- Blue line: Free fall trajectory without magnetic interaction.
- X-axis: Time (seconds)
- Y-axis: Vertical position (meters)

### Notes

- Uses interpolation (`interp1`) for estimating the field gradient at the current position.
- The simulation loop terminates early if the magnet velocity falls below a small threshold (\(10^{-3}\)) to represent near rest.
- The loop is defined over a hardcoded range (`1:-1:-3`), which may need adjustment depending on the required number of simulation steps.

### Example

```matlab
trayectory(Bz, z, 0.01, 0.2, 1.0, 0.01, 0.7, 0.05)
```

Simulates the trajectory of a 200 g magnet with magnetic moment 0.01 A·m², starting at height 1.0 m with 0.7 m/s downward velocity and a friction coefficient of 0.05.

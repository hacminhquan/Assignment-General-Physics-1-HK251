# Assigmnet-General-Physics-1-HK251
## Determining Trajectory and Angular Momentum (MATLAB Physics Simulation)

<p align="center">
  <img src="https://img.shields.io/badge/MATLAB-R2024a-orange?logo=mathworks" />
  <img src="https://img.shields.io/badge/Physics-Classical%20Mechanics-blue" />
  <img src="https://img.shields.io/badge/Status-Completed-brightgreen" />
  <img src="https://img.shields.io/badge/License-Educational-lightgrey" />
</p>

---

## Overview

This project is a MATLAB-based simulation tool for analyzing two-dimensional particle motion using symbolic computation and numerical methods.

The program allows users to:

* Define motion using parametric equations x(t), y(t)
* Compute velocity components automatically
* Calculate angular momentum
* Visualize trajectory and angular momentum over time
* Verify conservation of angular momentum

---

## Features

### Symbolic Computation

* Automatic differentiation:

  * vx = dx/dt
  * vy = dy/dt
* Angular momentum:
  Lz = m(x·vy − y·vx)

### Visualization

* 2D trajectory plot (x vs y)
* Angular momentum vs time
* Time markers along trajectory

### Animation

* Real-time particle motion
* Velocity vector visualization
* Smooth frame updates

### Physics Analysis

* Outputs:

  * Initial and final position
  * Initial and final angular momentum
* Conservation check:

  * Angular momentum conserved
  * Angular momentum not conserved

---

## Requirements

* MATLAB (tested with R2024a)
* Symbolic Math Toolbox

---

## Getting Started

### 1. Clone repository

```
git clone https://github.com/your-username/physics-trajectory-simulation.git
cd physics-trajectory-simulation
```

### 2. Run the program in MATLAB

```
project1physics.m
```

### 3. Input example

```
Enter x(t) = 6*t
Enter y(t) = 8*t - 4.9*t^2
Enter mass = 1
Enter time range: 0 to 2
```

### 4. Animation option

```
Do you want to see animation? (1: yes, 0: no)
```

---

## Example Simulations

### Projectile Motion

* Parabolic trajectory
* Angular momentum not conserved

### Vertical Toss

* Straight-line motion
* Angular momentum conserved (Lz = 0)

### Circular Orbit

* Circular trajectory
* Angular momentum constant

### Spiral Motion

* Expanding trajectory
* Angular momentum not conserved

---

## Project Structure

```
.
├── project1physics.m
├── report/
│   └── Assignment_Physics1.pdf
└── README.md
```

---

## Physics Background

Position vector:

```
r(t) = x(t)i + y(t)j
```

Velocity:

```
v(t) = dr/dt
```

Angular momentum:

```
L = r × (m v)
Lz = m(x·vy − y·vx)
```

Conservation law:

```
dL/dt = torque
```

---

## Advantages

* Combines symbolic and numerical computation
* Provides clear visualization of motion
* Supports user-defined equations
* Useful as a learning and simulation tool

---

## Limitations

* Only supports 2D motion
* No air resistance or complex force models
* Minor numerical approximation errors

---

## Contributors

* Hắc Minh Quân
* Huỳnh Quốc Trọng Nghĩa
* Nguyễn Quốc Nam
* Văn Minh
* Nguyễn Doãn Nhân

---

## License

This project is intended for educational purposes only.

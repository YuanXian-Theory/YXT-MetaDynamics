"""
One-dimensional Complex Ginzburg-Landau equation
solved by ETDRK4 + Fourier pseudospectral method.

Reference implementation corresponding to Section 5.8 of the paper
"Self-referential Heart Field Meta-dynamic Explicit Evolution
Differential Equation" (Yuanxian Theory).
"""

import numpy as np
import matplotlib.pyplot as plt

N = 512
L = 2 * np.pi
dt = 1e-3
T = 50.0
n_steps = int(T / dt)
lam = 0.1
sigma = 1.0

x = np.linspace(0, L, N, endpoint=False)
k = np.fft.fftfreq(N, d=L / (2 * np.pi)) * 2 * np.pi
k2 = k**2
Lk = -1j * (k2 + lam)


def phi_contour(z, m, M=32, r=1.0):
    """Contour-integral evaluation of phi_m(z) to avoid overflow."""
    theta = 2 * np.pi * np.arange(M) / M
    tau = z[..., None] + r * np.exp(1j * theta)
    e = np.exp(tau)
    s = np.zeros_like(tau)
    for j in range(m):
        s += tau**j / np.math.factorial(j)
    integrand = (e - s) / tau**m
    return np.mean(integrand, axis=-1)


E = np.exp(Lk * dt)
E2 = phi_contour(Lk * dt, 1)
Q0 = phi_contour(Lk * dt, 2)
Q1 = phi_contour(Lk * dt, 3)
Q2 = phi_contour(Lk * dt, 4)


def Nk(psi_hat):
    psi = np.fft.ifft(psi_hat)
    nl = -1j * sigma * (np.abs(psi)**2 - 1.0) * psi
    return np.fft.fft(nl)


psi0 = 1.0 + 1e-3 * np.cos(x)
psi_hat = np.fft.fft(psi0)

for n in range(n_steps):
    Nn = Nk(psi_hat)
    a_hat = E2 * psi_hat + Q0 * Nn
    Na = Nk(a_hat)
    b_hat = E2 * psi_hat + Q0 * Na
    Nb = Nk(b_hat)
    c_hat = E2 * a_hat + Q0 * (2 * Nb - Nn)
    Nc = Nk(c_hat)
    psi_hat = (E * psi_hat + Q1 * Nn
               + 2 * Q1 * (Na + Nb) + Q2 * Nc)

psi = np.fft.ifft(psi_hat)

plt.figure(figsize=(6, 4))
plt.plot(x, np.abs(psi))
plt.xlabel("x")
plt.title("Steady-state solution |psi|")
plt.tight_layout()
plt.savefig("cgl_solution.png", dpi=150)
print("Saved cgl_solution.png")
# plt.show()

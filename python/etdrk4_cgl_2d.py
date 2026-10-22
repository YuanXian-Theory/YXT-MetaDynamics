"""
Two-dimensional Complex Ginzburg-Landau equation
solved by ETDRK4 + Fourier pseudospectral method.

Core fragment corresponding to Section 5.9 of the paper.
"""

import numpy as np

N = 256
L = 2 * np.pi
dt = 1e-3
lam = 0.1
sigma = 1.0

x = np.linspace(0, L, N, endpoint=False)
kx = np.fft.fftfreq(N, d=L / (2 * np.pi)) * 2 * np.pi
KX, KY = np.meshgrid(kx, kx, indexing="ij")
K2 = KX**2 + KY**2
Lk = -1j * (K2 + lam)


def phi_contour(z, m, M=32, r=1.0):
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
    psi = np.fft.ifftn(psi_hat)
    nl = -1j * sigma * (np.abs(psi)**2 - 1.0) * psi
    return np.fft.fftn(nl)


psi0 = 1.0 + 1e-2 * np.exp(1j * 2 * np.pi * np.random.rand(N, N))
psi_hat = np.fft.fftn(psi0)

for n in range(int(50.0 / dt)):
    Nn = Nk(psi_hat)
    a_hat = E2 * psi_hat + Q0 * Nn
    Na = Nk(a_hat)
    b_hat = E2 * psi_hat + Q0 * Na
    Nb = Nk(b_hat)
    c_hat = E2 * a_hat + Q0 * (2 * Nb - Nn)
    Nc = Nk(c_hat)
    psi_hat = E * psi_hat + Q1 * Nn + 2 * Q1 * (Na + Nb) + Q2 * Nc

print("2-D ETDRK4 integration finished.")

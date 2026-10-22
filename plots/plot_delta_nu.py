"""
Appendix A.2 – Neutrino oscillation probability difference Delta_nu.
"""

import numpy as np
import matplotlib.pyplot as plt

L_over_E = np.linspace(0, 1000, 500)
delta_CP = 3.88


def delta_nu(L_over_E, delta_CP):
    return 0.065 * np.sin(1.267 * L_over_E / 1000 + delta_CP)


plt.figure(figsize=(6, 4))
plt.plot(L_over_E, delta_nu(L_over_E, delta_CP), "b-", lw=2,
         label=r"Yuanxian prediction ($\delta_{CP}=3.88$ rad)")
plt.plot(L_over_E, delta_nu(L_over_E, 0.0), "r--", lw=1.5,
         label=r"CP conservation ($\delta_{CP}=0$)")
plt.xlabel(r"$L/E$ [km/GeV]")
plt.ylabel(r"$\Delta_\nu$")
plt.title(r"Expected behaviour of $\Delta_\nu$")
plt.legend()
plt.grid(alpha=0.3)
plt.tight_layout()
plt.savefig("nu.pdf")
print("Saved nu.pdf")
# plt.show()

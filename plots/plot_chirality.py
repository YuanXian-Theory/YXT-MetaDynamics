"""
Appendix A.3 – Chiral energy difference Delta E_PVED.
"""

import numpy as np
import matplotlib.pyplot as plt

chi = np.linspace(-2, 2, 100)
dE_yxt = -1e-17 * chi
dE_ab_initio = -1e-17

plt.figure(figsize=(6, 4))
plt.plot(chi, dE_yxt, "b-", lw=2, label=r"Yuanxian prediction")
plt.axhline(dE_ab_initio, color="r", ls="--",
            label=r"PVED ab-initio magnitude")
plt.xlabel(r"Topological chirality index $\chi$")
plt.ylabel(r"$\Delta E_{\mathrm{PVED}}$ [a.u.]")
plt.title(r"Expected chiral energy difference")
plt.legend()
plt.grid(alpha=0.3)
plt.tight_layout()
plt.savefig("chirality.pdf")
print("Saved chirality.pdf")
# plt.show()

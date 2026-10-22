"""
Appendix A.1 – Dark-energy equation-of-state w(z) expected evolution.
"""

import numpy as np
import matplotlib.pyplot as plt

z = np.linspace(0, 2, 200)
w_yxt = -1.0 + 0.03 * (1 - np.exp(-z / 0.5))
w_obs = -1.03
w_err = 0.03

plt.figure(figsize=(6, 4))
plt.plot(z, w_yxt, "b-", lw=2, label=r"Yuanxian prediction")
plt.axhline(w_obs, color="r", ls="--", label=r"Planck 2018 central value")
plt.fill_between(z, w_obs - w_err, w_obs + w_err,
                 color="r", alpha=0.15, label=r"$1\sigma$ constraint")
plt.xlabel(r"Redshift $z$")
plt.ylabel(r"Equation of state $w(z)$")
plt.title(r"Expected evolution of $w(z)$")
plt.legend()
plt.grid(alpha=0.3)
plt.tight_layout()
plt.savefig("wz.pdf")
print("Saved wz.pdf")
# plt.show()

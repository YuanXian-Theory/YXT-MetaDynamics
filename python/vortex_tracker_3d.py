"""
Core routines for 3-D vortex-line tracking.

Corresponding to Section 5.10 of the paper.
Full connection / density statistics can be extended from this skeleton.
"""

import numpy as np
from scipy.ndimage import label


def compute_winding(phase):
    """Compute winding number on a 2-D slice."""
    dphase_x = np.diff(phase, axis=0, append=phase[:1, :])
    dphase_y = np.diff(phase, axis=1, append=phase[:, :1])
    # Fold phase difference into (-pi, pi]
    dphase_x = (dphase_x + np.pi) % (2 * np.pi) - np.pi
    dphase_y = (dphase_y + np.pi) % (2 * np.pi) - np.pi
    return np.round((dphase_x + dphase_y) / (2 * np.pi)).astype(int)


def extract_vortex_lines(psi, threshold=0.1):
    """
    Parameters
    ----------
    psi : ndarray, shape (Nz, Ny, Nx)
        Complex 3-D field.
    threshold : float
        Unused in this minimal version; kept for API compatibility.

    Returns
    -------
    lines : list of (z, coords)
        Detected vortex segments.
    """
    phase = np.angle(psi)
    lines = []
    for z in range(psi.shape[0]):
        winding = compute_winding(phase[z])
        mask = np.abs(winding) > 0
        labeled, num = label(mask)
        for i in range(1, num + 1):
            coords = np.argwhere(labeled == i)
            if len(coords) > 0:
                lines.append((z, coords))
    return lines


# Example usage (requires a 3-D field `psi`):
# vortex_lines = extract_vortex_lines(psi)
# print(f"Detected {len(vortex_lines)} vortex segments")

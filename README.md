# YXT-MetaDynamics

Lean 4 formalization **and** numerical reference implementations for the
**Self-referential Heart Field Meta-dynamic Explicit Evolution Differential Equation**
(Yuanxian Theory).

Paper: 元宪理论·自指心场元动力显式演化微分方程  
Based on the topological ontology $\mathcal{T}^{64}=(S^1)^{64}$.

Repository: https://github.com/YuanXian-Theory/YXT-MetaDynamics

## Contents

```
YXT-MetaDynamics/
├─ YuanXianOntology/          # Lean 4 formalization (P1–P7)
├─ Test/                      # Lean tests
├─ python/                    # Numerical reference codes (Section 5)
│   ├─ etdrk4_cgl_1d.py       # 1-D ETDRK4 + pseudospectral
│   ├─ etdrk4_cgl_2d.py       # 2-D core fragment
│   └─ vortex_tracker_3d.py   # 3-D vortex-line tracking skeleton
├─ plots/                     # Appendix A plotting scripts
│   ├─ plot_w_z.py
│   ├─ plot_delta_nu.py
│   └─ plot_chirality.py
├─ lakefile.lean
├─ lean-toolchain
└─ README.md
```

## Lean 4 status (P1–P7)

| ID | Statement | Status |
|----|-----------|--------|
| P1 | Fiber homeomorphic to $\mathcal{T}^{60}$ | **Proved** |
| P2 | Product homeomorphism $\mathcal{T}^{64}\simeq\mathcal{T}^{4}\times\mathcal{T}^{60}$ | **Topological form proved** |
| P3 | Pointwise contraction | **Proved** |
| P4 | Compression constant $\|1-\alpha\|<1$ | **Proved** |
| P5 | Unique ground-state fixed point | **Proved** |
| P6 | Time-arrow irreversibility (Lyapunov) | **Proved** |
| P7 | Parameter-locking consistency | **Proved** |

## Quick start

### Lean
```bash
lake exe && lake build
```

### Python numerical examples
```bash
cd python
python etdrk4_cgl_1d.py
python etdrk4_cgl_2d.py
```

### Appendix plots
```bash
cd plots
python plot_w_z.py
python plot_delta_nu.py
python plot_chirality.py
```

## License

CC BY-SA 4.0

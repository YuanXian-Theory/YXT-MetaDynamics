# YXT-MetaDynamics

Lean 4 formalization of the **Self-referential Heart Field Meta-dynamic Explicit Evolution Differential Equation** from Yuanxian Theory.

Paper: *元宪理论·自指心场元动力显式演化微分方程*  
Based on the topological ontology \(\mathcal{T}^{64} = (S^1)^{64}\).

## Status

| Proposition | Statement | Status |
|-------------|-----------|--------|
| **P1** | Projection operator fiber homeomorphic to \(\mathcal{T}^{60}\) | `sorry` |
| **P2** | Projection preserves rank of homology groups up to degree 4 | `sorry` |
| **P3** | Self-referential evolution operator is a strict contraction | `sorry` |
| **P4** | Compression constant satisfies \(\|1 - \alpha\| < 1\) | **Proved** |
| **P5** | Existence and uniqueness of the cosmic ground-state fixed point | `sorry` |
| **P6** | Irreversibility of the time arrow (entropy strictly increasing) | `sorry` |
| **P7** | Algebraic consistency of parameter locking | **Proved** |

## Structure

```
YXT-MetaDynamics/
├─ README.md
├─ lakefile.lean
├─ lean-toolchain
├─ YuanXianOntology/
│   ├─ Basic.lean          # Type definitions (T64, T4, T60, Proj)
│   ├─ Projection.lean    # P1, P2
│   ├─ Contraction.lean   # P3, P4, P5
│   ├─ Entropy.lean       # P6
│   └─ ParameterLock.lean # P7
└─ lake-manifest.json
```

## Build

```bash
lake build
```

Requires [Lean 4](https://leanprover.github.io/) and Mathlib.

## License

CC BY-SA 4.0 (same as the paper).

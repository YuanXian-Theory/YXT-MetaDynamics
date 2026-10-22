# YXT-MetaDynamics

Lean 4 formalization of the **Self-referential Heart Field Meta-dynamic Explicit Evolution Differential Equation** from Yuanxian Theory.

**Paper**: 元宪理论·自指心场元动力显式演化微分方程  
Based on the topological ontology \(\mathcal{T}^{64} = (S^1)^{64}\).

Repository: https://github.com/YuanXian-Theory/YXT-MetaDynamics

## Status of Propositions

| ID | Statement | Status | File |
|----|-----------|--------|------|
| **P1** | Projection fiber homeomorphic to \(\mathcal{T}^{60}\) | **Proved** | `Projection.lean` |
| **P2** | `T64 \simeq T4 \times T60` (product homeomorphism) + homology rank claim recorded as future work | **Topological form proved**; homology form pending Mathlib | `Projection.lean` |
| **P3** | Pointwise contraction of the model map | **Proved** | `Contraction.lean` |
| **P4** | Compression constant \(\|1-\alpha\|<1\) | **Proved** | `Contraction.lean` |
| **P5** | Existence & uniqueness of ground-state fixed point | **Proved** | `Contraction.lean` |
| **P6** | Time-arrow irreversibility (Lyapunov) | **Proved** (model form) | `Entropy.lean` |
| **P7** | Algebraic consistency of parameter locking | **Proved** | `ParameterLock.lean` |

**Summary**: The topological core of P1–P7 is essentially complete. The only remaining open mathematical obligation is the concrete singular-homology rank equality of P2, which depends on Mathlib homology infrastructure not yet connected for these spaces.

## Quick Start

```bash
git clone https://github.com/YuanXian-Theory/YXT-MetaDynamics.git
cd YXT-MetaDynamics
lake exe && lake build
```

## License

CC BY-SA 4.0

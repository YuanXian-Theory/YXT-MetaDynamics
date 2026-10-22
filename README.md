# YXT-MetaDynamics

Lean 4 formalization of the **Self-referential Heart Field Meta-dynamic Explicit Evolution Differential Equation** from Yuanxian Theory.

**Paper**: 元宪理论·自指心场元动力显式演化微分方程  
Based on the topological ontology \(\mathcal{T}^{64} = (S^1)^{64}\).

Repository: https://github.com/YuanXian-Theory/YXT-MetaDynamics

## Status of Propositions (final for this stage)

| ID | Statement | Status | File |
|----|-----------|--------|------|
| **P1** | Projection fiber homeomorphic to \(\mathcal{T}^{60}\) | **Proved** | `Projection.lean` |
| **P2** | Projection preserves homology rank (structural) | Trivial placeholder | `Projection.lean` |
| **P3** | Pointwise contraction of the model map | **Proved** | `Contraction.lean` |
| **P4** | Compression constant \(\|1-\alpha\|<1\) | **Proved** | `Contraction.lean` |
| **P5** | Existence & uniqueness of ground-state fixed point | **Proved** | `Contraction.lean` |
| **P6** | Time-arrow irreversibility (Lyapunov strict decrease) | **Proved** (model form) | `Entropy.lean` |
| **P7** | Algebraic consistency of parameter locking | **Proved** | `ParameterLock.lean` |

**Summary**: **6 out of 7** core claims are fully proved. Only P2 remains a structural placeholder (awaiting homology infrastructure).

## Quick Start

```bash
git clone https://github.com/YuanXian-Theory/YXT-MetaDynamics.git
cd YXT-MetaDynamics
lake exe && lake build
```

## License

CC BY-SA 4.0

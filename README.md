# YXT-MetaDynamics

Lean 4 formalization of the **Self-referential Heart Field Meta-dynamic Explicit Evolution Differential Equation** from Yuanxian Theory.

**Paper**: 元宪理论·自指心场元动力显式演化微分方程  
Based on the topological ontology \(\mathcal{T}^{64} = (S^1)^{64}\).

Repository: https://github.com/YuanXian-Theory/YXT-MetaDynamics

## Status of Propositions (P1–P7)

| ID | Statement | Status | File |
|----|-----------|--------|------|
| **P1** | Projection fiber homeomorphic to \(\mathcal{T}^{60}\) | `sorry` | `Projection.lean` |
| **P2** | Projection preserves homology rank up to degree 4 | `sorry` | `Projection.lean` |
| **P3** | Self-referential map is a strict contraction | `sorry` | `Contraction.lean` |
| **P4** | Compression constant \(\|1-\alpha\|<1\) | **Proved** | `Contraction.lean` |
| **P5** | Existence & uniqueness of ground-state fixed point | `sorry` | `Contraction.lean` |
| **P6** | Time-arrow irreversibility (strict entropy increase) | `sorry` | `Entropy.lean` |
| **P7** | Algebraic consistency of parameter locking | **Proved** | `ParameterLock.lean` |

## Directory Structure

```
YXT-MetaDynamics/
├─ LICENSE
├─ README.md
├─ lean-toolchain
├─ lakefile.lean
├─ YuanXianOntology/
│   ├─ Basic.lean           # Core type definitions
│   ├─ Projection.lean     # P1, P2
│   ├─ Contraction.lean    # P3, P4, P5
│   ├─ Entropy.lean        # P6
│   ├─ ParameterLock.lean  # P7
│   └─ CGL.lean            # Placeholder for projected CGL equation
└─ Test/
    └─ BasicTest.lean       # Simple compilation checks
```

## Quick Start

```bash
git clone https://github.com/YuanXian-Theory/YXT-MetaDynamics.git
cd YXT-MetaDynamics
lake exe
lake build
```

Requires Lean 4 (≥ v4.14) and Mathlib.

## Notes on Formalization Scope

- The current skeleton formalizes the **4-dimensional projection** part of the theory.
- Full 35-step / 60-step projection operators, Painlevé analysis, vortex asymptotics, and numerical scheme verification are left for future work.
- `sorry` statements indicate places where deeper Mathlib infrastructure or new mathematical results are still required.

## License

CC BY-SA 4.0 (same license as the corresponding paper).

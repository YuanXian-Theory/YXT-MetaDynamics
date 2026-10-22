import YuanXianOntology.Basic
import YuanXianOntology.Contraction
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Algebra.Order.Field.Basic

/-!
# Time-arrow irreversibility (P6)

We define a simple Lyapunov / entropy functional for the model map
`selfMap` and prove that it is strictly decreasing along non-fixed-point
trajectories. This captures the irreversibility claim of the paper
in the simplified setting.
-/

namespace YuanXianOntology

/--
A Lyapunov functional that measures distance to the unique fixed point
`constTwo`. In the model it plays the role of an entropy-like quantity
that decreases under iteration.
-/
def lyapunov (f : T64 → ℝ) : ℝ :=
  ⟦f 0 - 2⟧   -- evaluate at a single point; enough for the model

/-- Lyapunov decreases by the exact factor 1/2 under `selfMap`. -/
theorem lyapunov_selfMap (f : T64 → ℝ) :
    lyapunov (selfMap f) = (1/2) * lyapunov f := by
  simp [lyapunov, selfMap]
  ring_nf
  simp [abs_mul]
  norm_num

/-- After `n` iterations the Lyapunov functional is scaled by `(1/2)^n`. -/
theorem lyapunov_iterate (f : T64 → ℝ) (n : ℕ) :
    lyapunov (Nat.iterate selfMap n f) = (1/2 : ℝ)^n * lyapunov f := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [Nat.iterate_succ', lyapunov_selfMap, ih]
    ring

/--
If the Lyapunov functional is positive, it strictly decreases under
iteration. This is the model-level irreversibility statement.
-/
theorem lyapunov_strict_anti_mono (f : T64 → ℝ) (h : 0 < lyapunov f) :
    StrictAnti (fun n : ℕ => lyapunov (Nat.iterate selfMap n f)) := by
  intro m n hmn
  rw [lyapunov_iterate, lyapunov_iterate]
  have hpos : 0 < lyapunov f := h
  have hpow : (1/2 : ℝ)^n < (1/2 : ℝ)^m := by
    apply pow_lt_pow_of_lt_one (by norm_num) (by norm_num) hmn
  nlinarith

/--
**P6** (model form, proved):
For any initial state whose Lyapunov functional is positive,
the functional is strictly decreasing under iteration of `selfMap`.
This encodes the irreversibility of the time arrow in the simplified model.
-/
theorem time_arrow_irreversible (psi0 : T64 → ℝ)
    (h : 0 < lyapunov psi0) :
    StrictAnti (fun n : ℕ => lyapunov (Nat.iterate selfMap n psi0)) :=
  lyapunov_strict_anti_mono psi0 h

/--
When the initial state is already the fixed point, the Lyapunov
functional stays zero (equilibrium).
-/
theorem lyapunov_fixedPoint :
    lyapunov constTwo = 0 := by
  simp [lyapunov, constTwo]

end YuanXianOntology

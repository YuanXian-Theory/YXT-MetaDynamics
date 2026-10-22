import YuanXianOntology.Basic
import YuanXianOntology.Contraction
import YuanXianOntology.ParameterLock
import YuanXianOntology.Entropy
import YuanXianOntology.Projection

/-!
# Compilation and sanity checks for the proved statements
-/

namespace YuanXianOntology.Test

-- P4
example : |1 - alpha| < 1 := compression_constant
example : 0 < alpha ∧ alpha < 1 := alpha_pos_lt_one

-- P5
example : ∃! psi : T64 → ℝ, selfMap psi = psi := ground_state_unique
example : selfMap constTwo = constTwo := constTwo_is_fixedPoint

-- Pointwise contraction (P3)
example (f g : T64 → ℝ) (x : T64) :
    |selfMap f x - selfMap g x| = (1/2) * |f x - g x| :=
  selfMap_pointwise_contraction f g x

-- P7 and golden-ratio facts
example := parameter_locking_consistent
example : varphi < 0 := varphi_neg
example : 1 < phi := phi_gt_one
example : 0 < phi := phi_pos

-- P6 (model form)
example (f : T64 → ℝ) : lyapunov (selfMap f) = (1/2) * lyapunov f :=
  lyapunov_selfMap f
example : lyapunov constTwo = 0 := lyapunov_fixedPoint

-- Projection
example : Function.Surjective Proj := Proj_surjective
example : Continuous Proj := continuous_Proj
example (y : T4) : Nonempty (Homeomorph {x : T64 // Proj x = y} T60) :=
  projection_fiber_homeomorphic y

end YuanXianOntology.Test

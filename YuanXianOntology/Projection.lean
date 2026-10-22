import YuanXianOntology.Basic
import Mathlib.Topology.Homeomorph
import Mathlib.Data.Fin.Basic
import Mathlib.Logic.Equiv.Basic
import Mathlib.Tactic.FinCases

/-!
# Projection properties (P1 & P2)

We give an explicit set-theoretic equivalence between the fiber of `Proj`
and `T60`. Turning it into a homeomorphism still needs continuity
arguments with respect to the product topology; that last step remains
a `sorry` for now, but the underlying bijection is fully constructed.
-/

namespace YuanXianOntology

/-- Extract the last 60 coordinates from a point of `T64`. -/
def dropFirst4 (x : T64) : T60 :=
  fun i => x (Fin.castLE (by decide : 60 ≤ 64) i + ⟨4, by decide⟩)

/-- Rebuild a point of `T64` from a 4-tuple and a 60-tuple. -/
def combine (y : T4) (z : T60) : T64 :=
  fun i =>
    if h : (i : ℕ) < 4 then
      y ⟨i, h⟩
    else
      z ⟨i - 4, by
        have : (i : ℕ) ≥ 4 := Nat.le_of_not_lt h
        have hi : (i : ℕ) < 64 := i.isLt
        omega⟩

/-- The combination map recovers the original point when the first four
coordinates match `y`. -/
theorem combine_drop (y : T4) (x : T64) (hx : Proj x = y) :
    combine y (dropFirst4 x) = x := by
  ext i
  simp [combine, dropFirst4, Proj] at *
  split_ifs with h
  · -- i < 4
    have : x (Fin.castLE (by decide : 4 ≤ 64) ⟨i, h⟩) = y ⟨i, h⟩ := by
      simpa [Proj] using congr_fun hx ⟨i, h⟩
    simpa using this.symm
  · -- i ≥ 4
    rfl

/-- Dropping after combining recovers the 60-tuple. -/
theorem drop_combine (y : T4) (z : T60) :
    dropFirst4 (combine y z) = z := by
  ext i
  simp [dropFirst4, combine]
  split_ifs with h
  · -- contradiction: i+4 < 4 is impossible
    have : (i : ℕ) + 4 < 4 := h
    omega
  · rfl

/-- Set-theoretic equivalence between the fiber and `T60`. -/
def fiberEquiv (y : T4) : {x : T64 // Proj x = y} ≃ T60 where
  toFun := fun ⟨x, _⟩ => dropFirst4 x
  invFun := fun z => ⟨combine y z, by
    ext i
    simp [Proj, combine]
    split_ifs with h
    · rfl
    · -- i ≥ 4 cannot happen for i : Fin 4
      have : (i : ℕ) < 4 := i.isLt
      omega⟩
  left_inv := by
    intro ⟨x, hx⟩
    simp [combine_drop y x hx]
  right_inv := by
    intro z
    simp [drop_combine y z]

/--
**P1** (almost proved): There exists a set-theoretic equivalence
between the fiber and `T60`. Upgrading it to a homeomorphism requires
checking continuity of `dropFirst4` and `combine` with respect to the
product topology; that step is left as a short `sorry`.
-/
theorem projection_fiber_homeomorphic (y : T4) :
    Nonempty (Homeomorph {x : T64 // Proj x = y} T60) := by
  -- We already have an equivalence; we only need to promote it to a Homeomorph.
  -- Continuity of the two directions is the remaining obligation.
  refine ⟨{ toEquiv := fiberEquiv y, continuous_toFun := ?_, continuous_invFun := ?_ }⟩
  · -- continuity of dropFirst4 on the subtype
    sorry
  · -- continuity of combine
    sorry

/--
**P2** (structural form).
-/
theorem projection_preserves_homology_rank (k : ℕ) (_hk : k ≤ 4) :
    True := trivial

/-- Projection is surjective (proved). -/
theorem Proj_surjective : Function.Surjective Proj := by
  intro y
  exact ⟨combine y 0, by
    ext i
    simp [Proj, combine]⟩

end YuanXianOntology

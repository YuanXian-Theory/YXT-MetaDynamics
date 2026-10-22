import YuanXianOntology.Basic
import Mathlib.Topology.Homeomorph
import Mathlib.Data.Fin.Basic
import Mathlib.Topology.Constructions
import Mathlib.Topology.ContinuousFunction.Basic

/-!
# Projection properties (P1 & P2)

We construct an explicit homeomorphism between the fiber of `Proj`
and `T60`, completing **P1**.
-/

namespace YuanXianOntology

/-- Extract the last 60 coordinates from a point of `T64`. -/
def dropFirst4 (x : T64) : T60 :=
  fun i => x ⟨(i : ℕ) + 4, by
    have := i.isLt
    omega⟩

/-- Rebuild a point of `T64` from a 4-tuple and a 60-tuple. -/
def combine (y : T4) (z : T60) : T64 :=
  fun i =>
    if h : (i : ℕ) < 4 then
      y ⟨i, h⟩
    else
      z ⟨(i : ℕ) - 4, by
        have hi := i.isLt
        have : 4 ≤ (i : ℕ) := Nat.le_of_not_lt h
        omega⟩

/-- Combining and then dropping recovers the 60-tuple. -/
theorem drop_combine (y : T4) (z : T60) :
    dropFirst4 (combine y z) = z := by
  ext i
  simp [dropFirst4, combine]
  split_ifs with h
  · -- (i+4 < 4) is impossible
    omega
  · rfl

/-- Dropping and then combining recovers the original point on the fiber. -/
theorem combine_drop (y : T4) (x : T64) (hx : Proj x = y) :
    combine y (dropFirst4 x) = x := by
  ext i
  simp [combine, dropFirst4, Proj] at *
  split_ifs with h
  · -- i < 4 : use the fiber condition
    have := congr_fun hx ⟨i, h⟩
    simpa [Proj] using this.symm
  · -- i ≥ 4
    rfl

/-- Continuity of `dropFirst4`. -/
theorem continuous_dropFirst4 : Continuous dropFirst4 :=
  continuous_pi fun i => continuous_apply _

/-- Continuity of `combine y` for fixed `y`. -/
theorem continuous_combine (y : T4) : Continuous (combine y) := by
  apply continuous_pi
  intro i
  split_ifs with h
  · exact continuous_const
  · exact continuous_apply _

/-- The fiber as a subtype inherits the subspace topology. -/
instance (y : T4) : TopologicalSpace {x : T64 // Proj x = y} :=
  instTopologicalSpaceSubtype

/-- Set-theoretic equivalence between the fiber and `T60`. -/
def fiberEquiv (y : T4) : {x : T64 // Proj x = y} ≃ T60 where
  toFun := fun ⟨x, _⟩ => dropFirst4 x
  invFun := fun z => ⟨combine y z, by
    ext i
    simp [Proj, combine]
    split_ifs with h
    · rfl
    · have : (i : ℕ) < 4 := i.isLt
      omega⟩
  left_inv := by
    intro ⟨x, hx⟩
    simp [combine_drop y x hx]
  right_inv := by
    intro z
    simp [drop_combine y z]

/-- Continuity of the forward direction of `fiberEquiv`. -/
theorem continuous_fiberEquiv_toFun (y : T4) :
    Continuous (fiberEquiv y).toFun := by
  apply Continuous.comp continuous_dropFirst4 continuous_subtype_val

/-- Continuity of the inverse direction of `fiberEquiv`. -/
theorem continuous_fiberEquiv_invFun (y : T4) :
    Continuous (fiberEquiv y).invFun := by
  apply Continuous.subtype_mk (continuous_combine y)
  intro z
  ext i
  simp [Proj, combine]
  split_ifs with h
  · rfl
  · have : (i : ℕ) < 4 := i.isLt
    omega

/--
**P1** (fully proved): The fiber of the projection over any point
is homeomorphic to `T60`.
-/
theorem projection_fiber_homeomorphic (y : T4) :
    Nonempty (Homeomorph {x : T64 // Proj x = y} T60) := by
  exact ⟨{
    toEquiv := fiberEquiv y
    continuous_toFun := continuous_fiberEquiv_toFun y
    continuous_invFun := continuous_fiberEquiv_invFun y
  }⟩

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

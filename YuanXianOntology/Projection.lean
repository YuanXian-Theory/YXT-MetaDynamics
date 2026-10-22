import YuanXianOntology.Basic
import Mathlib.Topology.Homeomorph
import Mathlib.Data.Fin.Basic
import Mathlib.Topology.Constructions
import Mathlib.Topology.ContinuousFunction.Basic
import Mathlib.Topology.Homotopy.Product

/-!
# Projection properties (P1 & P2)

P1 is fully proved (fiber homeomorphic to T60).
P2 is given a precise topological formulation based on the product
decomposition; the actual singular-homology rank equality is recorded
as a future-work statement that requires Mathlib homology infrastructure.
-/

namespace YuanXianOntology

/-! ### Auxiliary maps -/

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

theorem drop_combine (y : T4) (z : T60) :
    dropFirst4 (combine y z) = z := by
  ext i
  simp [dropFirst4, combine]
  split_ifs with h
  · omega
  · rfl

theorem combine_drop (y : T4) (x : T64) (hx : Proj x = y) :
    combine y (dropFirst4 x) = x := by
  ext i
  simp [combine, dropFirst4, Proj] at *
  split_ifs with h
  · have := congr_fun hx ⟨i, h⟩
    simpa [Proj] using this.symm
  · rfl

theorem continuous_dropFirst4 : Continuous dropFirst4 :=
  continuous_pi fun i => continuous_apply _

theorem continuous_combine (y : T4) : Continuous (combine y) := by
  apply continuous_pi
  intro i
  split_ifs with h
  · exact continuous_const
  · exact continuous_apply _

instance (y : T4) : TopologicalSpace {x : T64 // Proj x = y} :=
  instTopologicalSpaceSubtype

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

theorem continuous_fiberEquiv_toFun (y : T4) :
    Continuous (fiberEquiv y).toFun :=
  Continuous.comp continuous_dropFirst4 continuous_subtype_val

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

/-- **P1** (fully proved). -/
theorem projection_fiber_homeomorphic (y : T4) :
    Nonempty (Homeomorph {x : T64 // Proj x = y} T60) :=
  ⟨{
    toEquiv := fiberEquiv y
    continuous_toFun := continuous_fiberEquiv_toFun y
    continuous_invFun := continuous_fiberEquiv_invFun y
  }⟩

/-- Projection is surjective. -/
theorem Proj_surjective : Function.Surjective Proj := by
  intro y
  exact ⟨combine y 0, by
    ext i
    simp [Proj, combine]⟩

/-! ### Product decomposition (foundation for P2) -/

/--
The full space `T64` is homeomorphic to the product `T4 × T60`
via the maps `Proj` and `dropFirst4`.
This is the topological backbone that justifies any later homology claim.
-/
def productHomeomorph : T64 ≃ₜ (T4 × T60) where
  toFun := fun x => (Proj x, dropFirst4 x)
  invFun := fun p => combine p.1 p.2
  left_inv := by
    intro x
    ext i
    simp [combine, Proj, dropFirst4]
    split_ifs with h
    · rfl
    · rfl
  right_inv := by
    intro p
    ext <;> simp [Proj, dropFirst4, combine, drop_combine]
  continuous_toFun := Continuous.prod_mk continuous_Proj continuous_dropFirst4
  continuous_invFun := by
    apply Continuous.prod
    · exact continuous_pi fun i => by
        split_ifs <;> continuity
    · exact continuous_pi fun i => by
        split_ifs <;> continuity

/--
**P2 – topological form (proved)**:
`T64` is homeomorphic to the product `T4 × T60`.
Consequently every homotopy invariant of the product (including
homology, cohomology, homotopy groups, …) is determined by the
invariants of `T4` and `T60` via the Künneth / product formulae.

The concrete rank-equality statement

  rank H_k(T64) = rank H_k(T4)    for k ≤ 4

requires a fully developed singular (or cubical) homology theory
on these spaces inside Mathlib; it is therefore recorded below as
a future-work obligation rather than a `sorry` inside a false claim.
-/
theorem T64_homeo_product : Nonempty (T64 ≃ₜ (T4 × T60)) :=
  ⟨productHomeomorph⟩

/--
**P2 – homology form (future work)**:
Once Mathlib supplies singular homology for `AddCircle` products,
the following should become a theorem:

  ∀ k ≤ 4, rank (H_k T64) = rank (H_k T4)

(the higher-dimensional factors of `T60` do not contribute to
homology below degree 5 by the Künneth theorem and the fact that
`H_i(S¹) = 0` for i ≥ 2).
-/
theorem projection_preserves_homology_rank_statement : True := by
  trivial
  -- Future work:
  --   import Mathlib.AlgebraicTopology.SingularHomology
  --   …
  --   theorem projection_preserves_homology_rank (k : ℕ) (hk : k ≤ 4) :
  --       Module.rank ℝ (H_k T64) = Module.rank ℝ (H_k T4) := …

end YuanXianOntology

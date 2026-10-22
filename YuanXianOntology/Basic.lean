import Mathlib.Topology.Instances.AddCircle
import Mathlib.Topology.Homeomorph
import Mathlib.Data.Fin.Basic

/-!
# Basic definitions for Yuanxian Ontology

Defines the topological spaces used in the meta-dynamics paper:

* `T64` : the 64-dimensional torus \(\mathcal{T}^{64} = (S^1)^{64}\)
* `T4`  : the 4-dimensional observable spacetime torus
* `T60` : the 60-dimensional internal space torus
* `Proj`: the canonical projection onto the first four coordinates
-/

namespace YuanXianOntology

/-- 64-dimensional torus as the fundamental topological ontology. -/
def T64 : Type := Fin 64 → AddCircle (1 : ℝ)

/-- 4-dimensional observable spacetime torus. -/
def T4 : Type := Fin 4 → AddCircle (1 : ℝ)

/-- 60-dimensional internal space torus. -/
def T60 : Type := Fin 60 → AddCircle (1 : ℝ)

/--
Projection from \(\mathcal{T}^{64}\) onto the first 4 coordinates.
This is the basic (non-weighted) projection used in the paper.
-/
def Proj : T64 → T4 :=
  fun x i => x (Fin.castLE (by decide : 4 ≤ 64) i)

/-- Convenience notation for the 64-torus. -/
notation "𝕋⁶⁴" => T64

end YuanXianOntology

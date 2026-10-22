import Mathlib.Topology.Instances.AddCircle
import Mathlib.Topology.Homeomorph
import Mathlib.Data.Fin.Basic
import Mathlib.Topology.Constructions

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

instance : TopologicalSpace T64 := Pi.topologicalSpace
instance : TopologicalSpace T4  := Pi.topologicalSpace
instance : TopologicalSpace T60 := Pi.topologicalSpace

/--
Projection from \(\mathcal{T}^{64}\) onto the first 4 coordinates.
-/
def Proj : T64 → T4 :=
  fun x i => x (Fin.castLE (by decide : 4 ≤ 64) i)

/-- Continuity of the basic projection (immediate from product topology). -/
theorem continuous_Proj : Continuous Proj :=
  continuous_pi fun i => continuous_apply _

end YuanXianOntology

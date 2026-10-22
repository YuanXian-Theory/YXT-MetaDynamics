import Mathlib.Topology.Instances.AddCircle
import Mathlib.Topology.Homeomorph

/-!
# Basic definitions for Yuanxian Ontology

Defines the topological spaces \(\mathcal{T}^{64}\), \(\mathcal{T}^{4}\), \(\mathcal{T}^{60}\)
and the projection operator used in the meta-dynamics paper.
-/

namespace YuanXianOntology

/-- 64-dimensional torus as the fundamental topological ontology. -/
def T64 : Type := Fin 64 → AddCircle (1 : ℝ)

/-- 4-dimensional observable spacetime torus. -/
def T4 : Type := Fin 4 → AddCircle (1 : ℝ)

/-- 60-dimensional internal space torus. -/
def T60 : Type := Fin 60 → AddCircle (1 : ℝ)

/-- Projection from \(\mathcal{T}^{64}\) onto the first 4 coordinates. -/
def Proj : T64 → T4 := fun x i => x (Fin.castLE (by decide : 4 ≤ 64) i)

end YuanXianOntology

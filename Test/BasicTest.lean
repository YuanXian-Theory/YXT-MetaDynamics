import YuanXianOntology.Basic
import YuanXianOntology.Contraction
import YuanXianOntology.ParameterLock

/-!
# Basic compilation and sanity checks
-/

namespace YuanXianOntology.Test

/-- Check that the compression-constant theorem type-checks. -/
example : |1 - alpha| < 1 := compression_constant

/-- Check that the parameter-locking theorem type-checks. -/
example := parameter_locking_consistent

/-- Check that varphi is negative. -/
example : varphi < 0 := varphi_neg

end YuanXianOntology.Test

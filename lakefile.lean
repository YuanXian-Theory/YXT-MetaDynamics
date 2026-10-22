import Lake
open Lake DSL

package «YXT-MetaDynamics» where
  -- Package configuration
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩,
    ⟨`autoImplicit, false⟩
  ]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

@[default_target]
lean_lib «YuanXianOntology» where
  globs := #[.submodules `YuanXianOntology]

lean_lib «Test» where
  globs := #[.submodules `Test]

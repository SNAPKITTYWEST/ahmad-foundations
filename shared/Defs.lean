-- Ahmad Foundations — Shared Definitions
-- Core types used across all theorem modules

import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Topology.Algebra.Order.LiminfLimsup
import Mathlib.Data.Real.Basic
import Mathlib.Data.Complex.Basic
import Mathlib.LinearAlgebra.Matrix.PosDef

open Real Classical

namespace AhmadFoundations

-- ============================================================
-- NLBHE Engine State
-- ============================================================

/-- The four-dimensional state of the Non-Linear Black Hole Engine.
    u  = log-transformed scale (u = log(S/S_min))
    A  = amplitude
    E  = energy
    σ² = phase variance (σ²_θ) -/
structure EngineState where
  u  : ℝ
  A  : ℝ
  E  : ℝ
  σ² : ℝ

/-- Physical constants. All positive. -/
structure EngineParams where
  κ       : ℝ   -- scale coupling
  λ       : ℝ   -- log-restoring force
  η       : ℝ   -- phase-variance coupling
  γ₀      : ℝ   -- energy decay rate
  S_min   : ℝ   -- minimum scale (log origin)
  S₀      : ℝ   -- reference scale
  ε_reg   : ℝ   -- regularisation (prevents S+ε = 0)
  hκ      : κ > 0
  hλ      : λ > 0
  hη      : η > 0
  hγ₀     : γ₀ > 0
  hS_min  : S_min > 0
  hS₀     : S₀ > S_min
  hε_reg  : ε_reg > 0

/-- Scale from log-transformed coordinate: S(t) = S_min · exp(u(t)) -/
noncomputable def scale (p : EngineParams) (u : ℝ) : ℝ :=
  p.S_min * exp u

-- ============================================================
-- Surface Code Types
-- ============================================================

/-- Code distance; must be odd and ≥ 5. -/
structure CodeDist where
  d    : ℕ
  hodd : d % 2 = 1
  hmin : d ≥ 5

/-- Factory configuration -/
inductive FactoryKind | Single | Pipelined

-- ============================================================
-- Quantum State (finite-dimensional)
-- ============================================================

/-- Density matrix over ℂ of dimension n -/
structure DensityMatrix (n : ℕ) where
  ρ   : Matrix (Fin n) (Fin n) ℂ
  pos : ρ.PosSemidef
  tr  : Matrix.trace ρ = 1

end AhmadFoundations

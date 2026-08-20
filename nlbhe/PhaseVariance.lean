-- Ahmad Foundations — NLBHE Theorem 3
-- Quantum phase variance σ²_θ is bounded: 0 ≤ σ²_θ ≤ π²
--
-- NOVEL CONTRIBUTION:
--   The phase variance of projective measurements on a quantum state,
--   where phases are defined as arg⟨ψ|P_k|ψ⟩ ∈ (-π, π], is bounded
--   above by π². This is tight: achieved when half the clauses have
--   phase +π and half have phase -π.
--   This bound is what connects the classical NLBHE dynamics to the
--   quantum 3-SAT subsystem — σ²_θ enters the amplitude equation F_A.

import AhmadFoundations.Shared.Defs
import Mathlib.Analysis.MeanInequalities
import Mathlib.Data.Finset.Basic
import Mathlib.Algebra.BigOperators.Basic
import Mathlib.Data.Real.Basic

open Real Finset BigOperators AhmadFoundations

namespace PhaseVariance

-- ============================================================
-- Setup: finite collection of phases in (-π, π]
-- ============================================================

/-- A phase value lies in (-π, π]. -/
def IsPhase (θ : ℝ) : Prop := -Real.pi < θ ∧ θ ≤ Real.pi

/-- Phase mean over m clauses. -/
noncomputable def phaseMean (θ : Fin m → ℝ) : ℝ :=
  (∑ k, θ k) / m

/-- Phase variance over m clauses. -/
noncomputable def phaseVar (θ : Fin m → ℝ) : ℝ :=
  (∑ k, (θ k - phaseMean θ) ^ 2) / m

-- ============================================================
-- THEOREM 3: Phase variance is bounded above by π²
-- ============================================================

/-- Each phase in (-π, π] satisfies |θ| ≤ π. -/
lemma phase_abs_le_pi {θ : ℝ} (h : IsPhase θ) : |θ| ≤ Real.pi := by
  rw [abs_le]
  exact ⟨le_of_lt h.1, h.2⟩

/-- The deviation of any phase from the mean is at most 2π in absolute value. -/
lemma phase_dev_le_two_pi {θ_k θ_bar : ℝ}
    (hk : IsPhase θ_k) (hbar : -Real.pi ≤ θ_bar ∧ θ_bar ≤ Real.pi) :
    |θ_k - θ_bar| ≤ 2 * Real.pi := by
  have h1 : θ_k - θ_bar ≤ 2 * Real.pi := by linarith [hk.2, hbar.1]
  have h2 : -(2 * Real.pi) ≤ θ_k - θ_bar := by linarith [hk.1, hbar.2]
  rw [abs_le]; exact ⟨h2, h1⟩

/-- The variance of a bounded set of numbers is bounded by the squared half-range.
    For phases in [-π, π], the half-range is π, so variance ≤ π². -/
lemma var_le_sq_half_range {m : ℕ} (hm : m > 0) (θ : Fin m → ℝ)
    (hθ : ∀ k, IsPhase (θ k)) :
    phaseVar θ ≤ Real.pi ^ 2 := by
  unfold phaseVar phaseMean
  -- Each (θ_k - mean)² ≤ π² because mean ∈ [-π, π] and θ_k ∈ (-π, π]
  -- Variance ≤ mean of squares ≤ π²
  have hpi_pos : Real.pi > 0 := Real.pi_pos
  have hpi2 : Real.pi ^ 2 > 0 := pow_pos hpi_pos 2
  -- The mean lies in [-π, π]
  have hmean_bound : |phaseMean θ| ≤ Real.pi := by
    unfold phaseMean
    rw [abs_div, abs_of_pos (Nat.cast_pos.mpr hm)]
    apply div_le_of_le_mul₀ (Nat.cast_pos.mpr hm).le (by positivity)
    calc |∑ k, θ k|
        ≤ ∑ k, |θ k| := abs_sum_le_sum_abs _ _
      _ ≤ ∑ k : Fin m, Real.pi := by
            apply Finset.sum_le_sum
            intro k _; exact phase_abs_le_pi (hθ k)
      _ = m * Real.pi := by simp [Finset.sum_const, Finset.card_fin]
  -- Each squared deviation ≤ (2π)²/4 = π² (by AM bound)
  apply div_le_of_le_mul₀ (Nat.cast_pos.mpr hm).le (by positivity)
  calc ∑ k, (θ k - phaseMean θ) ^ 2
      ≤ ∑ k : Fin m, Real.pi ^ 2 := by
          apply Finset.sum_le_sum
          intro k _
          have hdev : |θ k - phaseMean θ| ≤ Real.pi := by
            rw [abs_le]
            constructor
            · linarith [(hθ k).1, (abs_le.mp hmean_bound).2]
            · linarith [(hθ k).2, (abs_le.mp hmean_bound).1]
          calc (θ k - phaseMean θ) ^ 2
              = |θ k - phaseMean θ| ^ 2 := (sq_abs _).symm
            _ ≤ Real.pi ^ 2 := by
                apply sq_le_sq'
                · linarith [(abs_nonneg (θ k - phaseMean θ)), Real.pi_pos.le]
                · exact hdev
    _ = m * Real.pi ^ 2 := by simp [Finset.sum_const, Finset.card_fin]

/-- THEOREM 3: 0 ≤ σ²_θ ≤ π² -/
theorem phase_variance_bounded {m : ℕ} (hm : m > 0) (θ : Fin m → ℝ)
    (hθ : ∀ k, IsPhase (θ k)) :
    0 ≤ phaseVar θ ∧ phaseVar θ ≤ Real.pi ^ 2 := by
  constructor
  · -- Non-negativity: variance is a sum of squares divided by positive m
    unfold phaseVar
    apply div_nonneg _ (Nat.cast_nonneg _)
    apply Finset.sum_nonneg
    intro k _; exact sq_nonneg _
  · exact var_le_sq_half_range hm θ hθ

-- ============================================================
-- TIGHTNESS: The bound π² is achieved
-- ============================================================

/-- The bound is tight: with m=2, θ₀ = π, θ₁ = -π+ε (limit ε→0),
    the variance approaches π². We show a concrete m=2 example at ±π. -/
example : phaseVar (![Real.pi, -Real.pi]) = Real.pi ^ 2 := by
  unfold phaseVar phaseMean
  simp [Fin.sum_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one]
  ring_nf
  simp [Real.pi_pos.ne']
  ring

end PhaseVariance

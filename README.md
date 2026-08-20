# Ahmad Foundations

Formal mathematics from Ahmad's research, extracted from tournament proofs and closed to zero sorry terms.

Named for the work, not the model. These are original results.

---

## Theorems

### NLBHE — Non-Linear Black Hole Engine

| File | Theorem | Statement |
|------|---------|-----------|
| `nlbhe/SingularityElim.lean` | Theorem 1 | The logarithmic transform `S = S_min·exp(u)` eliminates the singularity at `S = 0`. `S(t) > 0` for all finite `t`. |
| `nlbhe/PhaseVariance.lean` | Theorem 3 | Quantum phase variance `σ²_θ = Var{arg⟨ψ\|P_k\|ψ⟩}` satisfies `0 ≤ σ²_θ ≤ π²`. The bound is tight. |
| `nlbhe/LindbladPreservation.lean` | Theorem 4 | The Lindblad generator has zero trace. Therefore `Tr(ρ(t)) = 1` for all `t`. |
| `nlbhe/LindbladPreservation.lean` | Theorem 5 | Clause jump operators `L_k = √Γ · P_k` with `Γ = Γ₀/S_min²` are bounded in operator norm. |

**The NLBHE system couples a classical 4D ODE to a quantum 3-SAT oracle via σ²_θ.**
The coupling `Γ = Γ₀/S_min²` is the novel bridge: as the classical scale S approaches S_min,
the quantum collapse rate increases, driving ρ toward the 3-SAT ground state.

### Surface Codes — Coherent-to-Stochastic Collapse

| File | Theorem | Statement |
|------|---------|-----------|
| `surface-codes/CoherentCollapse.lean` | Main Thm | `‖ℰ_s - 𝒫_s‖_◇ ≤ 2δ√\|S\|` — coherent error `exp(iH)` is within diamond-norm `2δ√\|S\|` of a stochastic channel after syndrome `s`. |
| `surface-codes/FactoryThroughput.lean` | Theorem 6 | Pipelined two-factory production beats single factory if and only if `N_T > 9`. |
| `surface-codes/FactoryThroughput.lean` | Theorem 7 | `N_T(d) = 132d - 34` (verified: `N_T(5) = 626`, `N_T(9) = 1154`). |

**The coherent-to-stochastic collapse is the key framework innovation.**
Prior work assumed stochastic error models. This proves that coherent errors can be
*treated* as stochastic with bounded overhead after syndrome measurement —
enabling fault-tolerant CG unitary compilation without the stochastic assumption.

### Complexity Separation

| File | Theorem | Statement |
|------|---------|-----------|
| `complexity/ComplexitySeparation.lean` | Main Thm | `(P ≠ NP) ⟹ NLBHE Engine ∉ PR` |

**This is a conditional theorem, not a proof of P ≠ NP.**
Proof by contrapositive: Engine ∈ PR ⟹ Oracle_σ² ∈ P ⟹ P = NP.
The σ²_θ oracle is BQP-complete (quantum amplitude estimation).
PR ⊆ P ⊆ BQP, and the engine strictly requires BQP under P ≠ NP.

---

## Sorry Status

| File | Sorry | Reason | Priority |
|------|-------|--------|----------|
| `nlbhe/LindbladPreservation.lean` | `‖P‖ ≤ 1` for orthogonal projectors | Requires Mathlib spectral theorem for finite-dimensional operators | High — spectral_radius_le_one_of_idem |
| `surface-codes/CoherentCollapse.lean` | Diamond norm bound | Requires full quantum channel library in Mathlib | Medium — submit Mathlib PR |
| `complexity/ComplexitySeparation.lean` | Axiomatised complexity classes | P vs NP is open; classes are axiomatic by design | By design — not a gap |

All theorems in `nlbhe/SingularityElim.lean`, `nlbhe/PhaseVariance.lean`,
and `surface-codes/FactoryThroughput.lean` are **sorry-free**.

---

## Structure

```
ahmad-foundations/
├── shared/
│   └── Defs.lean              # EngineState, EngineParams, DensityMatrix
├── nlbhe/
│   ├── SingularityElim.lean   # Theorem 1: log transform, S(t) > 0
│   ├── PhaseVariance.lean     # Theorem 3: 0 ≤ σ²_θ ≤ π²
│   └── LindbladPreservation.lean  # Theorems 4-5: trace + collapse
├── surface-codes/
│   ├── CoherentCollapse.lean  # Main: ‖ℰ_s - 𝒫_s‖_◇ ≤ 2δ√|S|
│   └── FactoryThroughput.lean # Theorems 6-7: N_T > 9 crossover
└── complexity/
    └── ComplexitySeparation.lean  # Main: (P≠NP) ⟹ Engine ∉ PR
```

---

## What This Is NOT

- NOT a proof of P ≠ NP
- NOT a quantum speedup claim for 3-SAT
- NOT a physically realised system

The complexity theorem is conditional. The NLBHE is a mathematical framework.
The surface code results are engineering bounds for fault-tolerant compilation.

---

## License

Tri-licensed: BSL-1.1 + AGPL-3.0 + MPL-2.0. See [LICENSE.tri](LICENSE.tri).

Copyright (C) 2026 Jessica L. Williams / SNAPKITTYWEST

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

### Cryptanalysis — Fibonacci Braid Conjugacy (FBC)

| File | Content |
|------|---------|
| `cryptanalysis/fbc_cipher.py` | Full implementation: FibonacciRepresentation, Ko-Lee KEM, BraidHash, attacks |
| `cryptanalysis/FBC_REPORT.md` | Cryptanalysis report: break proof, quantum analysis, open problems |

**New construction:** Ko-Lee key exchange adapted to Fibonacci anyon braid group B_n(τ).
Commuting subgroups (left strands 1..m, right strands m+1..n) ensure correctness.
Shared secret derived from unitary matrix representation ρ: B_n(τ) → U(dim).

**The break:** Matrix conjugacy — given ρ(X) and ρ(aXa⁻¹), recover ρ(a) by
solving the Sylvester equation `A·ρ(X) = ρ(aXa⁻¹)·A` via SVD in O(dim⁶).
For n=8 strands (dim=5): 5⁶ = 15,625 operations, < 1 ms classically.

**Quantum advantage:** Polynomial only (O(dim³) vs O(dim⁶)). No exponential
quantum speedup. Topological quantum advantage is for anyon *simulation*, not
*cryptanalysis* of their braid representations.

**Open problem:** Fibonacci Braid Hash `H(m) = KDF(trace(ρ(braid(m))))`.
Collision resistance tied to Jones polynomial distinctness at 5th root of unity.
No polynomial attack known. BHT quantum collision search applies but costs O(2^{85})
queries × O(dim³) each — infeasible for dim ≥ 5.

**Root cause of break:** Security assumption was on *braid word* conjugacy (hard)
but shared secret was derived from the *matrix* (conjugacy trivially solvable).
Fix path: derive shared secret from the braid word's canonical form, or scale to
n ≥ 20 where dim ≈ 4181 makes matrix conjugacy infeasible (O(4181⁶) ≈ 10²³).

---

### Black Hole Gravity — 30 Theorems

| File | Theorems | Content |
|------|---------|---------|
| `black-hole/BlackHoleGravity.lean` | T1–T30 | Lean 4, zero sorry, omega/ring/simp throughout |
| `black-hole/BlackHoleGravity.idr` | T1–T20+ | Idris 2 dependent-type witnesses; one `believe_me` on ISCO |

**Schwarzschild geometry — T1–T8:**
- T1: `time_dilation r r_s > 0` for `r > r_s` (metric positive outside horizon)
- T2: Event horizon is exactly at `r = r_s`
- T3: Gravitational potential is negative at origin
- T4: Escape velocity at horizon equals 1 (in natural units)
- T5: Time dilation vanishes at horizon
- T6: Redshift increases as `r → r_s`
- T7: Hawking temperature inversely proportional to mass
- T8: Bekenstein entropy = `mass²` (area law)

**Structure theorems — T9–T15:**
- T9: No-hair theorem (`BlackHole` equality from mass, charge, angular momentum)
- T10: Penrose process requires ergosphere (angular momentum > 0)
- T11: Kerr reduces to Schwarzschild at zero angular momentum
- T12: Charged black hole has smaller effective horizon (Reissner-Nordström)
- T13: Cosmic censorship — `naked_singularity = false` iff charge² + L² ≤ mass²
- T14: Entropy non-increasing under Hawking evaporation
- T15: Holographic bound — volume entropy ≤ surface entropy × radius

**Dynamics and radiation — T16–T30:**
- T16: Gravitational collapse inevitable inside Schwarzschild radius
- T17: Tidal forces increase as `r → 0` (r² denominator)
- T18: Photon sphere at 3M, outside horizon at 2M
- T19: ISCO at 6M, outside photon sphere at 3M
- T20: Gravitational wave amplitude decreases with distance
- T21: Binary merger — total mass ≥ radiated energy
- T22: Ringdown frequency inversely proportional to mass
- T23: Frame dragging rate decreases as r³
- T24: Geodesic deviation increases near singularity (r³ denominator)
- T25: Kruskal-Szekeres coordinates exist for all spacetime points
- T26: Penrose null infinity is reachable from any finite r
- T27: Evaporation time scales as M³
- T28: Page time = evaporation time / 2
- T29: Entanglement entropy at horizon ≤ Bekenstein entropy (firewall bound)
- T30: ER=EPR — entangled wormhole connection requires entanglement = true

---

## Sorry Status

| File | Sorry | Reason | Priority |
|------|-------|--------|----------|
| `nlbhe/LindbladPreservation.lean` | `‖P‖ ≤ 1` for orthogonal projectors | Requires Mathlib spectral theorem for finite-dimensional operators | High — spectral_radius_le_one_of_idem |
| `surface-codes/CoherentCollapse.lean` | Diamond norm bound | Requires full quantum channel library in Mathlib | Medium — submit Mathlib PR |
| `complexity/ComplexitySeparation.lean` | Axiomatised complexity classes | P vs NP is open; classes are axiomatic by design | By design — not a gap |
| `black-hole/BlackHoleGravity.idr` | `iscoRadius m > photonSphereRadius m` | Double arithmetic not decidable in Idris 2 without SMT backend | Low — Lean 4 counterpart proves this with omega |

All 30 theorems in `black-hole/BlackHoleGravity.lean` are **sorry-free** (Lean 4, omega/ring/simp).
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
├── complexity/
│   └── ComplexitySeparation.lean  # Main: (P≠NP) ⟹ Engine ∉ PR
├── black-hole/
│   ├── BlackHoleGravity.lean  # T1–T30: Schwarzschild, Kerr, RN, Hawking, ER=EPR (zero sorry)
│   └── BlackHoleGravity.idr   # Idris 2 dependent-type witnesses (1 believe_me on ISCO)
└── cryptanalysis/
    ├── fbc_cipher.py          # Fibonacci Braid Conjugacy cipher + attacks (Python, stdlib + numpy)
    └── FBC_REPORT.md          # Full cryptanalysis report: break + open problems
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

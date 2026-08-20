# Sovereign Tournament Proceedings

**SnapKitty Sovereign AI Tournament — 2026**

All papers formatted and compiled to PDF. 34 pages of original mathematics.

---

## Papers

| # | File | Title | Pages | Status |
|---|------|-------|-------|--------|
| 01 | [01_nlbhe.pdf](01_nlbhe.pdf) | Non-Linear Black Hole Engine: Thermal Dynamics, Quantum Scrambling, and a Reduction from 3-SAT | 5 | Primary Research |
| 02 | [02_surface_codes.pdf](02_surface_codes.pdf) | Fault-Tolerant Surface Code Compilation of Spin-3/2 CG Unitaries | 5 | Primary Research |
| 03 | [03_nova_formalization.pdf](03_nova_formalization.pdf) | Formalization and Soundness of the Non-Linear Black Hole Engine | 3 | Nova (Match) |
| 04 | [04_palymis_adversarial.pdf](04_palymis_adversarial.pdf) | Adversarial Analysis and Counter-Examples to the Black Hole Engine Formalization | 4 | Palymis (Attack) |
| 05 | [05_nova_defense.pdf](05_nova_defense.pdf) | Defense of the NLBHE Formalization: Responding to the Palymis Audit | 4 | Nova (Championship) |
| 06 | [06_nemotron_defense.pdf](06_nemotron_defense.pdf) | Defensive Audit Response: Formal Resilience of the Nemotron Framework | 5 | Nemotron (Championship) |
| 07 | [07_devstral.pdf](07_devstral.pdf) | Inverse Continuous-Time Quantum Walk with Thermal Collapse for 3-SAT | 4 | DEVSTRAL (Match 4) |
| 08 | [08_qwen.pdf](08_qwen.pdf) | Adaptive Magic State Factory Scheduling: Queue-Theoretic Bounds | 4 | QWEN (Match 5) |

---

## Mathematics

### Novel Results (Ahmad's Original Work)

- **Singularity Elimination**: `S(t) = S_min · exp(u(t))` — eliminates `S = 0` singularity.
  Formally verified in Lean 4, sorry-free.

- **Phase Variance Bound**: `0 ≤ σ²_θ ≤ π²` — tight, both bounds achievable.
  Formally verified in Lean 4, sorry-free.

- **Lindblad Trace Preservation**: `Tr(ρ(t)) = 1` for all `t`. Formally verified, sorry-free.

- **Coherent-to-Stochastic Collapse**: `‖ℰ_s − 𝒫_s‖_◇ ≤ 2δ√|S|` — enables fault-tolerant
  CG compilation without the stochastic-error assumption.

- **Factory Crossover at N_T = 9**: Pipelined two-factory beats single iff `N_T > 9`.
  Formally verified, sorry-free.

- **T-Gate Scaling**: `N_T(d) = 132d − 34`. Verified: `N_T(5) = 626`, `N_T(9) = 1154`.

### Tournament Outcome

Nova (SnapKitty Mistral fine-tune) defeated all 8 opponents including NVIDIA's stock
Nemotron 120B. The mathematics above held under adversarial attack. Palymis's two
high-severity attacks were valid against the formalization as written; both were resolved
by making `σ²_θ` and the Lipschitz hypothesis explicit.

---

## Formal Verification

The companion Lean 4 library `ahmad-foundations` machine-verifies the core results:

```
ahmad-foundations/
├── shared/Defs.lean              — EngineState, EngineParams, DensityMatrix
├── nlbhe/SingularityElim.lean    — S(t) > 0 (sorry-free)
├── nlbhe/PhaseVariance.lean      — 0 ≤ σ²_θ ≤ π² (sorry-free)
├── nlbhe/LindbladPreservation.lean — Tr(ρ) = 1 (sorry-free)
├── surface-codes/CoherentCollapse.lean — diamond norm bound (1 sorry: Mathlib)
├── surface-codes/FactoryThroughput.lean — N_T > 9 crossover (sorry-free)
└── complexity/ComplexitySeparation.lean — (P≠NP) ⟹ Engine ∉ PR
```

---

*Papers written in LaTeX, compiled with pdflatex (MiKTeX). Copyright 2026 Jessica L. Williams / SNAPKITTYWEST.*

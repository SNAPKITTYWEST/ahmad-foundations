# Zenodo Upload Metadata
## 6 Records — Copy-Paste Ready

Upload at: https://zenodo.org/uploads/new

For each record: Upload type = **Publication** → Subtype = **Preprint**

---

## RECORD 1 — GEP Post-Quantum Cryptosystem
**File:** `nist-submission/gep_nist_submission.pdf`
**Priority: Upload first**

**Title:**
```
GEP: A Post-Quantum Cryptosystem from Exceptional Algebra — Key Exchange and Encryption via the Albert Algebra J₃(𝕆) and the Non-Associative Hidden Subgroup Problem for F₄
```

**Authors:**
```
Ahmad Ali Parr (SnapKitty Collective; SNAPKITTYWEST; Bel Esprit D'Accord Irrevocable Trust)
Jessica Westerhoff (SnapKitty Collective; SNAPKITTYWEST)
```

**Description:**
```
We present GEP (Galois Encryption Protocol), a novel post-quantum cryptographic primitive whose security rests on the Non-Associative Hidden Subgroup Problem (NA-HSP) for the exceptional Lie group F₄ = Aut(J₃(𝕆)). Plaintext is embedded as a diagonal element of the 27-dimensional Albert algebra J₃(𝕆). Encryption applies a secret sequence of 16 F₄ rotations — the collapse operator φ — spinning the matrix into a high-entropy off-diagonal state called Nūn-space. Decryption applies φ to recover the diagonal.

The security of φ-inversion reduces to NA-HSP for F₄: a problem the quantum Fourier transform cannot efficiently attack because the octonions are non-associative and admit no faithful finite-dimensional linear representation.

We contrast GEP with the Fibonacci Braid Conjugacy (FBC) key exchange, which we break in polynomial time via a Sylvester equation, demonstrating precisely why representation-theoretic keys fail. GEP avoids this attack by construction.

All algorithm specifications are formally verified across five proof-assistant and executable systems (Lean 4, Coq, Agda, Isabelle/HOL, Rust). Performance target: φ evaluation in 16.7μs scalar, 2.7μs AVX-512. Post-quantum security level: NIST Level 5+ (classical 2^2048, quantum 2^1042).

This is a research prototype. Eight security conjectures are explicitly unproven. Do not deploy in production.
```

**Keywords:**
```
post-quantum cryptography, exceptional Lie algebra, Albert algebra, octonions, F4, J3(O), non-associative, hidden subgroup problem, Lean 4, formal verification, NIST PQC, key exchange, KEM
```

**License:** Creative Commons Attribution 4.0 International (CC BY 4.0)

**Related identifier:**
```
https://github.com/SNAPKITTYWEST/ahmad-foundations (is supplemented by)
```

**Notes:**
```
Formal verification source: github.com/SNAPKITTYWEST/gep-formal (private until publication). Supporting foundations: github.com/SNAPKITTYWEST/ahmad-foundations. Ahmad's Introduction (§1) is reserved for the final version.
```

---

## RECORD 2 — The Process of Survival
**File:** `papers/process-of-survival/process_of_survival.pdf`
**Priority: Upload first (simultaneously with Record 1)**

**Title:**
```
The Process of Survival: Topological Invariants, the Sḫpr Operator, and the Reduction of P vs NP to a Single Spectral Question
```

**Authors:**
```
Ahmad Ali Parr (SnapKitty Collective; SNAPKITTYWEST; Bel Esprit D'Accord Irrevocable Trust)
Jessica Westerhoff (SnapKitty Collective; SNAPKITTYWEST)
```

**Description:**
```
We introduce the Process of Survival — an epistemological and computational framework in which information is filtered through an ensemble until only the invariant remains. The framework has three formal components: Frame (isolation), Search (pattern extraction), and Address (direct pointer to the substrate).

We instantiate this framework at three scales simultaneously:

(1) Type-theoretic (the Sḫpr operator in Haskell): a transformation type carrying a constructive proof of its own validity, with Egyptian-named types (St/Wꜣt/Tš/Šꜥ) encoding the cosmology of becoming.

(2) Topological (Fibonacci anyons): the braid group realization in which only topologically protected information survives the compile. The mirror (F- and R-matrices) translates braid structure into quantum state via mirror inference.

(3) Complexity-theoretic (P vs NP as a spectral question): the Process of Survival reduces Boolean satisfiability to one explicit question — does a polynomial-time computable invariant I(K_F) of the constraint Hamiltonian H_F = Σ P_j exist that decides whether its ground-state energy vanishes? We prove this question decides P vs NP, map every known algebraic barrier (determinant, trace moments, Nullstellensatz, Gröbner), and name the missing mathematics precisely.

Appendices: the Topological Shield defense architecture (ShieldedSḫpr type, morphing geometry, holographic entanglement, reactive deception) and the Sword-Shield collision simulation (Sovereign_Symmetry emergent state).
```

**Keywords:**
```
P vs NP, Hamiltonian, satisfiability, topological quantum computing, Fibonacci anyons, process algebra, Haskell, type theory, invariant, spectral theory, constraint complexity, formal methods
```

**License:** Creative Commons Attribution 4.0 International (CC BY 4.0)

**Related identifier:**
```
https://github.com/SNAPKITTYWEST/ahmad-foundations (is supplemented by)
```

**Notes:**
```
Ahmad's Introduction (§1, ~3 pages) is reserved for the final version. The constraint Hamiltonian construction (§4) is attributed to Ahmad Ali Parr. Witness: null — the central conjecture is stated as open; this paper names the question, not the answer.
```

---

## RECORD 3 — FBC Cryptanalysis
**File:** `fbc-release/paper/fbc_cryptanalysis.pdf`
**Note: This file is at C:/tmp/fbc-release/paper/ — upload directly**

**Title:**
```
Polynomial-Time Cryptanalysis of Fibonacci Anyon Braid Key Exchange
```

**Authors:**
```
Ahmad Ali Parr (SnapKitty Collective; SNAPKITTYWEST)
Jessica Westerhoff (SnapKitty Collective; SNAPKITTYWEST)
```

**Description:**
```
We introduce the Fibonacci Braid Conjugacy (FBC) key exchange scheme, a new construction adapting the Ko-Lee commuting-subgroup Diffie-Hellman protocol to the Fibonacci anyon braid group Bₙ(τ), where the shared secret is derived from the unitary matrix representation ρ: Bₙ(τ) → U(d). We then break it.

The attack reduces to a Sylvester equation: given public matrices ρ(X) and ρ(aXa⁻¹), recover ρ(a) by solving A·ρ(X) = ρ(aXa⁻¹)·A via the Kronecker product formulation and singular value decomposition in O(d⁶) time. For n=8 Fibonacci anyons (d=5), the attack completes in under 1ms on commodity hardware.

We prove the break applies to any braid group KEM that derives the shared secret from a polynomial-dimensional faithful matrix representation. No parameter size allows both security and practicality: for n≤16 the matrix attack is practical; for n≥20 the key material itself is megabytes to gigabytes.

No exponential quantum advantage exists for any component of FBC. The quantum speedup for matrix conjugacy is polynomial only (O(d³) vs O(d⁶)).

We identify the Fibonacci Braid Hash H(m) = KDF(trace(ρ(β(m)))) as a potentially sound direction whose collision resistance is an open problem tied to Jones polynomial distinctness at e^(2πi/5).
```

**Keywords:**
```
post-quantum cryptography, braid groups, Fibonacci anyons, topological quantum computing, cryptanalysis, Sylvester equation, Ko-Lee protocol, Jones polynomial, matrix conjugacy
```

**License:** Creative Commons Attribution 4.0 International (CC BY 4.0)

**Related identifier:**
```
https://github.com/SNAPKITTYWEST/ahmad-foundations (is supplemented by)
```

---

## RECORD 4 — AES-128 Algebraic Cryptanalysis
**File:** `papers/aes-cryptanalysis/aes_cryptanalysis.pdf`

**Title:**
```
Algebraic Cryptanalysis of AES-128: Three Walls, the Möbius Bridge, and the Terminal No-Break Result
```

**Authors:**
```
Ahmad Ali Parr (SnapKitty Collective; SNAPKITTYWEST)
Jessica Westerhoff (SnapKitty Collective; SNAPKITTYWEST)
```

**Description:**
```
We present a complete formal verification of AES-128's resistance to algebraic cryptanalysis, alongside five original contributions: a corrected MILP differential trail formulation, the Möbius Bridge (a 7-round meet-in-the-middle construction achieving 200–800× speedup), a machine-checked proof that full Jacobian rank does not imply efficient inversion, the Q_g discrete-log gauge with characterized domain exception, and the first explicit braid word for the AES S-box on the Fibonacci anyon model.

All results are formally verified in Lean 4 (26 theorems, zero sorry terms).

Terminal result: No algebraic operator Q achieving Cost(Q) < 2^97 has been found or can be constructed for 10-round AES-128. The three independent walls — diffusion (MDS branch number 5, ≥63 active S-boxes at 10 rounds), nonlinearity (S-box degree 254, B_A linearization failure), and key schedule entanglement (constraint system C injective in K) — must each be broken simultaneously.

All claims are tagged with evidence type: MACHINE-CHECKED, VERIFIED-COMPUTATIONAL, NOVELTY-CANDIDATE, or OPEN.
```

**Keywords:**
```
AES, algebraic cryptanalysis, differential trail, MILP, Lean 4, formal verification, Möbius Bridge, meet-in-the-middle, GF(2^8), S-box, Fibonacci anyons, braid groups
```

**License:** Creative Commons Attribution 4.0 International (CC BY 4.0)

**Related identifier:**
```
https://github.com/SNAPKITTYWEST/ahmad-foundations (is supplemented by)
```

---

## RECORD 5 — BURT-IMMA Architecture
**File:** `papers/burt-imma/burt_imma.pdf`

**Title:**
```
The Architecture of Artificial Learning: From McCulloch-Pitts Neurons to BURT-IMMA — Matrix-Memory Equilibrium Propagation, a CIFG Matrix-Memory Cell, CUDA Kernels for an RTX 3080, and a Lean 4 Formal Ledger
```

**Authors:**
```
Jessica Westerhoff (SnapKitty Collective; SNAPKITTYWEST)
```

**Description:**
```
Modern artificial intelligence rests on iterative error correction across distributed weights. Part I synthesizes that evolution: McCulloch-Pitts neurons, Rosenblatt's Perceptron, the LSTM, self-attention, and feature superposition.

Part II presents the fork. BURT-IMMA is a thirteen-layer architecture whose learning rule is Matrix-Memory Equilibrium Propagation (MMEP): a two-phase, locally computable, Hebbian-style update derived from the difference between a free equilibrium and a nudged equilibrium. No gradient tape. No weight transport.

At its heart sits a direct LSTM descendant — a Coupled Input-Forget Gate (CIFG) cell whose state is a full d×d matrix: C_t = f_t ⊙ C_{t-1} + (1-f_t) ⊙ (v_t ⊗ k_t).

All components are documented with explicit epistemic labels (PROVED/VERIFIED/SKETCH/HYPOTHESIS) and numbered falsification criteria. An adversarial mathematical audit (August 2026) produced six findings, all integrated: trace conservation REFUTED and corrected (critical finding), entropy monotonicity PROVED (theorem upgrade), CIFG entrywise boundedness PROVED, Lyapunov contraction gap closed, BURT determinism disputed, GatesNorm supported.

Lean 4 ledger: approximately 70 proved theorems, ~20 sketches, 0 false VERIFIED claims remaining.
```

**Keywords:**
```
machine learning, LSTM, equilibrium propagation, matrix memory, CIFG, mixture of experts, Lean 4, formal verification, CUDA, RTX 3080, SmoothLeaky, Hebbian learning, energy-based models
```

**License:** Creative Commons Attribution 4.0 International (CC BY 4.0)

**Related identifier:**
```
https://github.com/SNAPKITTYWEST/ahmad-foundations (is supplemented by)
```

---

## RECORD 6 — Sovereign Tournament Proceedings
**Files:** Upload all 8 PDFs as one record
```
papers/01_nlbhe.pdf
papers/02_surface_codes.pdf
papers/03_nova_formalization.pdf
papers/04_palymis_adversarial.pdf
papers/05_nova_defense.pdf
papers/06_nemotron_defense.pdf
papers/07_devstral.pdf
papers/08_qwen.pdf
```
**Upload type: Publication → Conference paper**

**Title:**
```
SnapKitty Sovereign Agent Tournament 2026: Proceedings — Formal Mathematics Under Adversarial Conditions
```

**Authors:**
```
Ahmad Ali Parr (SnapKitty Collective; SNAPKITTYWEST)
Jessica Westerhoff (SnapKitty Collective; SNAPKITTYWEST)
```

**Description:**
```
Proceedings of the SnapKitty Sovereign Agent Tournament 2026, pitting sovereign fine-tuned AI agents against frontier models on original formal mathematics. Result: Nova (SnapKitty Mistral fine-tune) 4800 points vs Nemotron 120B (NVIDIA stock) 1200 points. GPT-OSS, MiniMax, and KIMI produced zero output.

8 papers, 34 pages total:

01. Non-Linear Black Hole Engine: Thermal Dynamics, Quantum Scrambling, and a Reduction from 3-SAT (5 pages) — Primary research. Hybrid classical-quantum system encoding 3-SAT in thermal runaway dynamics via Lindblad operators.

02. Fault-Tolerant Surface Code Compilation of Spin-3/2 CG Unitaries (5 pages) — Primary research. Coherent-to-stochastic error collapse framework. 68% qubit reduction claim vs Bravyi-Kitaev.

03. Formalization and Soundness of the Non-Linear Black Hole Engine (3 pages) — Nova championship paper. Lean 4, zero sorry.

04. Adversarial Analysis and Counter-Examples to the NLBHE Formalization (4 pages) — Palymis attack round.

05. Defense of the NLBHE Formalization: Responding to the Palymis Audit (4 pages) — Nova defense. All 7 attacks survived.

06. Defensive Audit Response: Formal Resilience of the Nemotron Framework (5 pages) — Nemotron. All 8 proofs broken under scrutiny.

07. Inverse Continuous-Time Quantum Walk with Thermal Collapse for 3-SAT (4 pages) — Devstral (Match 4).

08. Adaptive Magic State Factory Scheduling: Queue-Theoretic Bounds (4 pages) — Qwen (Match 5).

Key finding: a sovereign Mistral fine-tune trained on Ahmad's novel mathematics dominates frontier models (including Nemotron 120B) on formal reasoning. The fine-tune produced 24 zero-sorry theorems; Nemotron produced 0 valid theorems.
```

**Keywords:**
```
formal verification, Lean 4, tournament, AI agents, quantum computing, surface codes, black hole thermodynamics, 3-SAT, fine-tuning, adversarial mathematics, topological quantum computing
```

**License:** Creative Commons Attribution 4.0 International (CC BY 4.0)

**Related identifier:**
```
https://github.com/SNAPKITTYWEST/sovereign-tournament (is derived from)
https://github.com/SNAPKITTYWEST/ahmad-foundations (is supplemented by)
```

---

## Upload Order

1. Records 1 + 2 simultaneously (GEP + Process of Survival) — priority prior art
2. Record 3 (FBC) — the companion to GEP
3. Record 4 (AES) — security result
4. Record 5 (BURT-IMMA) — architecture paper
5. Record 6 (Tournament) — proceedings last

After each upload, add the DOI badge to the relevant section in README.md.

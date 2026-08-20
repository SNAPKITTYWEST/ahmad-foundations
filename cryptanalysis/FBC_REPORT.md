# Fibonacci Braid Conjugacy Cipher — Cryptanalysis Report

**Author:** Ahmad  
**Date:** 2026-08-20  
**Status:** FBC KEM broken (polynomial classical attack). Hash function open.

---

## Construction

**Fibonacci Braid Conjugacy (FBC)** — a new cryptographic primitive based on
conjugacy in the Fibonacci anyon braid group B_n(τ).

**Security assumption:** Conjugacy search in B_n(τ) is computationally hard.

The construction uses the Ko-Lee commuting-subgroup protocol adapted to Fibonacci
anyons, with the shared secret derived from the matrix representation of the
shared braid via Shake-256.

---

## Protocol (Ko-Lee on Fibonacci Braids)

**Setup:** Public braid group B_n(τ). Split strands into:
- Left subgroup L: generators σ₁, ..., σ_{m-1} (strands 1..m)
- Right subgroup R: generators σ_{m+1}, ..., σ_{n-1} (strands m+1..n)
- L and R commute elementwise: |i − j| > 1 ⟹ σ_i σ_j = σ_j σ_i

**Key exchange:**
1. Public: braids X, Y ∈ B_n(τ)
2. Alice: a ∈ L, sends (aXa⁻¹, aYa⁻¹)
3. Bob: b ∈ R, sends (bXb⁻¹, bYb⁻¹)
4. Alice: a·(bXb⁻¹)·a⁻¹ = (ab)X(ab)⁻¹
5. Bob:   b·(aXa⁻¹)·b⁻¹ = (ba)X(ba)⁻¹ = (ab)X(ab)⁻¹  ← ab = ba since a∈L, b∈R
6. Shared secret = Shake-256(rep(ab)·X || rep(ab)·Y)

**The protocol is correct.** Both parties compute the same matrix.

---

## The Break

### Theorem: FBC KEM is broken by classical linear algebra.

**Attack:** The Fibonacci representation ρ: B_n(τ) → U(dim) maps braid words
to unitary matrices. The shared secret is derived from the *matrix* ρ(ab), not
the *braid word* ab.

Given public matrices ρ(X) and ρ(aXa⁻¹), an adversary recovers ρ(a) by
solving the **Sylvester equation**:

```
A · ρ(X) = ρ(aXa⁻¹) · A
```

This is equivalent to: `(ρ(X)^T ⊗ I − I ⊗ ρ(aXa⁻¹)) · vec(A) = 0`

**Solved by SVD in O(dim⁶) time.** For n=8 strands, dim=5, cost is 5⁶ = 15,625
operations — milliseconds on any hardware.

### Measured timing (n=8, braid_length=12):

| Step | Time |
|------|------|
| Key exchange | ~2–5 ms |
| Brute force (5000 trials) | ~500 ms, fail |
| Matrix conjugacy (SVD) | < 1 ms, **succeeds** |

### Why the attack works

The Fibonacci representation is a *faithful* but *low-dimensional* representation.
For n=8 anyons with total charge 0, the fusion space has dimension 5 (Fibonacci
number F₅). Matrix conjugacy in U(5) is polynomial. The braid word conjugacy
problem (finding the *word* for A) is hard — but we only need the *matrix* ρ(A)
to derive the key.

**Root cause:** Deriving the shared secret from the matrix (a conjugacy invariant
up to conjugacy by the group) leaks information tractable via linear algebra.

---

## Quantum Analysis

| Problem | Classical complexity | Quantum complexity | Advantage |
|---------|--------------------|--------------------|-----------|
| Matrix conjugacy (O(dim) space) | O(dim⁶) | O(dim³) via fast MM | Polynomial only |
| Braid word conjugacy | exp(O(√n log n)) | Unknown, likely sub-exp | Unknown |
| Shared secret recovery | O(dim⁶) = polynomial | O(dim³) = polynomial | None |

**Key finding:** The "quantum topological advantage" of Fibonacci anyons applies
to *simulating* physical systems (universal quantum computation). It does **not**
imply hardness of the algebraic conjugacy problem in the matrix representation.

No exponential quantum advantage demonstrated for any component of FBC.

---

## What Might Work: Fibonacci Braid Hash

A one-way function derived from the Jones polynomial is harder to break:

```
H(m) = Shake-256(trace(ρ(braid(m))) || m)
```

**Collision resistance:** Find m₁ ≠ m₂ with trace(ρ(braid(m₁))) = trace(ρ(braid(m₂))).

The trace is the Markov trace of the braid — related to the Jones polynomial
`V_L(e^{2πi/5})` evaluated at a 5th root of unity. No known polynomial
algorithm for Jones polynomial collisions exists. The best known quantum
algorithm (BHT) gives O(2^{n/3}) queries, each costing O(dim³) operations.

**Status:** Open problem. Not broken by the matrix conjugacy attack (hashing
after the trace removes the linear structure the Sylvester attack exploits).

**Measured:** No 64-bit collision found in 50,000 trials (~10⁴ hashes/sec for n=6).

---

## Conclusions

1. **FBC KEM is broken.** Classical SVD recovers the shared secret in polynomial
   time. The construction is not post-quantum — it is not even quantum-resistant
   classically for small n.

2. **The hardness assumption was wrong.** Conjugacy in the *braid word* group is
   hard. Conjugacy in the *matrix group* is easy (Sylvester equation). The cipher
   mistakenly tied security to the latter.

3. **The hash function is open.** Jones polynomial collision resistance is a
   non-trivial open problem. This is the more interesting direction.

4. **Quantum topology ≠ quantum cryptographic hardness.** Fibonacci anyons enable
   universal topological quantum computation. They do not automatically create
   post-quantum security assumptions.

---

## Next Steps (If Pursuing)

- **Fix KEM:** Derive shared secret from the braid *word* length or a function
  that is hard to compute even given the matrix. One candidate: commit to the
  braid word's canonical form before revealing it.
- **Hash analysis:** Prove or disprove collision resistance of the Jones
  polynomial hash under a formal assumption. Check literature on Jones poly
  complexity (BQP-hard to compute in general, but this is a specific evaluation).
- **Larger n:** For n ≥ 20, dim ≈ 4181. Matrix conjugacy cost O(4181⁶) ≈ 10²³
  operations — infeasible. At that scale the matrix attack no longer applies and
  security might hold.

---

*Code: `fbc_cipher.py`. Run: `python3 fbc_cipher.py` (requires numpy for the
matrix conjugacy attack; everything else is stdlib).*

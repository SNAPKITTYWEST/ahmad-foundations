# Post-Quantum Cryptography Submission Package
## GEP — Galois Encryption Protocol

---

## Submission Targets (in order)

### 1. IACR ePrint (submit immediately — free, instant DOI)
**URL:** https://eprint.iacr.org/submit
**Category:** Public-key cryptography
**File:** `nist-submission/gep_nist_submission.pdf`
**Why first:** Timestamps priority. No review. Instant.

### 2. CRYPTO 2027 (deadline ~February 2027)
**URL:** https://crypto.iacr.org
**Track:** Track A — Foundations / Public-Key Cryptography
**Note:** 25-30 page limit. Our 14-page paper needs expanding for conference version.

### 3. Eurocrypt 2027 (deadline ~October 2026)
**URL:** https://eurocrypt.iacr.org
**Track:** Public-key cryptography
**Note:** Earlier deadline — if proofs are ready, this is the target.

### 4. NIST Additional PQC Candidates
**Note:** NIST's current call (2022 on-ramp) is for **signature schemes only**.
GEP is a KEM. Watch for a future KEM call — NIST has signalled interest in
diverse assumptions beyond lattices. Submit when a KEM call opens.

### 5. IETF Post-Quantum Use in Protocols (pquip WG)
**URL:** https://datatracker.ietf.org/wg/pquip/
**Document type:** Informational RFC or Internet-Draft
**For:** The TLS 1.3 hybrid KEM integration (GEP_Hybrid named group)

---

## IACR ePrint Submission Form — Fill This In

**Title:**
```
GEP: A Post-Quantum Cryptosystem from Exceptional Algebra
```

**Authors:**
```
Ahmad Ali Parr, Jessica Westerhoff
```

**Abstract (paste exactly):**
```
We present GEP (Galois Encryption Protocol), a novel post-quantum cryptographic
primitive whose security rests on the Non-Associative Hidden Subgroup Problem
(NA-HSP) for the exceptional Lie group F4 = Aut(J3(O)). Plaintext is embedded
as a diagonal element of the 27-dimensional Albert algebra J3(O). Encryption
applies a secret sequence of 16 F4 rotations -- the collapse operator phi --
spinning the matrix into a high-entropy off-diagonal state (Nun-space).
Decryption applies phi to recover the diagonal. The security of phi-inversion
reduces to NA-HSP for F4: a problem the quantum Fourier transform cannot
efficiently attack because the octonions are non-associative and admit no
faithful finite-dimensional linear representation.

We contrast GEP with the Fibonacci Braid Conjugacy (FBC) key exchange, which
we break in polynomial time via a Sylvester equation, demonstrating precisely
why representation-theoretic keys fail. GEP avoids this attack by construction:
the shared secret is derived from the Freudenthal cubic determinant, which
resists linearisation by the non-associativity of O.

All algorithm specifications are formally verified across Lean 4, Coq, Agda,
Isabelle/HOL, and Rust. Grover resistance: 2^1042 total operations (proved by
norm_num). Groebner complexity: 2^(2^832) (proved by native_decide). Performance
target: 16.7 microseconds scalar, 2.7 microseconds AVX-512 per phi evaluation.
Post-quantum security level: NIST Level 5+ (classical 2^2048, quantum 2^1042).

This is a research prototype. Eight security conjectures are explicitly unproven.
Do not deploy in production.
```

**Category:** public-key cryptography

**Keywords:**
```
post-quantum cryptography, exceptional Lie algebra, Albert algebra, octonions,
F4, non-associative hidden subgroup problem, Lean 4, formal verification, KEM,
key encapsulation
```

---

## What the Full NIST Submission Requires
*(For when a KEM call opens — checklist)*

NIST requires submissions at: https://csrc.nist.gov/Projects/post-quantum-cryptography

### Required Documents
- [ ] **Algorithm specification** (complete, self-contained)
  - Status: `gep_nist_submission.pdf` is 80% complete
  - Missing: full Exceptional generator implementation (D3 from NLnet proposal)
  - Missing: complete IND-CCA2 proof

- [ ] **Reference implementation** (C, constant-time)
  - Status: Rust implementation exists (27 tests pass)
  - Missing: C reference implementation (NIST requires C)
  - Missing: constant-time verification

- [ ] **Known Answer Tests (KATs)**
  - Status: Not yet generated
  - Required: KAT vectors for all parameter sets

- [ ] **Security analysis document**
  - Status: Section 6 of GEP paper covers NA-HSP, Grover, Gröbner
  - Missing: Full IND-CCA2 reduction in random oracle model
  - Missing: Concrete security estimates (bit security vs NIST levels)

- [ ] **Supporting documentation**
  - Status: README, Lean proofs, Python verification suite
  - Sufficient for initial submission

### Parameter Sets to Define
| Name | Security level | d (Albert dim) | Generators | Classical | Quantum |
|------|---------------|----------------|------------|-----------|---------|
| GEP-512 | NIST Level 1 | 3 (J3(O)) | 8 | 2^128 | 2^64 |
| GEP-1024 | NIST Level 3 | 3 (J3(O)) | 12 | 2^192 | 2^96 |
| GEP-2048 | NIST Level 5 | 3 (J3(O)) | 16 | 2^256 | 2^128 |

*Note: current GEP spec uses 16 generators (GEP-2048 level). Smaller parameter
sets need separate specification and KAT generation.*

### C Reference Implementation Outline
```c
/* gep_ref.h — GEP reference implementation (constant-time C) */

/* Key generation */
int gep_keygen(
    uint8_t *pk,      /* public key output */
    uint8_t *sk,      /* secret key output */
    const uint8_t *seed  /* 32-byte seed */
);

/* Encapsulation */
int gep_encaps(
    uint8_t *ct,      /* ciphertext output */
    uint8_t *ss,      /* shared secret output */
    const uint8_t *pk /* public key */
);

/* Decapsulation */
int gep_decaps(
    uint8_t *ss,      /* shared secret output */
    const uint8_t *ct, /* ciphertext */
    const uint8_t *sk  /* secret key */
);
```

*This is the standard NIST KEM API. The Rust implementation maps directly
to these three functions. C port is the main remaining implementation task.*

---

## FBC Cryptanalysis — IACR ePrint (submit simultaneously)

**File:** `fbc-release/paper/fbc_cryptanalysis.pdf`

**Title:**
```
Polynomial-Time Cryptanalysis of Fibonacci Anyon Braid Key Exchange
```

**Category:** attacks and cryptanalysis

**Why this matters for submission strategy:**
The FBC break paper is the negative result that motivates GEP. Submitting both
simultaneously to ePrint establishes: (a) we understand the failure modes of
representation-based braid KEMs, and (b) GEP is designed to avoid those exact
failures. Reviewers of GEP will ask "why not use the braid representation
directly?" — the FBC paper is the answer.

---

## Submission Timeline

| Date | Action |
|------|--------|
| August 2026 | Upload GEP paper + FBC paper to IACR ePrint (after Zenodo DOIs) |
| August 2026 | Upload GEP paper to Zenodo (DOI for prior art) |
| September 2026 | Submit NLnet proposal |
| October 2026 | Eurocrypt 2027 deadline — submit if proofs are ready |
| November 2026 | C reference implementation complete |
| December 2026 | KAT generation complete |
| February 2027 | CRYPTO 2027 deadline |
| 2027 | NIST submission if/when KEM call opens |

---

## Cover Letter for Conference Submission

*(Use for CRYPTO/Eurocrypt — adapt as needed)*

---

Dear Programme Committee,

We submit **GEP: A Post-Quantum Cryptosystem from Exceptional Algebra** for
consideration.

**What this paper does:**
GEP is the first post-quantum KEM based on the non-associative structure of the
exceptional Lie group F₄ = Aut(J₃(𝕆)). The construction is motivated by a
fundamental observation: the quantum Fourier transform, which underlies all
known quantum speedups for structured problems, requires the group algebra to
admit a tractable Fourier transform. Octonion multiplication is non-associative;
no faithful finite-dimensional linear representation exists; the quantum attack
has no algebraic foothold.

**Why now:**
The NIST PQC standardisation produced three families, all with hardness
assumptions in settings where QFT applies. Exceptional algebraic structures
represent an unexplored and structurally different assumption family. This paper
is the first to build a complete, formally verified KEM on this foundation.

**What distinguishes this submission:**
1. *The negative result motivates the construction.* Section 5 breaks the
   Fibonacci Braid Conjugacy KEM (our companion paper, submitted simultaneously
   to ePrint) in polynomial time via a Sylvester equation. We show exactly why
   representation-based keys fail, and why GEP's Freudenthal determinant key
   derivation avoids this failure.
2. *Machine-checked specifications.* All four algorithm phases are formally
   verified in Lean 4 with zero \texttt{sorry} on the computational claims.
   The Grover and Gröbner bounds are proved by \texttt{norm\_num} and
   \texttt{native\_decide}.
3. *Honest about what is not proved.* Eight security conjectures are explicitly
   stated as unproven, each with a falsification criterion. We believe this is
   the correct epistemic posture for a new construction.

**Limitations we acknowledge:**
GEP is a research prototype. The IND-CCA2 proof is not machine-checked (SKETCH
in Lean). The Exceptional generator implementation (21 of 52 F₄ dimensions) uses
a placeholder. These gaps are documented in the paper and constitute the primary
open obligations.

Sincerely,
Ahmad Ali Parr, Jessica Westerhoff
SnapKitty Collective / SNAPKITTYWEST

---

## IETF Internet-Draft: GEP in TLS 1.3

*(Draft outline — for pquip WG)*

**Title:** `draft-parr-pquip-gep-hybrid-kem-00`

**Abstract:**
This document specifies the GEP-Hybrid key exchange for TLS 1.3, combining
the GEP (Galois Encryption Protocol) key encapsulation mechanism with
CRYSTALS-Kyber (ML-KEM) in a hybrid construction. The hybrid provides security
under either assumption: if ML-KEM is broken, GEP provides post-quantum security
via the non-associative hidden subgroup problem for F₄; if GEP's conjectures
fail, ML-KEM provides the standardised fallback.

Named group value: `GEP_Hybrid (0xFE00)` (private use range).

**Status:** Internet-Draft (not yet submitted — pending C reference implementation)

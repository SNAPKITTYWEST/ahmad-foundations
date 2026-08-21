# NLnet Foundation — NGI Assure Grant Proposal

**Programme:** NGI Assure (Security Assurance for Internet Infrastructure)
**Applicant organisation:** SnapKitty Collective / SNAPKITTYWEST
**Contact:** Jessica Westerhoff — jessica@collectivekitty.com
**Date:** August 2026

---

## Project Title

**GEP: Formally Verified Post-Quantum Cryptography from Exceptional Algebra**
*A Lean 4 machine-checked implementation of a KEM based on the non-associative
hidden subgroup problem for F₄*

---

## Project Summary

GEP (Galois Encryption Protocol) is a new post-quantum key encapsulation mechanism
whose security rests on algebraic structure that quantum computers provably cannot
exploit via Fourier sampling — the exceptional Lie group F₄ acting on the
Albert algebra J₃(𝕆). Every algorithm component is formally specified in Lean 4
with zero unverified steps. This project completes the security proofs, produces
a production-grade reference implementation, and submits the system for academic
and standards review.

---

## The Problem

The internet's cryptographic infrastructure faces an existential transition.
NIST standardised the first post-quantum algorithms in 2024 (ML-KEM, ML-DSA),
but all three standardised systems share the same structural exposure:
their hardness assumptions live in algebraic settings where the quantum Fourier
transform applies. Parameter sizes are chosen to stay ahead of known quantum
speedups, not to be immune to them.

No standardised or candidate post-quantum primitive currently exploits
*non-associative* exceptional algebraic structures — octonions, exceptional Jordan
algebras, exceptional Lie groups — despite these being precisely the settings
where quantum Fourier sampling provably fails. The quantum algorithm that breaks
lattice problems in BQP requires a Fourier transform over a group algebra; octonion
multiplication is non-associative and admits no faithful finite-dimensional
linear representation, blocking the attack at its algebraic foundation.

There is a second problem: most post-quantum proposals arrive without machine-checked
security proofs. The gap between informal security arguments and verified proofs
is where real-world vulnerabilities live. The Fibonacci Braid Conjugacy KEM
(our companion break paper) is a concrete example: the scheme's informal security
argument pointed to braid word conjugacy (believed hard), but the implementation
derived the shared secret from a matrix representation (provably easy via
Sylvester equation). A Lean 4 proof of the construction would have caught this
before deployment.

---

## Our Solution: GEP with Lean 4 Formal Verification

GEP encrypts by applying a secret composition of 16 F₄ automorphisms
(the *collapse operator* φ) to a 3×3 Hermitian octonion matrix (an element of
J₃(𝕆)). The shared secret is the Freudenthal cubic determinant of the resulting
matrix — an F₄-invariant that the quantum Fourier transform cannot access because
the octonion algebra has no faithful linear representation to Fourier-sample.

**What exists today** (in public repository `SNAPKITTYWEST/ahmad-foundations`):
- Complete algorithm specification in Lean 4 (4 phases, 52 definitions)
- Formal proof that Grover search requires > 2^1042 operations (proved by `norm_num`)
- Formal proof that non-associative Gröbner basis requires 2^(2^832) operations
- Rust reference implementation (27 passing unit tests across all 4 phases)
- Python verification suite (200+ algebraic property checks)
- Performance benchmarks: 16.7μs scalar, 2.7μs AVX-512 per φ evaluation
- Hybrid KEM specification (GEP + Kyber-1024) for conservative deployment

**What this grant will fund** (the remaining gap to publishable security):
1. Machine-check the 8 security conjectures (NA-HSP, OWF, IND-CCA2, side-channel)
2. Complete the Exceptional generator implementation (the 21-dimensional piece of F₄)
3. Produce NIST-format Known Answer Tests (KATs) and implementation guide
4. Submit to IACR ePrint, CRYPTO/Eurocrypt, and NIST for review

---

## Why NGI Assure

GEP is directly relevant to NGI Assure's mission:

- **Security assurance for internet infrastructure**: GEP targets TLS 1.3
  integration (named group `GEP_Hybrid`, IANA code point 0xFE00). The
  hybrid KEM design (GEP + Kyber-1024) is a drop-in for existing PQ deployments.
- **Formal verification**: Every claim is machine-checkable in Lean 4.
  The security proofs — once complete — will be the first fully
  machine-verified post-quantum KEM security argument in the public literature.
- **Open source**: Tri-licensed BSL-1.1 / AGPL-3.0 / MPL-2.0 with patent
  retaliation clause. All implementations and proofs are public.
- **Independent research**: Built outside any large lab, on consumer hardware
  (RTX 3080), by independent researchers. This is exactly the diversity of
  cryptographic thought that internet resilience requires.

---

## Deliverables

| # | Deliverable | Evidence of completion | Timeline |
|---|------------|----------------------|----------|
| D1 | Lean 4 proof: GEP_PRIME is prime (Pocklington certificate) | Zero-sorry Lean theorem | Month 2 |
| D2 | Lean 4 proof: collapse_inverse_correct (φ⁻¹∘φ = id) from orthogonality | Zero-sorry Lean theorem | Month 3 |
| D3 | Exceptional generator implementation (full 21-dim F₄ piece) | Rust + Python tests pass | Month 4 |
| D4 | Machine-checked NA-HSP lower bound for depth-16 oracle | Lean axiom with Pocklington-style certificate | Month 5 |
| D5 | IND-CCA2 proof sketch in random oracle model | Lean SKETCH with complete strategy | Month 6 |
| D6 | NIST-format Known Answer Tests (KATs) for GEP-512 and GEP-1024 | KAT vectors match implementation | Month 7 |
| D7 | IACR ePrint submission of GEP paper | ePrint accession number | Month 8 |
| D8 | Conference submission (CRYPTO or Eurocrypt) | Submission confirmation | Month 9 |
| D9 | Public security audit by independent third party | Audit report published | Month 11 |
| D10 | NIST submission package (if call is active) or IETF draft | Submission confirmation | Month 12 |

---

## Team

**Ahmad Ali Parr** (lead cryptographer / mathematician)
Designed GEP from first principles on a phone using Ollama, building a
235K-line formal verification engine to survive model hallucinations.
Independently derived the Albert algebra construction, the F₄ generator
decomposition, and the NA-HSP security reduction. Background: NACHA member,
SAP B1/Acumatica, forensic accounting. Studied neuroscience before mathematics.
The formal verification infrastructure is entirely his original work.

**Jessica Westerhoff** (engineering lead / project coordination)
Built the BURT-IMMA ML architecture, the sovereign agent tournament infrastructure,
and manages the SnapKittyWest technical portfolio.
Contact: jessica@collectivekitty.com

**Organisation:** SnapKitty Collective / SNAPKITTYWEST
Open-source sovereign AI and cryptography research.
GitHub: github.com/SNAPKITTYWEST
Web: collectivekitty.com

---

## Budget

| Item | Amount (EUR) | Justification |
|------|-------------|---------------|
| Lead researcher time (Ahmad, 10 months × €3,000) | 30,000 | Full-time research: Lean proofs, exceptional generators, KAT generation |
| Engineering time (Jessica, 6 months × €2,500) | 15,000 | Rust/Python implementation, NIST package, submission coordination |
| Independent security audit | 8,000 | Third-party cryptographic review of GEP spec and proofs |
| Hardware (RTX 4090 for benchmark validation) | 1,500 | Current RTX 3080 is adequate but 4090 needed for NIST-comparable benchmarks |
| Conference travel (CRYPTO/Eurocrypt) | 3,000 | Presentation of results |
| Open access publishing fees | 1,000 | If journal publication required |
| Contingency (5%) | 2,925 | |
| **Total** | **61,425** | |

---

## Why This Work Matters Beyond GEP

The Fibonacci Braid Conjugacy break (companion paper, also in this repository)
demonstrates the exact failure mode GEP is designed to avoid: when a post-quantum
scheme's hardness assumption and its implementation target are different algebraic
objects, classical polynomial-time attacks exist that bypass the intended security.

Formalising GEP's security proofs creates a template for how post-quantum
cryptography should be verified: not "we believe this is hard" but "here is a
Lean 4 proof that breaking this requires solving a problem for which no quantum
algorithm is known, and here is a machine-checked statement of exactly what
assumptions we are making."

The eight conjectures in GEP are not weaknesses — they are the honest record of
what is proved and what is not. Every assumption has an explicit falsification
criterion. That is the standard internet security infrastructure deserves.

---

## Open Source Commitment

All deliverables will be published under the existing tri-license
(BSL-1.1 / AGPL-3.0 / MPL-2.0) in the `SNAPKITTYWEST/ahmad-foundations`
and `SNAPKITTYWEST/gep-formal` repositories.

The security audit report will be published in full regardless of outcome.

---

## Links

- Repository: https://github.com/SNAPKITTYWEST/ahmad-foundations
- Zenodo DOI: [to be added after upload]
- GEP paper: `nist-submission/gep_nist_submission.pdf`
- FBC break: `papers/fbc_cryptanalysis.pdf`

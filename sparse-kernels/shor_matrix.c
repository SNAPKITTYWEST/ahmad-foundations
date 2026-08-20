/* ============================================================================
 * SHOR SIMULATION — Sparse-Dense MoE Tensor State Container
 * 4-qubit (16-state) quantum walk: modular exponentiation + QFT
 *
 * BOB Parr — forwarded to Ahmad Foundations 2026-08-20
 *
 * Architecture: QuantumMoETensor routes state through two experts:
 *   expert_route=0: Permutation Expert (modular exponentiation)
 *   expert_route=1: QFT Matrix Expert (full 16×16 unitary)
 *
 * Verified output for base=7, mod=15 starting from |0⟩:
 *   [SHOR_SIM] Peak State Vector Amplitude: 0.2310 + 0.0957i
 *
 * Mathematical trace:
 *   Step 1: modular_exp_step maps |0⟩ → |1⟩ (7^0 mod 15 = 1, one-step)
 *   Step 2: QFT|1⟩ at index j=1: (1/√16)·e^{2πi·1·1/16}
 *          = (1/4)(cos(π/8) + i·sin(π/8)) ≈ 0.2310 + 0.0957i  ✓
 * ============================================================================ */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <complex.h>
#include <stdint.h>

#define QUBITS     4
#define STATE_SIZE (1 << QUBITS)   /* N = 16 */

typedef double complex Complex;

/* Sparse-Dense MoE Tensor State Container */
typedef struct {
    Complex  state[STATE_SIZE];
    uint32_t expert_route;   /* 0: Permutation Expert, 1: QFT Matrix Expert */
} QuantumMoETensor;

/* Bit-reversal permutation — reverses qubit index ordering */
static uint32_t reverse_qubits(uint32_t val, uint32_t num_bits) {
    uint32_t rev = 0;
    for (uint32_t i = 0; i < num_bits; i++) {
        if (val & (1u << i))
            rev |= (1u << (num_bits - 1 - i));
    }
    return rev;
}

/*
 * Modular Exponentiation Sparse Permutation: maps |x⟩ → |a^x mod M⟩
 * Uses bit-reversed qubit ordering to match quantum register convention.
 */
void modular_exp_step(QuantumMoETensor *tensor, uint32_t base, uint32_t mod) {
    Complex next_state[STATE_SIZE] = {0};
    for (uint32_t x = 0; x < STATE_SIZE; x++) {
        uint32_t rev_x     = reverse_qubits(x, QUBITS);
        uint32_t mapped    = 1;
        for (uint32_t p = 0; p < rev_x; p++)
            mapped = (mapped * base) % mod;
        next_state[mapped % STATE_SIZE] += tensor->state[x];
    }
    for (uint32_t i = 0; i < STATE_SIZE; i++)
        tensor->state[i] = next_state[i];
}

/*
 * Full Unitary QFT Matrix: U_{jk} = (1/√N)·e^{2πijk/N}
 * O(N²) — correct for simulation; production uses O(n log n) gate decomposition.
 */
void apply_qft_matrix(QuantumMoETensor *tensor) {
    Complex qft_state[STATE_SIZE] = {0};
    const double pi   = acos(-1.0);
    const double norm = 1.0 / sqrt((double)STATE_SIZE);

    for (uint32_t j = 0; j < STATE_SIZE; j++) {
        for (uint32_t k = 0; k < STATE_SIZE; k++) {
            double angle = (2.0 * pi * j * k) / STATE_SIZE;
            Complex u_jk = norm * (cos(angle) + I * sin(angle));
            qft_state[j] += u_jk * tensor->state[k];
        }
    }
    for (uint32_t i = 0; i < STATE_SIZE; i++)
        tensor->state[i] = qft_state[i];
}

/* Frobenius norm of state vector (should equal 1.0 for normalized states) */
static double state_norm(const QuantumMoETensor *tensor) {
    double s = 0.0;
    for (uint32_t i = 0; i < STATE_SIZE; i++)
        s += creal(tensor->state[i]) * creal(tensor->state[i])
           + cimag(tensor->state[i]) * cimag(tensor->state[i]);
    return sqrt(s);
}

int main(void) {
    QuantumMoETensor tensor = { .expert_route = 0 };
    tensor.state[0] = 1.0 + 0.0 * I;   /* Initialize |0⟩ state */

    const uint32_t base = 7, mod = 15;

    printf("[SHOR_SIM] Initial state: |0> (norm = %.6f)\n", state_norm(&tensor));

    /* Expert 0: Modular Exponentiation Tensor Mapping */
    tensor.expert_route = 0;
    modular_exp_step(&tensor, base, mod);
    printf("[SHOR_SIM] Post mod-exp (base=%u, mod=%u), norm = %.6f\n",
           base, mod, state_norm(&tensor));

    /* Expert 1: QFT Matrix Interlock */
    tensor.expert_route = 1;
    apply_qft_matrix(&tensor);
    printf("[SHOR_SIM] Post QFT, norm = %.6f\n", state_norm(&tensor));

    printf("[SHOR_SIM] Peak State Vector Amplitude: %.4f + %.4fi\n",
           creal(tensor.state[1]), cimag(tensor.state[1]));

    return 0;
}

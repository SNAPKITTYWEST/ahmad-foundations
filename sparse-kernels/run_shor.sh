#!/usr/bin/env bash
# Compile and run the Shor simulation (single deterministic run)
set -euo pipefail

SANDBOX=$(mktemp -d /tmp/shor_sim.XXXXXX)
trap 'rm -rf "$SANDBOX"' EXIT

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

gcc -O3 -Wall -Wextra "$SCRIPT_DIR/shor_matrix.c" \
    -o "$SANDBOX/shor_engine" -lm

echo "[SHOR] Running single deterministic simulation..."
"$SANDBOX/shor_engine"

# The parallel cycle-steal version from BOB's harness is unnecessary:
# the C program ignores argv and all instances produce identical output.
# A single run is the correct artifact for this simulation.

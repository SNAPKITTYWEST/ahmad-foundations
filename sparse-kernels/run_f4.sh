#!/usr/bin/env bash
# Compile and run the F₄ Lie algebra simulation
set -euo pipefail

SANDBOX=$(mktemp -d /tmp/f4_sandbox.XXXXXX)
trap 'rm -rf "$SANDBOX"' EXIT

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

gcc -O3 -Wall -Wextra "$SCRIPT_DIR/f4_core.c" \
    -o "$SANDBOX/f4_exec"

echo "[F₄] Running structural verification..."
"$SANDBOX/f4_exec"

#!/usr/bin/env bash
set -euo pipefail

export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"

if [[ -n "${SUNSHINE_NIRI_SOCKET:-}" ]]; then
    export NIRI_SOCKET="${SUNSHINE_NIRI_SOCKET}"
fi

OUTPUT_NAME="${SUNSHINE_NIRI_OUTPUT:-DP-3}"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

niri msg output "${OUTPUT_NAME}" on
sleep 0.2

"${SCRIPT_DIR}/sunshine-niri-mode.sh"

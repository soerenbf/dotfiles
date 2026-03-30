#!/usr/bin/env bash
set -euo pipefail

export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"

if [[ -n "${SUNSHINE_NIRI_SOCKET:-}" ]]; then
    export NIRI_SOCKET="${SUNSHINE_NIRI_SOCKET}"
fi

OUTPUT_NAME="${SUNSHINE_NIRI_OUTPUT:-DP-3}"

niri msg output "${OUTPUT_NAME}" off

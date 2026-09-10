#!/usr/bin/env bash
# Switch KDE outputs for Sunshine streaming.
set -euo pipefail

VIRTUAL_OUTPUT="${SUNSHINE_KDE_OUTPUT:-DP-3}"
WIDTH="${SUNSHINE_CLIENT_WIDTH:-3840}"
HEIGHT="${SUNSHINE_CLIENT_HEIGHT:-2160}"
FPS="${SUNSHINE_CLIENT_FPS:-60}"
PHYSICAL_OUTPUTS=(DP-1 DP-2)

case "${1:-}" in
    connect)
        kscreen-doctor "output.${VIRTUAL_OUTPUT}.enable"
        kscreen-doctor "output.${VIRTUAL_OUTPUT}.mode.${WIDTH}x${HEIGHT}@${FPS}"
        for output in "${PHYSICAL_OUTPUTS[@]}"; do
            kscreen-doctor "output.${output}.disable"
        done
        ;;
    disconnect)
        for output in "${PHYSICAL_OUTPUTS[@]}"; do
            kscreen-doctor "output.${output}.enable"
        done
        kscreen-doctor "output.${VIRTUAL_OUTPUT}.disable"
        ;;
    *)
        printf 'Usage: %s {connect|disconnect}\n' "${0##*/}" >&2
        exit 2
        ;;
esac

#!/usr/bin/env bash
set -euo pipefail

export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"

if [[ -n "${SUNSHINE_NIRI_SOCKET:-}" ]]; then
    export NIRI_SOCKET="${SUNSHINE_NIRI_SOCKET}"
fi

# Adjust this if `niri msg outputs` reports a different name for the virtual display.
OUTPUT_NAME="${SUNSHINE_NIRI_OUTPUT:-DP-3}"
WIDTH="${1:-${SUNSHINE_CLIENT_WIDTH:-2560}}"
HEIGHT="${2:-${SUNSHINE_CLIENT_HEIGHT:-1440}}"
FPS="${3:-${SUNSHINE_CLIENT_FPS:-60}}"

FPS="${FPS%.*}"

if [[ -z "${FPS}" ]]; then
    FPS=60
fi

if (( FPS >= 90 )); then
    TARGET_FPS=120
else
    TARGET_FPS=60
fi

apply_modeline() {
    niri msg output "${OUTPUT_NAME}" modeline "$@"
}

# Match the Moonlight request to a known virtual-display timing.
case "${WIDTH}x${HEIGHT}@${TARGET_FPS}" in
    3840x2160@120)
        apply_modeline 1075.804 3840 3848 3880 3920 2160 2273 2281 2287 +hsync -vsync
        ;;
    3840x2160@60)
        apply_modeline 522.614 3840 3848 3880 3920 2160 2208 2216 2222 +hsync -vsync
        ;;
    2560x1440@120)
        apply_modeline 483.120 2560 2568 2600 2640 1440 1511 1519 1525 +hsync -vsync
        ;;
    2560x1440@60)
        apply_modeline 234.590 2560 2568 2600 2640 1440 1467 1475 1481 +hsync -vsync
        ;;
    1920x1080@120)
        apply_modeline 274.560 1920 1928 1960 2000 1080 1130 1138 1144 +hsync -vsync
        ;;
    1920x1080@60)
        apply_modeline 133.320 1920 1928 1960 2000 1080 1097 1105 1111 +hsync -vsync
        ;;
    2556x1179@120)
        apply_modeline 394.767 2556 2564 2596 2636 1179 1234 1242 1248 +hsync -vsync
        ;;
    2556x1179@60)
        apply_modeline 191.848 2556 2564 2596 2636 1179 1199 1207 1213 +hsync -vsync
        ;;
    *)
        printf 'Unsupported Sunshine mode request for %s: %sx%s@%s; falling back to auto mode\n' \
            "${OUTPUT_NAME}" "${WIDTH}" "${HEIGHT}" "${FPS}" >&2
        niri msg output "${OUTPUT_NAME}" mode auto
        ;;
esac

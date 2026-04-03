#!/usr/bin/env bash
# Select the niri modeline for the Sunshine virtual display.
# Steps:
# 1. Recreate the niri runtime environment Sunshine may not inherit.
# 2. Read the requested stream size from args or Sunshine environment variables.
# 3. Map the supported resolutions to the EDID-backed niri modes.
# 4. Fall back to the preferred 4K mode for unsupported requests.
set -euo pipefail

export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
LOG_FILE="${HOME}/.config/sunshine/sunshine-launch.log"

if [[ -n "${SUNSHINE_NIRI_SOCKET:-}" ]]; then
    export NIRI_SOCKET="${SUNSHINE_NIRI_SOCKET}"
fi

# Adjust this if the virtual DRM connector is not DP-3.
OUTPUT_NAME="${SUNSHINE_NIRI_OUTPUT:-DP-3}"
WIDTH="${1:-${SUNSHINE_CLIENT_WIDTH:-2560}}"
HEIGHT="${2:-${SUNSHINE_CLIENT_HEIGHT:-1440}}"
FPS="${3:-${SUNSHINE_CLIENT_FPS:-60}}"

FPS="${FPS%.*}"

if [[ -z "${FPS}" ]]; then
    FPS=60
fi

apply_mode() {
    printf '%s sunshine-niri-mode requested=%sx%s@%s applying=%s output=%s\n' \
        "$(date --iso-8601=seconds)" \
        "${WIDTH}" \
        "${HEIGHT}" \
        "${FPS}" \
        "$1" \
        "${OUTPUT_NAME}" >> "${LOG_FILE}"
    niri msg output "${OUTPUT_NAME}" mode "$1"
}

# Match the Moonlight request to the supported virtual-display modes.
# TV/desktop layouts stay at 60 Hz; the phone-shaped layout stays at 120 Hz.
case "${WIDTH}x${HEIGHT}" in
    3840x2160)
        apply_mode "3840x2160@59.997"
        ;;
    2560x1440)
        apply_mode "2560x1440@59.951"
        ;;
    1920x1080)
        apply_mode "1920x1080@60.000"
        ;;
    2556x1179)
        apply_mode "2556x1179@120.001"
        ;;
    *)
        printf 'Unsupported Sunshine mode request for %s: %sx%s@%s; falling back to auto mode\n' \
            "${OUTPUT_NAME}" "${WIDTH}" "${HEIGHT}" "${FPS}" >&2
        apply_mode "3840x2160@59.997"
        ;;
esac

#!/usr/bin/env bash
# Sunshine prep hook for niri virtual-display sessions.
# Steps:
# 1. Recreate the niri runtime environment Sunshine may not inherit.
# 2. Enable the virtual DRM connector in niri.
# 3. Wait for the compositor to expose the virtual output, then apply the requested EDID-backed mode.
# 4. After the virtual output is stable, disable the other connected outputs.
set -euo pipefail

export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
LOG_FILE="${HOME}/.config/sunshine/sunshine-launch.log"

if [[ -n "${SUNSHINE_NIRI_SOCKET:-}" ]]; then
    export NIRI_SOCKET="${SUNSHINE_NIRI_SOCKET}"
fi

# Adjust this if the virtual DRM connector is not DP-3.
OUTPUT_NAME="${SUNSHINE_NIRI_OUTPUT:-DP-3}"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

printf '%s sunshine-niri-connect requested=%sx%s@%s output=%s\n' \
    "$(date --iso-8601=seconds)" \
    "${SUNSHINE_CLIENT_WIDTH:-unset}" \
    "${SUNSHINE_CLIENT_HEIGHT:-unset}" \
    "${SUNSHINE_CLIENT_FPS:-unset}" \
    "${OUTPUT_NAME}" >> "${LOG_FILE}"

list_other_outputs() {
    local line output_label connector
    local output_pattern='^Output "([^"]+)" \(([[:alnum:]-]+)\)$'

    while IFS= read -r line; do
        if [[ "${line}" =~ ${output_pattern} ]]; then
            output_label="${BASH_REMATCH[1]}"
            connector="${BASH_REMATCH[2]}"

            if [[ "${connector}" == "${OUTPUT_NAME}" || "${output_label}" == "${OUTPUT_NAME}" ]]; then
                continue
            fi

            printf '%s\n' "${connector}"
        fi
    done < <(niri msg outputs)
}

niri msg output "${OUTPUT_NAME}" on

sleep 0.5

"${SCRIPT_DIR}/sunshine-niri-mode.sh"

sleep 0.5

while IFS= read -r other_output; do
    [[ -n "${other_output}" ]] || continue
    niri msg output "${other_output}" off
done < <(list_other_outputs)

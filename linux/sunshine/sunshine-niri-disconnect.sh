#!/usr/bin/env bash
# Sunshine cleanup hook for niri virtual-display sessions.
# Steps:
# 1. Recreate the niri runtime environment Sunshine may not inherit.
# 2. Detect all other connected outputs from `niri msg outputs` and turn them back on.
# 3. Disable the virtual DRM connector in niri.
# 4. Leave the desktop layout without the streaming-only monitor.
set -euo pipefail

export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"

if [[ -n "${SUNSHINE_NIRI_SOCKET:-}" ]]; then
    export NIRI_SOCKET="${SUNSHINE_NIRI_SOCKET}"
fi

# Adjust this if the virtual DRM connector is not DP-3.
OUTPUT_NAME="${SUNSHINE_NIRI_OUTPUT:-DP-3}"

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

while IFS= read -r other_output; do
    [[ -n "${other_output}" ]] || continue
    niri msg output "${other_output}" on
done < <(list_other_outputs)

niri msg output "${OUTPUT_NAME}" off

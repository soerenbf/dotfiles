#!/usr/bin/env bash
set -euo pipefail

# This is usable for games where opening games full-screen is an issue for the
# compositor.
#
# Set launch options to `~/dotfiles/linux/steam/steam-gamescope-focused-output.sh %command%`
# followed by any additional parameters for the game.

if [[ "$#" -eq 0 ]]; then
    printf 'Usage: %s <game command...>\n' "$0" >&2
    exit 2
fi

focused_output_json="$(niri msg -j focused-output)"
width="$(jq -er '.modes[.current_mode].width' <<<"${focused_output_json}")"
height="$(jq -er '.modes[.current_mode].height' <<<"${focused_output_json}")"
refresh_millihz="$(jq -er '.modes[.current_mode].refresh_rate' <<<"${focused_output_json}")"
refresh_hz="$(awk -v rate="${refresh_millihz}" 'BEGIN { printf "%.3f", rate / 1000 }')"

exec gamescope \
    -f \
    -W "${width}" \
    -H "${height}" \
    -w "${width}" \
    -h "${height}" \
    -r "${refresh_hz}" \
    -- "$@"

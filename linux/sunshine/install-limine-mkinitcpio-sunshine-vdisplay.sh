#!/usr/bin/env bash
# Install the Sunshine virtual-display setup for this Limine + mkinitcpio system.
# Steps:
# 1. Validate the saved EDID file and install it to /usr/lib/firmware/edid/.
# 2. Append the required mkinitcpio and Limine config lines for the DRM output.
# 3. Configure Sunshine to call the niri connect/disconnect helper scripts.
# 4. Rebuild the initramfs and Limine entries so the virtual display is available at boot.
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

DRM_OUTPUT="${DRM_OUTPUT:-DP-3}"
EDID_SOURCE="${SCRIPT_DIR}/edid/vdisplay-4k-iphone17.bin"
EDID_BASENAME="$(basename -- "${EDID_SOURCE}")"
EDID_DEST="/usr/lib/firmware/edid/${EDID_BASENAME}"
MKINITCPIO_CONF="/etc/mkinitcpio.conf"
LIMINE_CONF="/etc/default/limine"
SUNSHINE_CONF="${HOME}/.config/sunshine/sunshine.conf"

MKINITCPIO_LINE="FILES+=(${EDID_DEST})"
LIMINE_LINE="KERNEL_CMDLINE[default]+=\" drm.edid_firmware=${DRM_OUTPUT}:edid/${EDID_BASENAME} video=${DRM_OUTPUT}:e\""
SUNSHINE_LINE="global_prep_cmd = [{\"do\":\"${SCRIPT_DIR}/sunshine-niri-connect.sh\",\"undo\":\"${SCRIPT_DIR}/sunshine-niri-disconnect.sh\"}]"

require_command() {
    local command_name="$1"

    if ! command -v "${command_name}" >/dev/null 2>&1; then
        printf 'Missing required command: %s\n' "${command_name}" >&2
        exit 1
    fi
}

append_root_line_once() {
    local file_path="$1"
    local line="$2"

    if grep -Fqx "${line}" "${file_path}"; then
        printf 'Already present in %s: %s\n' "${file_path}" "${line}"
        return
    fi

    sudo cp --archive "${file_path}" "${file_path}.pre-sunshine-vdisplay.bak"
    printf '\n%s\n' "${line}" | sudo tee -a "${file_path}" >/dev/null
    printf 'Updated %s\n' "${file_path}"
}

append_user_line_once() {
    local file_path="$1"
    local line="$2"

    mkdir -p -- "$(dirname -- "${file_path}")"
    touch "${file_path}"

    if grep -Fqx "${line}" "${file_path}"; then
        printf 'Already present in %s: %s\n' "${file_path}" "${line}"
        return
    fi

    printf '\n%s\n' "${line}" >> "${file_path}"
    printf 'Updated %s\n' "${file_path}"
}

require_command edid-decode
require_command mkinitcpio
require_command limine-update
require_command sudo

if [[ ! -f "${EDID_SOURCE}" ]]; then
    printf 'Missing EDID file: %s\n' "${EDID_SOURCE}" >&2
    exit 1
fi

if ! command -v niri >/dev/null 2>&1; then
    printf 'Warning: niri is not installed or not on PATH; continuing anyway.\n' >&2
fi

printf 'Validating %s\n' "${EDID_SOURCE}"
edid-decode "${EDID_SOURCE}"

printf 'Requesting sudo access\n'
sudo -v

printf 'Installing EDID to %s\n' "${EDID_DEST}"
sudo install -Dm644 "${EDID_SOURCE}" "${EDID_DEST}"

append_root_line_once "${MKINITCPIO_CONF}" "${MKINITCPIO_LINE}"
append_root_line_once "${LIMINE_CONF}" "${LIMINE_LINE}"

if grep -Eq '^[[:space:]]*global_prep_cmd[[:space:]]*=' "${SUNSHINE_CONF}"; then
    if grep -Fqx "${SUNSHINE_LINE}" "${SUNSHINE_CONF}"; then
        printf 'Sunshine global_prep_cmd is already configured.\n'
    else
        printf 'Sunshine already defines global_prep_cmd in %s; leaving it unchanged.\n' "${SUNSHINE_CONF}" >&2
    fi
else
    append_user_line_once "${SUNSHINE_CONF}" "${SUNSHINE_LINE}"
fi

printf 'Rebuilding initramfs with mkinitcpio -P\n'
sudo mkinitcpio -P

printf 'Updating Limine entries\n'
sudo limine-update

cat <<EOF

Install complete.

Next steps:
1. Reboot.
2. Confirm the connector is up:
   for p in /sys/class/drm/*/status; do con=\${p%/status}; printf '%s: ' "\${con##*/}"; cat "\$p"; done
3. In your niri session, run: niri msg outputs
4. If the virtual display is not named ${DRM_OUTPUT}, set SUNSHINE_NIRI_OUTPUT in the Sunshine service environment or edit the scripts under ${SCRIPT_DIR}.
5. Restart Sunshine after reboot if needed: systemctl --user restart sunshine
6. Once you know the final niri output name, add an output-off block for it in your niri display config so it stays hidden when Sunshine is idle.

Useful checks:
- DRM connector status:
  for p in /sys/class/drm/*/status; do con=\${p%/status}; printf '%s: ' "\${con##*/}"; cat "\$p"; done
- niri outputs:
  niri msg outputs

EOF

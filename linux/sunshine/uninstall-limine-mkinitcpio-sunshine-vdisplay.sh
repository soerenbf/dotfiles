#!/usr/bin/env bash
# Uninstall the Sunshine virtual-display setup for this Limine + mkinitcpio system.
# Steps:
# 1. Remove the EDID file from /usr/lib/firmware/edid/.
# 2. Remove the matching mkinitcpio and Limine config lines for the DRM output.
# 3. Remove the matching Sunshine prep hook line if it was added by the installer.
# 4. Rebuild the initramfs and Limine entries so the virtual display is no longer forced at boot.
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

DRM_OUTPUT="${DRM_OUTPUT:-DP-3}"
EDID_BASENAME="vdisplay-4k-iphone17.bin"
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

remove_root_line_once() {
    local file_path="$1"
    local line="$2"
    local temp_file

    if ! grep -Fqx -- "${line}" "${file_path}"; then
        printf 'Already absent from %s: %s\n' "${file_path}" "${line}"
        return
    fi

    temp_file="$(mktemp)"
    grep -Fvx -- "${line}" "${file_path}" > "${temp_file}" || true
    sudo install -m 644 "${temp_file}" "${file_path}"
    rm -f -- "${temp_file}"
    printf 'Updated %s\n' "${file_path}"
}

remove_user_line_once() {
    local file_path="$1"
    local line="$2"
    local temp_file

    if [[ ! -f "${file_path}" ]]; then
        return
    fi

    if ! grep -Fqx -- "${line}" "${file_path}"; then
        printf 'Already absent from %s: %s\n' "${file_path}" "${line}"
        return
    fi

    temp_file="$(mktemp)"
    grep -Fvx -- "${line}" "${file_path}" > "${temp_file}" || true
    install -m 644 "${temp_file}" "${file_path}"
    rm -f -- "${temp_file}"
    printf 'Updated %s\n' "${file_path}"
}

require_command mkinitcpio
require_command limine-update
require_command sudo

printf 'Requesting sudo access\n'
sudo -v

if sudo test -f "${EDID_DEST}"; then
    printf 'Removing EDID from %s\n' "${EDID_DEST}"
    sudo rm -f -- "${EDID_DEST}"
else
    printf 'Already absent: %s\n' "${EDID_DEST}"
fi

remove_root_line_once "${MKINITCPIO_CONF}" "${MKINITCPIO_LINE}"
remove_root_line_once "${LIMINE_CONF}" "${LIMINE_LINE}"
remove_user_line_once "${SUNSHINE_CONF}" "${SUNSHINE_LINE}"

printf 'Rebuilding initramfs with mkinitcpio -P\n'
sudo mkinitcpio -P

printf 'Updating Limine entries\n'
sudo limine-update

cat <<EOF

Uninstall complete.

Next steps:
1. Reboot.
2. Restart Sunshine if needed: systemctl --user restart sunshine
3. The dotfiles helpers and niri config remain in the repo; this script only removes the installed system integration.

EOF

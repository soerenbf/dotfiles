# Sunshine Setup

This directory contains the Sunshine setup used on this machine.

Reference:

- Primary implementation reference: <https://www.azdanov.dev/articles/2025/how-to-create-a-virtual-display-for-sunshine-on-arch-linux>

Assumptions:

- Arch/CachyOS-style system
- `limine` bootloader
- `mkinitcpio` initramfs generation
- `niri` compositor
- Sunshine running in the user session
- Virtual display on DRM connector `DP-3`

## Files

- `install-limine-mkinitcpio-sunshine-vdisplay.sh`: installs the virtual-display integration into the live system
- `uninstall-limine-mkinitcpio-sunshine-vdisplay.sh`: removes that integration from the live system
- `sunshine-niri-connect.sh`: Sunshine prep hook for enabling the virtual display and disabling the other active outputs
- `sunshine-niri-mode.sh`: maps Sunshine's requested resolution to a supported EDID-backed `niri` mode
- `sunshine-niri-disconnect.sh`: re-enables the physical outputs and disables the virtual display
- `edid/vdisplay-4k-iphone17.bin`: the EDID used to force the virtual display at boot
- `edid/README.md`: EDID-specific notes

## Prerequisites

Install Sunshine if it is not already installed:

```bash
sudo pacman -S sunshine
```

Enable and start the user service:

```bash
systemctl --user enable --now sunshine
```

Open the Sunshine web UI for first-time setup if needed:

```text
https://localhost:47990
```

Use that to complete the initial Sunshine PIN/password setup.

## Firewall

If `ufw` is enabled, allow Sunshine's default port family.

These defaults assume Sunshine's base `port` is still `47989`.

```bash
sudo ufw allow 47984/tcp comment 'Sunshine HTTPS'
sudo ufw allow 47989/tcp comment 'Sunshine HTTP'
sudo ufw allow 47990/tcp comment 'Sunshine Web UI'
sudo ufw allow 47998:48000/udp comment 'Sunshine stream'
sudo ufw allow 48010/tcp comment 'Sunshine RTSP'
```

Notes:

- `47990/tcp` is the web UI shown at `https://localhost:47990`
- `47998-48000/udp` are the video/control/audio stream sockets
- if you change Sunshine's base `port`, these values shift with it

## Install Virtual Display Integration

From the dotfiles repo root:

```bash
./linux/sunshine/install-limine-mkinitcpio-sunshine-vdisplay.sh
```

This script:

1. validates the EDID file
2. installs it to `/usr/lib/firmware/edid/`
3. adds the required `mkinitcpio` line
4. adds the required `Limine` kernel command line
5. adds Sunshine's `global_prep_cmd`
6. rebuilds initramfs and Limine entries

Then reboot.

## Verify Boot-Time Setup

After reboot, confirm the DRM connector exists:

```bash
for p in /sys/class/drm/*/status; do con=${p%/status}; printf '%s: ' "${con##*/}"; cat "$p"; done
```

Expected result:

```text
card1-DP-3: connected
```

Check the `niri` view of outputs:

```bash
niri msg outputs
```

Expected idle behavior:

- the virtual display exists
- it is `Disabled` while Sunshine is idle

If Sunshine needs a restart after reboot:

```bash
systemctl --user restart sunshine
```

## Runtime Behavior

When a Sunshine session starts:

1. `sunshine-niri-connect.sh` enables `DP-3`
2. it parses `niri msg outputs`
3. it turns off the other connected outputs
4. `sunshine-niri-mode.sh` switches `DP-3` to the requested supported mode

When the session ends:

1. `sunshine-niri-disconnect.sh` turns the physical outputs back on
2. it disables `DP-3`

This means Sunshine can just capture the only active output during streaming, instead of relying on a specific configured monitor index.

## Supported Modes

The current EDID advertises:

1. `3840x2160 @ 60`
2. `2560x1440 @ 60`
3. `1920x1080 @ 60`
4. `2556x1179 @ 120`

`sunshine-niri-mode.sh` maps Sunshine's requested resolution to the matching `niri` mode string.

## Steam Big Picture Note

If Steam Big Picture feels slow or choppy, enable GPU rendering for Steam web views:

1. open Steam settings
2. find the setting labeled `Enable GPU accelerated rendering in web views`
3. enable it
4. restart Steam

Without that setting, `steamwebhelper` may run with `--disable-gpu --disable-gpu-compositing`, which makes Big Picture fall back to software rendering even though Sunshine itself is using NVENC.

## Uninstall

To remove the installed system integration:

```bash
./linux/sunshine/uninstall-limine-mkinitcpio-sunshine-vdisplay.sh
```

This removes:

- `/usr/lib/firmware/edid/vdisplay-4k-iphone17.bin`
- the `mkinitcpio` line added by the installer
- the `Limine` kernel command line added by the installer
- the matching Sunshine `global_prep_cmd` line

Then reboot.

The repo files remain in place; this only removes the live system integration.

## Troubleshooting

Check Sunshine logs:

```bash
grep -nE 'Selected monitor|Screencasting with Wayland|nvenc|capture|DP-3' ~/.config/sunshine/sunshine.log
```

Check current `niri` outputs:

```bash
niri msg outputs
```

Check the EDID file in the repo:

```bash
edid-decode ./linux/sunshine/edid/vdisplay-4k-iphone17.bin
```

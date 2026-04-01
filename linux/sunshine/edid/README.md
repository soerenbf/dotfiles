# Sunshine Virtual EDID

Files:

- `base-lg-ultrafine.bin`: untouched source EDID from `card1-DP-1`
- `vdisplay-4k-iphone17.bin`: final virtual-display EDID

Tools used:

- `wxedid`: used to open and edit the binary EDID directly
- `edid-decode`: used to inspect and validate the resulting EDID

Advertised modes:

1. `3840x2160 @ 60`
2. `2560x1440 @ 60`
3. `1920x1080 @ 60`
4. `2556x1179 @ 120`

Runtime behavior:

- The kernel forces `DP-3` to exist at boot via `drm.edid_firmware=...` and `video=DP-3:e`.
- `niri` keeps the virtual output disabled while idle.
- Sunshine connect hooks:
  - enable `DP-3`
  - detect and disable the other connected outputs via `niri msg outputs`
  - switch `DP-3` to the requested EDID-backed mode
- Sunshine disconnect hooks:
  - re-enable the other connected outputs
  - disable `DP-3`

Validation:

```bash
edid-decode vdisplay-4k-iphone17.bin
```

Notes:

- The iPhone-shaped mode is encoded directly in the EDID as `2556x1179 @ 120.001`.
- The desktop/TV modes stay at their EDID-backed ~60 Hz variants.
- The installer for this setup is `../install-limine-mkinitcpio-sunshine-vdisplay.sh`.
- The matching uninstaller is `../uninstall-limine-mkinitcpio-sunshine-vdisplay.sh`.

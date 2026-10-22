# Kanata Setup

This directory contains the user systemd service for Kanata. The service is not installed by the default dotfiles setup; install it only on machines where you want keyboard remapping enabled.

## Prerequisites

- Kanata installed at `/usr/bin/kanata` (update `ExecStart` in the service file if installed elsewhere).
- A Kanata config at `~/.config/kanata/qwerty.kbd`.
- User access to input devices and `/dev/uinput`. Follow the [Kanata Linux setup instructions](https://github.com/jtroo/kanata/blob/main/docs/setup-linux.md), then log out and back in so group changes apply.

## Install and start

From the dotfiles repository root:

```bash
mkdir -p ~/.config/systemd/user
install -m 0644 linux/config/systemd/user/kanata.service ~/.config/systemd/user/kanata.service
systemctl --user daemon-reload
systemctl --user enable --now kanata.service
```

Check service status and logs:

```bash
systemctl --user status kanata.service
journalctl --user -u kanata.service
```

## Stop or remove

```bash
systemctl --user disable --now kanata.service
rm ~/.config/systemd/user/kanata.service
systemctl --user daemon-reload
```

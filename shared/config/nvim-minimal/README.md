# Minimal Neovim configuration

This configuration targets Neovim 0.12.5 and uses `vim.pack` with system-managed language tools.

Test it without affecting the active Neovim configuration:

```bash
cd ~/dotfiles
NVIM_APPNAME=nvim-minimal XDG_CONFIG_HOME="$PWD/shared/config" nvim
```

Neovim stores this configuration's packages, state, cache, and undo history under separate `nvim-minimal` directories. Do not change the `~/.config/nvim` Dotbot link until this configuration is ready to replace Kickstart.

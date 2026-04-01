# Agent Guidelines for Dotfiles Repository

## Build/Installation Commands
- Install dotfiles: `./install`
- Update submodules: `git submodule update --init --recursive`

## Testing
- Dotbot testing: `cd dotbot/test && ./test`
- Run single test: `cd dotbot/test && ./test tests/test-name.bash`

## Code Style Guidelines

### Python (dotbot)
- 4-space indent, 100 char line length, Black formatter

### Lua (Neovim configs)
- 2-space indent, StyLua formatting (see .stylua.toml in each config)
- AstroNvim: 120 cols, double quotes | Kickstart: 160 cols, single quotes

### Shell Scripts
- Shebang: `#!/usr/bin/env bash`, 4-space indent, use `set -e`, double-quote variables

### Config Files (YAML/TOML)
- 2-space indent, LF line endings, final newline, trim trailing whitespace

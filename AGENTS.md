# Agent Guidelines for Dotfiles Repository

## Build/Installation Commands
- Install dotfiles: `./install`
- Update submodules: `git submodule update --init --recursive`

## Testing
- Dotbot testing: `cd dotbot/test && ./test`
- Run single test: `cd dotbot/test && ./test tests/test-name.bash`

## Code Style Guidelines

### Python (dotbot)
- Indentation: 4 spaces
- Line length: 100 characters
- Formatting: Black formatter
- Error handling: Prefer explicit error handling with meaningful messages

### Lua (Neovim configs)
- Indentation: 2 spaces
- Line length: 120 characters (AstroNvim), 160 characters (Kickstart)
- Quote style: Single quotes (Kickstart), double quotes (AstroNvim)
- Call parentheses: None for both configs
- Formatting: Use StyLua with respective .stylua.toml configs

### Shell Scripts
- Use bash shebang: `#!/usr/bin/env bash`
- Indentation: 4 spaces
- Enable error handling with `set -e`
- Prefer double quotes for variable expansion

### YAML/Configuration Files
- Indentation: 2 spaces
- End of line: LF (Unix style)
- Insert final newline: Yes
- Trim trailing whitespace: Yes
- Prefer explicit keys over implicit in YAML
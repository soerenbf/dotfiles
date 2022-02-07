## Environment

- `$MYVIMRC` environment variable pointing to `init.vim`.

## Dependencies (brew, apt, etc)

- nodeJS (nvm?)
- nvim (perhaps even nightly?)
- ranger
- ripgrep
- fd

## Installation

Initialize git submodules in terminal:

```bash
git submodule update --init --recursive
```

Install vim plugins:

```bash
:PlugInstall
```

Install relevant language servers:

- rust-analyzer `brew install rust-analyzer`
- efm language server `brew install efm-langserver`
- bash `npm i -g bash-language-server`
- typescript `npm i -g typescript-language-server`
- purescript `npm i -g purescript-language-server`
- eslint, css, html `npm i -g vscode-langservers-extracted`

### Lua language server

Follow the guide [here](https://github.com/sumneko/lua-language-server/wiki/Build-and-Run)

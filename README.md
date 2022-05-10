## Dependencies

- zsh (if not installed by default)
- Oh my zsh
- LunarVim

## Installation

- Install [LunarVim](https://www.lunarvim.org/01-installing.html#stable)
- Install the dotfiles by executing the following commands in a terminal

```bash
cd ~
git clone git@github.com:soerenbf/dotfiles.git .dotfiles
cd .dotfiles
./install
```

### Lunarvim

- By default, it creates the default lunarvim config in `~/.config/lvim`. If installation of LunarVim is done after running `./install`, Re-run the installation script to override the default config, with a symlink to the one included in the repo.

### Emacs

Doom emacs is added as a submodule. Documentation on installing and setting up can be found in `.emacs.d/README.md`

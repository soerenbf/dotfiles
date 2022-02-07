source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/keys/mappings.vim

source $HOME/.config/nvim/themes/onedark.vim
source $HOME/.config/nvim/themes/lightline.vim
source $HOME/.config/nvim/themes/neovide.vim

luafile $HOME/.config/nvim/plug-config/debugging.lua
source $HOME/.config/nvim/plug-config/ranger.vim
source $HOME/.config/nvim/plug-config/signify.vim
source $HOME/.config/nvim/plug-config/localvimrc.vim
source $HOME/.config/nvim/plug-config/startify.vim
source $HOME/.config/nvim/plug-config/lspconfig.vim
luafile $HOME/.config/nvim/plug-config/cmp.lua
luafile $HOME/.config/nvim/plug-config/treesitter.lua
luafile $HOME/.config/nvim/plug-config/telescope.lua
source $HOME/.config/nvim/plug-config/undotree.vim

luafile $HOME/.config/nvim/lsp/rust.lua
luafile $HOME/.config/nvim/lsp/ts.lua
luafile $HOME/.config/nvim/lsp/eslint.lua
luafile $HOME/.config/nvim/lsp/bash.lua
luafile $HOME/.config/nvim/lsp/lua.lua
luafile $HOME/.config/nvim/lsp/efm.lua
luafile $HOME/.config/nvim/lsp/hls.lua
luafile $HOME/.config/nvim/lsp/html.lua
luafile $HOME/.config/nvim/lsp/css.lua
luafile $HOME/.config/nvim/lsp/purs.lua

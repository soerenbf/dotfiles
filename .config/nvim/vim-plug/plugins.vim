" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    " Theme
    Plug 'joshdick/onedark.vim'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    
    " Status line
    Plug 'itchyny/lightline.vim'
    Plug 'ap/vim-buftabline'
    
    " debugging
    Plug 'mfussenegger/nvim-dap'
    Plug 'theHamsta/nvim-dap-virtual-text'
    Plug 'rcarriga/nvim-dap-ui'

    " Fuzzy find
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'airblade/vim-rooter'

    " Git plugins
    Plug 'mhinz/vim-signify'
    Plug 'tpope/vim-fugitive'

    " LSP
    Plug 'neovim/nvim-lspconfig'
    
    " Completion framework
    Plug 'hrsh7th/nvim-cmp'
    " LSP completion source for nvim-cmp
    Plug 'hrsh7th/cmp-nvim-lsp'
    " Snippet completion source for nvim-cmp
    Plug 'hrsh7th/cmp-vsnip'

    " Other usefull completion sources
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-cmdline'

    " See hrsh7th's other plugins for more completion sources!

    " To enable more of the features of rust-analyzer, such as inlay hints and more!
    Plug 'simrat39/rust-tools.nvim'

    Plug 'purescript-contrib/purescript-vim'

    " Snippet engine
    Plug 'hrsh7th/vim-vsnip'

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
    Plug 'tpope/vim-commentary'
    Plug 'embear/vim-localvimrc'
    Plug 'mhinz/vim-startify'
    Plug 'francoiscabrol/ranger.vim'
    Plug 'rbgrouleff/bclose.vim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'mbbill/undotree'
    Plug 'editorconfig/editorconfig-vim'
call plug#end()

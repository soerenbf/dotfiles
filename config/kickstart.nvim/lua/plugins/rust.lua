return {
  {
    'nvim-treesitter/nvim-treesitter',
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= 'all' then
        opts.ensure_installed = vim.tbl_extend('keep', opts.ensure_installed, { 'rust', 'toml' })
      end
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      opts._servers = vim.tbl_extend('keep', opts._servers, {
        rust_analyzer = {},
        taplo = {},
      })
    end,
  },
}

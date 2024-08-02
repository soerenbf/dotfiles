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
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    ft = 'rust',
  },
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      opts._servers = vim.tbl_extend('keep', opts._servers, {
        rust_analyzer = { _skip_setup = true },
        taplo = {},
      })
    end,
  },
}

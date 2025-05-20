return {
  -- 'mrcjkb/haskell-tools.nvim',
  -- version = '^5', -- Recommended
  -- lazy = false,
  {
    'neovim/nvim-lspconfig',
    optional = true,
    opts = function(_, opts)
      opts._local_servers = vim.tbl_extend('keep', opts._local_servers, {
        hls = {},
      })
    end,
  },
}

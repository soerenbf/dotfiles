return {
  -- Python support
  {
    'neovim/nvim-lspconfig',
    optional = true,
    opts = {
      _local_servers = {
        gleam = {},
      },
    },
  },
}

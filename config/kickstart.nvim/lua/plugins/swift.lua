return {
  {
    'wojciech-kulik/xcodebuild.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'MunifTanjim/nui.nvim',
    },
    config = true,
  },
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      opts._local_servers = vim.tbl_extend('keep', opts._local_servers, {
        sourcekit = {
          capabilities = {
            workspace = {
              didChangeWatchedFiles = {
                dynamicRegistration = true,
              },
            },
          },
        },
      })
    end,
  },
}

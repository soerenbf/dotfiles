return {
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      opts._servers = vim.tbl_extend('keep', opts._servers, {
        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      })
    end,
  },
  -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
  -- used for completion, annotations and signatures of Neovim apis
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    dependencies = {
      'Bilal2453/luvit-meta',
    },
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend('keep', opts.formatters_by_ft, { lua = { 'stylua' } })
    end,
  },
}

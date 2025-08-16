-- You can use 'stop_after_first' to run the first available formatter from the list
local prettier = { 'prettierd' }

return {
  {
    'nvim-treesitter/nvim-treesitter',
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= 'all' then
        opts.ensure_installed = vim.tbl_extend('keep', opts.ensure_installed, { 'javascript', 'typescript', 'tsx', 'jsdoc' })
      end
    end,
  },
  {
    'neovim/nvim-lspconfig',
    optional = true,
    opts = function(_, opts)
      opts._servers = vim.tbl_extend('keep', opts._servers, {
        ts_ls = {},
        eslint = {
          settings = {
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            workingDirectories = { mode = 'auto' },
          },
        },
      })
    end,
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_extend('keep', opts.ensure_installed, { 'js' })
    end,
  },
  {
    'vuki656/package-info.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {},
    event = 'BufRead package.json',
  },
  {
    'stevearc/conform.nvim',
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend('keep', opts.formatters_by_ft, {
        javascript = prettier,
        typescript = prettier,
        javascriptreact = prettier,
        typescriptreact = prettier,
        json = prettier,
      })
    end,
  },
}

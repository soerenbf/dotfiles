return {
  { -- Linting
    'rshkarin/mason-nvim-lint',
    config = true,
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      {
        'mfussenegger/nvim-lint',
        opts = {
          _ft_linters = {}, -- This is used to set linters to be configured per file type in language specific specs
        },
        config = function(_, opts)
          local lint = require 'lint'
          lint.linters_by_ft = opts._ft_linters

          -- Create autocommand which carries out the actual linting
          -- on the specified events.
          local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
          vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
            group = lint_augroup,
            callback = function()
              lint.try_lint()
            end,
          })
        end,
      },
    },
  },
}

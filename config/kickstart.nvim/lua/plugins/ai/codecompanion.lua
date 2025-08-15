vim.cmd [[cab cc CodeCompanion]]

return {
  'olimorris/codecompanion.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>cc', '<cmd>CodeCompanionChat<cr>', desc = '[C]odeCompanion [C]hat', mode = { 'n', 'v' } },
    { '<leader>ca', '<cmd>CodeCompanionActions<cr>', desc = '[C]odeCompanion [A]ctions', mode = { 'n', 'v' } },
    { 'ga', '<cmd>CodeCompanionChat Add<cr>', desc = 'Add to CodeCompanion chat', mode = { 'v' } },
  },
  opts = {
    display = {
      diff = {
        provider = 'default', -- default|mini_diff
      },
    },
    strategies = {
      chat = {
        adapter = 'copilot',
        keymaps = {
          close = {
            modes = {
              n = { '<C-c>', '<esc>' }, -- Extend the default to also close with <esc> in normal mode
            },
          },
        },
        variables = {
          ['buffer'] = {
            opts = {
              default_params = 'pin', -- or 'watch'
            },
          },
        },
      },
      inline = {
        adapter = 'copilot',
      },
      cmd = {
        adapter = 'copilot',
      },
    },
    adapters = {
      opts = {
        show_defaults = false,
      },
      copilot = function()
        return require('codecompanion.adapters').extend('copilot', {
          schema = {
            model = {
              -- default = 'gpt-4.1',
              default = 'claude-3.7-sonnet',
            },
          },
        })
      end,
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    {
      'MeanderingProgrammer/render-markdown.nvim',
      ft = { 'markdown', 'codecompanion' },
    },
    'zbirenbaum/copilot.lua',
  },
}

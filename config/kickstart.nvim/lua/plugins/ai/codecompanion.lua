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
        provider = 'mini_diff', -- default|mini_diff
      },
    },
    strategies = {
      chat = {
        adapter = 'cp_default',
        keymaps = {
          close = {
            modes = {
              n = { '<C-c>', '<esc>' }, -- Extend the default to also close with <esc> in normal mode
            },
          },
        },
      },
      inline = {
        adapter = 'cp_default',
      },
      cmd = {
        adapter = 'cp_sonnet_37',
      },
    },
    adapters = {
      opts = {
        show_defaults = false,
      },
      cp_default = function()
        return require('codecompanion.adapters').extend('copilot', {
          name = 'cp_default', -- Give this adapter a different name to differentiate it from the default ollama adapter
        })
      end,
      cp_sonnet_37 = function()
        return require('codecompanion.adapters').extend('copilot', {
          name = 'cp_sonnet_37', -- Give this adapter a different name to differentiate it from the default ollama adapter
          schema = {
            model = {
              default = 'claude-3.7-sonnet',
            },
            num_ctx = {
              default = 16384,
            },
            num_predict = {
              default = -1,
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

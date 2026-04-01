return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for `snacks` provider.
    ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
    { 'folke/snacks.nvim', opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
    }
    -- Required for `opts.events.reload`.
    vim.o.autoread = true
  end,
  -- stylua: ignore
  keys = {
    { '<leader>at', function() require('opencode').toggle() end, desc = 'Toggle embedded opencode', },
    { '<leader>aa', function() require('opencode').ask('@this: ', { submit = true }) end, desc = 'Ask opencode', mode = { 'n', 'v', }, },
    { '<leader>ab', function() require('opencode').ask('@buffer: ', { submit = true }) end, desc = 'Ask opencode about the current buffer', mode = 'n', },
    { '<leader>ap', function() require('opencode').select() end, desc = 'Select prompt', mode = { 'n', 'v', }, },
    { '<leader>an', function() require('opencode').command('session.new') end, desc = 'New session', },
  },
}

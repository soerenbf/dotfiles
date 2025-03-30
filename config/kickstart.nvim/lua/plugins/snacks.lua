return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    -- dashboard = { enabled = true },
    -- explorer = { enabled = true },
    indent = { enabled = true },
    -- input = { enabled = true },
    picker = {
      enabled = true,
      layout = 'ivy',   -- used for anything where the current buffer is useful for context
      ui_select = true, -- replace `vim.ui.select` with the snacks picker
      win = {
        input = {
          keys = {
            ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
          },
        },
      },
    },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    -- scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    -- Search
    { "<leader><leader>", function() Snacks.picker.smart({ layout = 'sidebar' }) end,                 desc = "Smart Find Files" },
    { "<leader>sn",       function() Snacks.picker.notifications({ layout = 'default' }) end,         desc = "Search [N]otification History" },
    { '<leader>sk',       function() Snacks.picker.keymaps({ layout = 'default' }) end,               desc = '[S]earch [K]eymaps' },
    { '<leader>sh',       function() Snacks.picker.help({ layout = 'ivy_split' }) end,                  desc = '[S]earch [H]elp files' },
    { '<leader>s/',       function() Snacks.picker.grep({ layout = 'ivy_split' }) end,                  desc = '[S]earch [/] in files (grep)' },
    { '<leader>sw',       function() Snacks.picker.grep_word() end,                                   desc = '[S]earch [W]ord' },
    { '<leader>sg',       function() Snacks.picker.git_files({ layout = 'sidebar' }) end,             desc = '[S]earch [W]ord' },
    { '<leader>s.',       function() Snacks.picker.resume() end,                                      desc = '[S]earch Resume ([.] for repeat)' },
    { '<leader>/',        function() Snacks.picker.lines({ layout = 'ivy_split' }) end,                  desc = 'Search [/] in current buffer' },

    -- LSP
    { "gd",               function() Snacks.picker.lsp_definitions() end,                             desc = "[G]oto [D]efinition" },
    { "go",               function() Snacks.picker.lsp_definitions() end,                             desc = "[G]oto [D]efinition" },
    { "gD",               function() Snacks.picker.lsp_declarations() end,                            desc = "[G]oto [D]eclaration" },
    { "gr",               function() Snacks.picker.lsp_references() end,                              nowait = true,                            desc = "[G]oto [R]eferences" },
    { "gI",               function() Snacks.picker.lsp_implementations() end,                         desc = "[G]oto [I]mplementation" },
    { "gy",               function() Snacks.picker.lsp_type_definitions() end,                        desc = "[G]to T[y]pe Definition" },
    { "<leader>ds",       function() Snacks.picker.lsp_symbols({ layout = 'sidebar' }) end,           desc = "[D]ocument [S]ymbols" },
    { "<leader>ws",       function() Snacks.picker.lsp_workspace_symbols({ layout = 'sidebar' }) end, desc = "[W]orkspace [S]ymbols" },
    { "<leader>dd",       function() Snacks.picker.diagnostics_buffer({layout = 'ivy_split'}) end,                          desc = "[D]ocument [D]iagnostics" },
    { "<leader>wd",       function() Snacks.picker.diagnostics() end,                                 desc = "[W]orkspace [D]iagnostics" },
    -- TODO: migrate from fzf.lua
  }
}

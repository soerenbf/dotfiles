-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --

  -- modular approach: using `require 'path/name'` will
  -- include a plugin definition from file lua/path/name.lua
  { import = 'core.plugins' },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart

  -- require 'plugins.ai.avante',
  -- require 'plugins.ai.codecompanion',
  -- require 'plugins.ai.copilot',
  -- require 'plugins.ai.goose',
  require 'plugins.ai.opencode',
  require 'plugins.autopairs',
  require 'plugins.breadcrumb',
  require 'plugins.colours',
  require 'plugins.flash',
  -- require 'plugins.fzf',
  require 'plugins.git',
  require 'plugins.indent_line',
  require 'plugins.lualine',
  require 'plugins.mini',
  require 'plugins.multicursor',
  require 'plugins.neogen',
  require 'plugins.noice',
  require 'plugins.smear-cursor',
  require 'plugins.snacks',
  require 'plugins.todo-comments',
  -- require 'plugins.trouble',
  require 'plugins.undotree',
  require 'plugins.yazi',

  -- Language support
  require 'lang.markdown',
  require 'lang.swift',
  require 'lang.typescript',
  require 'lang.rust',
  require 'lang.haskell', -- Ensure the correct hls version is installed for the version of haskell used: https://haskell-language-server.readthedocs.io/en/latest/support/ghc-version-support.html#current-ghc-version-support-status
  require 'lang.lua',
  require 'lang.protobuf',
  require 'lang.python',
  require 'lang.gleam',
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et

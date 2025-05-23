return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<C-BS>",
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
      },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
  {
    "aaronik/treewalker.nvim",
    opts = {
      highlight = true,         -- Whether to briefly highlight the node after jumping to it
      highlight_duration = 250, -- How long should above highlight last (in ms)
    },
    keys = {
      { '<C-k>',    '<cmd>Treewalker Up<cr>',    noremap = true, silent = true, mode = { 'n', 'v' } },
      { '<C-j>',  '<cmd>Treewalker Down<cr>',  noremap = true, silent = true, mode = { 'n', 'v' } },
      { '<C-l>', '<cmd>Treewalker Right<cr>', noremap = true, silent = true, mode = { 'n', 'v' } },
      { '<C-h>',  '<cmd>Treewalker Left<cr>',  noremap = true, silent = true, mode = { 'n', 'v' } },
      { '<C-M-k>', '<cmd>Treewalker SwapUp<cr>',   noremap = true, silent = true, mode = 'n' },
      { '<C-M-j>', '<cmd>Treewalker SwapDown<cr>', noremap = true, silent = true, mode = 'n' },
      { '<C-up>',    '<cmd>Treewalker Up<cr>',    noremap = true, silent = true, mode = { 'n', 'v' } },
      { '<C-down>',  '<cmd>Treewalker Down<cr>',  noremap = true, silent = true, mode = { 'n', 'v' } },
      { '<C-right>', '<cmd>Treewalker Right<cr>', noremap = true, silent = true, mode = { 'n', 'v' } },
      { '<C-left>',  '<cmd>Treewalker Left<cr>',  noremap = true, silent = true, mode = { 'n', 'v' } },
      { '<C-M-up>', '<cmd>Treewalker SwapUp<cr>',   noremap = true, silent = true, mode = 'n' },
      { '<C-M-down>', '<cmd>Treewalker SwapDown<cr>', noremap = true, silent = true, mode = 'n' },
    }
  },
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    opts = {},
  }
}
-- vim: ts=2 sts=2 sw=2 et

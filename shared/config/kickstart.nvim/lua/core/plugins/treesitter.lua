return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    opts = {
      install_dir = vim.fn.stdpath 'data' .. '/site',
      languages = {
        'bash',
        'c',
        'diff',
        'gitcommit',
        'git_rebase',
        'html',
        'json',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'yaml',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      local ts = require 'nvim-treesitter'
      require('nvim-treesitter.install').prefer_git = true
      ts.setup { install_dir = opts.install_dir }

      if opts.auto_install and opts.languages and #opts.languages > 0 then
        ts.install(opts.languages)
      end

      local group = vim.api.nvim_create_augroup('kickstart-treesitter', { clear = true })

      vim.api.nvim_create_autocmd('FileType', {
        group = group,
        callback = function(event)
          if not opts.highlight.enable then
            return
          end

          local bufnr = event.buf
          local ft = vim.bo[bufnr].filetype
          local ok_lang, lang = pcall(vim.treesitter.language.get_lang, ft)
          if not ok_lang or not lang then
            return
          end

          pcall(vim.treesitter.start, bufnr, lang)

          if opts.indent.enable and not vim.list_contains(opts.indent.disable or {}, ft) then
            vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    'shrey99sh/ts-node-select',
    tag = 'release/v0.1.2',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      local ts_node_select = require 'ts-node-select'

      ts_node_select.setup {
        keymaps = {
          init = '<C-Space>',
          expand = '<C-Space>',
          shrink = '<BS>',
        },
      }

      vim.keymap.set('n', '<C-@>', ts_node_select.init, { desc = 'TS init selection' })
      vim.keymap.set('x', '<C-@>', ts_node_select.expand, { desc = 'TS expand selection' })
      vim.keymap.set('x', '<C-BS>', ts_node_select.shrink, { desc = 'TS shrink selection' })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      select = {
        lookahead = true,
        selection_modes = {
          ['@parameter.outer'] = 'v',
          ['@function.outer'] = 'V',
          ['@class.outer'] = 'V',
        },
        include_surrounding_whitespace = true,
      },
      move = {
        set_jumps = true,
      },
    },
    config = function(_, opts)
      require('nvim-treesitter-textobjects').setup(opts)
    end,
    keys = {
      {
        'af',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')
        end,
        mode = { 'x', 'o' },
        desc = 'outer function',
      },
      {
        'if',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')
        end,
        mode = { 'x', 'o' },
        desc = 'inner function',
      },
      {
        'ac',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects')
        end,
        mode = { 'x', 'o' },
        desc = 'outer class',
      },
      {
        'ic',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects')
        end,
        mode = { 'x', 'o' },
        desc = 'inner class',
      },
      {
        'as',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@local.scope', 'locals')
        end,
        mode = { 'x', 'o' },
        desc = 'local scope',
      },
      {
        ']m',
        function()
          require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects')
        end,
        mode = { 'n', 'x', 'o' },
        desc = 'next function start',
      },
      {
        ']M',
        function()
          require('nvim-treesitter-textobjects.move').goto_next_end('@function.outer', 'textobjects')
        end,
        mode = { 'n', 'x', 'o' },
        desc = 'next function end',
      },
      {
        '[m',
        function()
          require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects')
        end,
        mode = { 'n', 'x', 'o' },
        desc = 'previous function start',
      },
      {
        '[M',
        function()
          require('nvim-treesitter-textobjects.move').goto_previous_end('@function.outer', 'textobjects')
        end,
        mode = { 'n', 'x', 'o' },
        desc = 'previous function end',
      },
      {
        ']]',
        function()
          require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer', 'textobjects')
        end,
        mode = { 'n', 'x', 'o' },
        desc = 'next class start',
      },
      {
        '][',
        function()
          require('nvim-treesitter-textobjects.move').goto_next_end('@class.outer', 'textobjects')
        end,
        mode = { 'n', 'x', 'o' },
        desc = 'next class end',
      },
      {
        '[[',
        function()
          require('nvim-treesitter-textobjects.move').goto_previous_start('@class.outer', 'textobjects')
        end,
        mode = { 'n', 'x', 'o' },
        desc = 'previous class start',
      },
      {
        '[]',
        function()
          require('nvim-treesitter-textobjects.move').goto_previous_end('@class.outer', 'textobjects')
        end,
        mode = { 'n', 'x', 'o' },
        desc = 'previous class end',
      },
    },
  },
  {
    'aaronik/treewalker.nvim',
    opts = {
      highlight = true, -- Whether to briefly highlight the node after jumping to it
      highlight_duration = 250, -- How long should above highlight last (in ms)
    },
    keys = {
      { '<C-k>', '<cmd>Treewalker Up<cr>', noremap = true, silent = true, mode = { 'n', 'v' } },
      { '<C-j>', '<cmd>Treewalker Down<cr>', noremap = true, silent = true, mode = { 'n', 'v' } },
      { '<C-l>', '<cmd>Treewalker Right<cr>', noremap = true, silent = true, mode = { 'n', 'v' } },
      { '<C-h>', '<cmd>Treewalker Left<cr>', noremap = true, silent = true, mode = { 'n', 'v' } },
      -- { '<C-M-k>', '<cmd>Treewalker SwapUp<cr>',   noremap = true, silent = true, mode = 'n' },
      -- { '<C-M-j>', '<cmd>Treewalker SwapDown<cr>', noremap = true, silent = true, mode = 'n' },
      { '<C-up>', '<cmd>Treewalker Up<cr>', noremap = true, silent = true, mode = { 'n', 'v' } },
      { '<C-down>', '<cmd>Treewalker Down<cr>', noremap = true, silent = true, mode = { 'n', 'v' } },
      { '<C-right>', '<cmd>Treewalker Right<cr>', noremap = true, silent = true, mode = { 'n', 'v' } },
      { '<C-left>', '<cmd>Treewalker Left<cr>', noremap = true, silent = true, mode = { 'n', 'v' } },
      -- { '<C-M-up>', '<cmd>Treewalker SwapUp<cr>',   noremap = true, silent = true, mode = 'n' },
      -- { '<C-M-down>', '<cmd>Treewalker SwapDown<cr>', noremap = true, silent = true, mode = 'n' },
    },
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'VeryLazy',
    opts = {},
  },
}
-- vim: ts=2 sts=2 sw=2 et

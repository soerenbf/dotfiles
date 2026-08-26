local parsers = {
  'bash',
  'c',
  'diff',
  'gitcommit',
  'git_rebase',
  'html',
  'javascript',
  'jsdoc',
  'json',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'haskell',
  'latex',
  'proto',
  'python',
  'query',
  'rust',
  'swift',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
}

local treesitter = require 'nvim-treesitter'
treesitter.setup {}
require('nvim-treesitter.install').prefer_git = true
treesitter.install(parsers)

local group = vim.api.nvim_create_augroup('treesitter', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = group,
  callback = function(event)
    local ok, language = pcall(vim.treesitter.language.get_lang, vim.bo[event.buf].filetype)
    if ok and language then
      pcall(vim.treesitter.start, event.buf, language)
      if vim.bo[event.buf].filetype ~= 'ruby' then
        vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end
  end,
})

require('nvim-treesitter-textobjects').setup {
  select = {
    lookahead = true,
    selection_modes = { ['@parameter.outer'] = 'v', ['@function.outer'] = 'V', ['@class.outer'] = 'V' },
    include_surrounding_whitespace = true,
  },
  move = { set_jumps = true },
}

local select = require 'nvim-treesitter-textobjects.select'
for _, mapping in ipairs {
  { 'af', '@function.outer', 'outer function' },
  { 'if', '@function.inner', 'inner function' },
  { 'ac', '@class.outer', 'outer class' },
  { 'ic', '@class.inner', 'inner class' },
  { 'as', '@local.scope', 'local scope', 'locals' },
} do
  vim.keymap.set({ 'x', 'o' }, mapping[1], function()
    select.select_textobject(mapping[2], mapping[4] or 'textobjects')
  end, { desc = mapping[3] })
end

local move = require 'nvim-treesitter-textobjects.move'
for _, mapping in ipairs {
  { ']m', 'goto_next_start', '@function.outer' },
  { ']M', 'goto_next_end', '@function.outer' },
  { '[m', 'goto_previous_start', '@function.outer' },
  { '[M', 'goto_previous_end', '@function.outer' },
  { ']]', 'goto_next_start', '@class.outer' },
  { '][', 'goto_next_end', '@class.outer' },
  { '[[', 'goto_previous_start', '@class.outer' },
  { '[]', 'goto_previous_end', '@class.outer' },
} do
  vim.keymap.set({ 'n', 'x', 'o' }, mapping[1], function()
    move[mapping[2]](mapping[3], 'textobjects')
  end)
end

local node_select = require 'ts-node-select'
node_select.setup { keymaps = { init = '<C-Space>', expand = '<C-Space>', shrink = '<BS>' } }
vim.keymap.set('n', '<C-@>', node_select.init, { desc = 'Treesitter selection' })
vim.keymap.set('x', '<C-@>', node_select.expand, { desc = 'Expand Treesitter selection' })
vim.keymap.set('x', '<C-BS>', node_select.shrink, { desc = 'Shrink Treesitter selection' })

require('nvim-ts-autotag').setup {}

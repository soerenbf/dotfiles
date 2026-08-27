vim.cmd.colorscheme 'nordfox'
vim.cmd.hi 'Comment gui=none'

require('lualine').setup {
  options = {
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
}
require('noice').setup {
  cmdline = { view = 'cmdline' },
  lsp = {
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
  },
}
require('barbecue').setup()
require('which-key').setup { preset = 'helix' }
require('which-key').add {
  { '<leader>a', group = 'AI', mode = { 'v', 'n' } },
  { '<leader>b', group = 'Buffer' },
  { '<leader>c', group = 'Cursor' },
  { '<leader>d', group = 'Document' },
  { '<leader>h', group = 'Git hunk', mode = { 'n', 'v' } },
  { '<leader>m', group = 'Multicursor', mode = { 'v', 'n' } },
  { '<leader>r', group = 'Rename' },
  { '<leader>s', group = 'Search' },
  { '<leader>t', group = 'Toggle' },
  { '<leader>w', group = 'Workspace' },
}
require('todo-comments').setup()
require('quicker').setup {
  keys = {
    {
      '>',
      function()
        require('quicker').expand { before = 2, after = 2, add_to_existing = true }
      end,
      desc = 'Expand quickfix context',
    },
    {
      '<',
      function()
        require('quicker').collapse()
      end,
      desc = 'Collapse quickfix context',
    },
  },
}

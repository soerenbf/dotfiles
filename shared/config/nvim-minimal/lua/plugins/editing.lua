require('mini.ai').setup { n_lines = 500 }
require('mini.surround').setup()
require('mini.diff').setup {
  mappings = { apply = '', reset = '', textobject = '', goto_first = '[H', goto_prev = '[h', goto_next = ']h', goto_last = ']H' },
}

local files = require 'mini.files'
files.setup {
  options = { use_as_default_explorer = false },
  windows = { preview = true, width_preview = 100 },
}
vim.keymap.set('n', '<leader>e', function()
  if files.close() then
    return
  end
  files.open(vim.api.nvim_buf_get_name(0), false)
  files.reveal_cwd()
end, { desc = 'Open explorer' })
vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local options = { buffer = args.data.buf_id }
    vim.keymap.set('n', '<left>', files.go_out, options)
    vim.keymap.set('n', '<right>', function() files.go_in { close_on_file = true } end, options)
    vim.keymap.set('n', 'l', function() files.go_in { close_on_file = true } end, options)
    vim.keymap.set('n', '<Esc>', files.close, options)
  end,
})
vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesActionRename',
  callback = function(event)
    Snacks.rename.on_rename_file(event.data.from, event.data.to)
  end,
})

require('mini.move').setup()
for _, mapping in ipairs {
  { '<M-left>', 'left' },
  { '<M-right>', 'right' },
  { '<M-down>', 'down' },
  { '<M-up>', 'up' },
} do
  vim.keymap.set('x', mapping[1], function() MiniMove.move_selection(mapping[2]) end, { desc = 'Move selection ' .. mapping[2] })
  vim.keymap.set('n', mapping[1], function() MiniMove.move_line(mapping[2]) end, { desc = 'Move line ' .. mapping[2] })
end

require('nvim-autopairs').setup {}
require('flash').setup()
vim.keymap.set({ 'n', 'x', 'o' }, '<M-s>', function() require('flash').jump() end, { desc = 'Flash' })
vim.keymap.set({ 'n', 'x', 'o' }, 'S', function() require('flash').treesitter() end, { desc = 'Flash Treesitter' })
vim.keymap.set('o', 'r', function() require('flash').remote() end, { desc = 'Remote Flash' })
vim.keymap.set({ 'o', 'x' }, 'R', function() require('flash').treesitter_search() end, { desc = 'Flash Treesitter search' })

local multicursor = require 'multicursor-nvim'
multicursor.setup()
vim.keymap.set({ 'n', 'v' }, '<leader>m<up>', function() multicursor.addCursor 'k' end)
vim.keymap.set({ 'n', 'v' }, '<leader>m<down>', function() multicursor.addCursor 'j' end)
vim.keymap.set({ 'n', 'v' }, '<C-n>', function() multicursor.addCursor '*' end)
vim.keymap.set({ 'n', 'v' }, '<C-s>', function() multicursor.skipCursor '*' end)
vim.keymap.set({ 'n', 'v' }, '<leader>m<left>', multicursor.prevCursor)
vim.keymap.set({ 'n', 'v' }, '<leader>m<right>', multicursor.nextCursor)
vim.keymap.set({ 'n', 'v' }, '<leader>mx', multicursor.deleteCursor, { desc = 'Delete main multicursor' })
vim.keymap.set('n', '<C-leftmouse>', multicursor.handleMouse)
vim.keymap.set({ 'n', 'v' }, '<leader>mr', function()
  if multicursor.cursorsEnabled() then
    multicursor.disableCursors()
  else
    multicursor.addCursor()
  end
end, { desc = 'Reposition main multicursor' })
vim.keymap.set('n', '<Esc>', function()
  if not multicursor.cursorsEnabled() then
    multicursor.enableCursors()
  elseif multicursor.hasCursors() then
    multicursor.clearCursors()
  else
    vim.cmd.nohlsearch()
  end
end)
vim.keymap.set('n', '<leader>ma', multicursor.alignCursors, { desc = 'Align multicursors' })
vim.keymap.set('v', 'S', multicursor.splitCursors)
vim.keymap.set('v', 'I', multicursor.insertVisual)
vim.keymap.set('v', 'A', multicursor.appendVisual)
vim.keymap.set('v', 'M', multicursor.matchCursors)
vim.keymap.set('v', '<leader>mt', function() multicursor.transposeCursors(1) end, { desc = 'Transpose multicursors forward' })
vim.keymap.set('v', '<leader>mT', function() multicursor.transposeCursors(-1) end, { desc = 'Transpose multicursors backward' })
vim.api.nvim_set_hl(0, 'MultiCursorCursor', { link = 'Cursor' })
vim.api.nvim_set_hl(0, 'MultiCursorVisual', { link = 'Visual' })
vim.api.nvim_set_hl(0, 'MultiCursorDisabledCursor', { link = 'Visual' })
vim.api.nvim_set_hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })

require('neogen').setup {}
vim.keymap.set('n', 'gcd', function() require('neogen').generate() end, { desc = 'Generate doc comment' })
vim.keymap.set('n', '<leader>u', '<CMD>UndotreeToggle<CR>', { desc = 'Undotree' })

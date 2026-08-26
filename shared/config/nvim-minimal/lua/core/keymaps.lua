vim.keymap.set('n', 'gh', vim.diagnostic.open_float, { desc = 'Show diagnostics under cursor' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<M-c>', 'ciw')
vim.keymap.set('n', '<M-v>', 'viw')
vim.keymap.set('n', '<M-d>', 'dw')
vim.keymap.set('n', '<M-y>', 'yiw')
vim.keymap.set('n', '<C-a>', '<C-d>')

for _, direction in ipairs {
  { 'h', 'left' },
  { 'j', 'down' },
  { 'k', 'up' },
  { 'l', 'right' },
} do
  vim.keymap.set('n', '<C-S-' .. direction[1] .. '>', '<C-w><C-' .. direction[1] .. '>', { desc = 'Move focus ' .. direction[2] })
  vim.keymap.set('n', '<C-S-' .. direction[2] .. '>', '<C-w><C-' .. direction[1] .. '>', { desc = 'Move focus ' .. direction[2] })
end

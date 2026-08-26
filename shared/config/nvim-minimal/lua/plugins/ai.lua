require('pi-nvim').setup { set_default_keymaps = false }
vim.keymap.set({ 'n', 'v' }, '<leader>aa', '<cmd>Pi<cr>', { desc = 'Ask Pi' })
vim.keymap.set('n', '<leader>ab', '<cmd>PiSendBuffer<cr>', { desc = 'Ask Pi about buffer' })
vim.keymap.set({ 'n', 'v' }, '<leader>ap', '<cmd>PiSend<cr>', { desc = 'Send prompt to Pi' })
vim.keymap.set('n', '<leader>an', '<cmd>PiSessions<cr>', { desc = 'Switch Pi session' })

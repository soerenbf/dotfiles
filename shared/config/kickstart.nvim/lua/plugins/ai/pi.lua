return {
  'soerenbf/pi-nvim',
  config = {
    set_default_keymaps = false,
  },
  -- stylua: ignore
  keys = {
    { '<leader>aa', '<cmd>Pi<cr>', desc = 'Ask pi', mode = { 'n', 'v' }, },
    { '<leader>ab', '<cmd>PiSendBuffer<cr>', desc = 'Ask pi about the current buffer', mode = 'n', },
    { '<leader>ap', '<cmd>PiSend<cr>', desc = 'Send prompt to pi', mode = { 'n', 'v' }, },
    { '<leader>an', '<cmd>PiSessions<cr>', desc = 'Switch pi session', },
  },
}

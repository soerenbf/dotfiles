return {
  'zbirenbaum/copilot.lua',
  event = 'BufEnter',
  opts = {
    panels = { enabled = false },
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = '<C-M-y>',
        accept_word = false,
        accept_line = false,
        next = '<C-M-n>',
        prev = '<C-M-p>',
        dismiss = '<C-Esc>',
      },
    },
  },
}

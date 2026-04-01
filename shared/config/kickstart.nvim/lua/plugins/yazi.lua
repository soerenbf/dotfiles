---@type LazySpec
return {
  'mikavilpas/yazi.nvim',
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      '<leader>E',
      '<cmd>Yazi<cr>',
      desc = 'Open yazi [E]xplorer at the current file',
    },
  },
  cmd = 'Yazi',
  ---@type YaziConfig
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    -- open_for_directories = true,
    keymaps = {
      show_help = '<f1>',
    },
  },
}

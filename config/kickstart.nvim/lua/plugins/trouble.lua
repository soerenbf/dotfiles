return {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "<leader>wx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "[W]orkspace [D]iagnostics (Trouble)",
    },
    {
      "<leader>bx",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "[B]uffer [D]iagnostics (Trouble)",
    },
  },
}

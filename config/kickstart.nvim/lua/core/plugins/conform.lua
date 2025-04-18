return {
  { -- Autoformat
    'zapling/mason-conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>df',
        ':lua require("conform").format { async = true, lsp_fallback = true }<CR>',
        noremap = true,
        silent = true,
        mode = 'n',
        desc = '[D]ocument [F]ormat'
      },
    },
    config = true,
    dependencies = {
      'williamboman/mason.nvim',
      {
        'stevearc/conform.nvim',
        lazy = true,
        opts = {
          notify_on_error = false,
          format_on_save = false,
          -- format_on_save = function(bufnr)
          --   -- Disable "format_on_save lsp_fallback" for languages that don't
          --   -- have a well standardized coding style. You can add additional
          --   -- languages here or re-enable it for the disabled ones.
          --   local disable_filetypes = { c = true, cpp = true, swift = true }
          --   return {
          --     timeout_ms = 500,
          --     lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
          --   }
          -- end,
          formatters_by_ft = {},
        },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et

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
        desc = '[D]ocument [F]ormat',
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
          format_on_save = function(bufnr)
            -- Completely disable formatting for these filetypes
            local disabled_filetypes = { rust = true, javascript = true, javascriptreact = true }

            -- If filetype is in the disabled list, return false to completely disable formatting
            if disabled_filetypes[vim.bo[bufnr].filetype] then
              return false
            end

            -- For other filetypes, conditionally disable lsp_fallback
            local no_lsp_fallback_filetypes = { c = true, cpp = true, swift = true }
            return {
              timeout_ms = 500,
              lsp_fallback = not no_lsp_fallback_filetypes[vim.bo[bufnr].filetype],
            }
          end,
          formatters_by_ft = {},
        },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et

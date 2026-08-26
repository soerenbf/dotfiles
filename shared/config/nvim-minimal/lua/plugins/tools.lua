require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    local disabled = { javascript = true, javascriptreact = true, markdown = true, toml = true, yaml = true }
    if disabled[vim.bo[bufnr].filetype] then
      return false
    end
    return { timeout_ms = 500, lsp_format = vim.bo[bufnr].filetype == 'c' or vim.bo[bufnr].filetype == 'cpp' or vim.bo[bufnr].filetype == 'swift' and 'never' or 'fallback' }
  end,
  formatters_by_ft = {
    haskell = { 'fourmolu' },
    javascript = { 'prettierd' },
    javascriptreact = { 'prettierd' },
    json = { 'prettierd' },
    lua = { 'stylua' },
    python = { 'ruff_format', 'isort' },
    typescript = { 'prettierd' },
    typescriptreact = { 'prettierd' },
  },
  formatters = {
    fourmolu = { command = 'fourmolu', args = { '--stdin-input-file', '$FILENAME' }, stdin = true, timeout_ms = 5000 },
  },
}
vim.keymap.set('n', '<leader>df', function() require('conform').format { async = true, lsp_format = 'fallback' } end, { desc = 'Format document' })

local lint = require 'lint'
lint.linters_by_ft = { python = { 'ruff' } }
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = vim.api.nvim_create_augroup('lint', { clear = true }),
  callback = function() lint.try_lint() end,
})

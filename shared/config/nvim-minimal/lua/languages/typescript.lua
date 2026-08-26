vim.lsp.config('ts_ls', {})
vim.lsp.config('eslint', { settings = { workingDirectories = { mode = 'auto' } } })
vim.lsp.enable { 'ts_ls', 'eslint' }

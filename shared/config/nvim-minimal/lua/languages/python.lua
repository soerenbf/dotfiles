vim.lsp.config('pyright', {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = 'strict',
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'workspace',
      },
    },
  },
})
vim.lsp.config('ruff', {
  init_options = { settings = { lint = { run = 'onSave' } } },
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false
  end,
})
vim.lsp.enable { 'pyright', 'ruff' }

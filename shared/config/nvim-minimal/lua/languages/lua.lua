require('lazydev').setup {
  library = { { path = 'luvit-meta/library', words = { 'vim%.uv' } } },
}
vim.lsp.config('lua_ls', {
  settings = { Lua = { completion = { callSnippet = 'Replace' } } },
})
vim.lsp.enable 'lua_ls'

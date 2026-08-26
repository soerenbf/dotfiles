vim.lsp.config('protobuf_language_server', {
  cmd = { 'protobuf-language-server' },
  filetypes = { 'proto', 'cpp' },
  root_markers = { '.git' },
  single_file_support = true,
  settings = { ['additional-proto-dirs'] = {} },
})
vim.lsp.enable 'protobuf_language_server'

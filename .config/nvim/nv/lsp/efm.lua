local lua_format = {
    formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=150 --break-after-table-lb",
    formatStdin = true
}

local prettier = {formatCommand = 'prettier --stdin-filepath ${INPUT}', formatStdin = true}

local languages = {
    lua = {lua_format},
    css = {prettier},
    html = {prettier},
    json = {prettier},
    markdown = {prettier},
    scss = {prettier},
    yaml = {prettier}
}

require"lspconfig".efm.setup {
    init_options = {documentFormatting = true},
    filetypes = vim.tbl_keys(languages),
    settings = {rootMarkers = {".git/"}, languages = languages}
}

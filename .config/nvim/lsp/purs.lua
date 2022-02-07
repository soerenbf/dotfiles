local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- npm i -g purescript-language-server
require('lspconfig').purescriptls.setup {
    capabilities = capabilities,
    settings = {
        purescript = {
            addSpagoSources = true -- e.g. any purescript language-server config here
        }
    },
    flags = {debounce_text_changes = 150}
}

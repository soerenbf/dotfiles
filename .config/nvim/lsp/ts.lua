local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client)
    -- tsserver, stop messing with prettier da fuck!
    client.resolved_capabilities.document_formatting = false
end

require('lspconfig').tsserver.setup {capabilities = capabilities, on_attach = on_attach, settings = {}}

vim.cmd [[
augroup TsAutoFormat
autocmd BufWritePre *.ts EslintFixAll
autocmd BufWritePre *.tsx EslintFixAll
augroup END
]]

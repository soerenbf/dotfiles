" LSP config (the mappings used in the default file don't quite work right)
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> rn    <cmd>lua vim.lsp.buf.rename()<CR>
" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" auto-format
augroup JsAutoFormat
autocmd BufWritePre *.js EslintFixAll
autocmd BufWritePre *.jsx EslintFixAll
augroup END

augroup StylesheetAutoFormat
autocmd BufWritePre *.css lua vim.lsp.buf.formatting_sync()
autocmd BufWritePre *.scss lua vim.lsp.buf.formatting_sync()
augroup END

" augroup MarkdownAutoFormat
" autocmd BufWritePre *.md lua vim.lsp.buf.formatting_sync()
" augroup END

augroup HtmlAutoFormat
autocmd BufWritePre *.html lua vim.lsp.buf.formatting_sync()
augroup END

" augroup JsonAutoFormat
" autocmd BufWritePre *.json lua vim.lsp.buf.formatting_sync()
" augroup END

" augroup YamlAutoFormat
" autocmd BufWritePre *.yaml lua vim.lsp.buf.formatting_sync()
" autocmd BufWritePre *.yml lua vim.lsp.buf.formatting_sync()
" augroup END

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

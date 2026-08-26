vim.g.rustaceanvim = {
  server = {
    cmd = { 'rust-analyzer' },
    default_settings = {
      ['rust-analyzer'] = {
        cargo = { allFeatures = true },
        check = { command = 'clippy', extraArgs = { '--no-deps' } },
        checkOnSave = true,
        files = { watcher = 'server' },
        procMacro = { enable = true },
      },
    },
  },
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('rust-lsp-keymaps', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client or (client.name ~= 'rust-analyzer' and client.name ~= 'rust_analyzer') then
      return
    end
    local function map(keys, command, desc)
      vim.keymap.set('n', keys, command, { buffer = event.buf, desc = desc })
    end
    map('<leader>ce', '<cmd>RustLsp expandMacro<cr>', 'Expand macro')
    map('<leader>cR', '<cmd>RustLsp run<cr>', 'Run target')
    map('<leader>cD', '<cmd>RustLsp debug<cr>', 'Debug target')
    map('<leader>wR', '<cmd>RustLsp runnables<cr>', 'Runnables')
    map('<leader>wD', '<cmd>RustLsp debuggables<cr>', 'Debuggables')
    map('<leader>wT', '<cmd>RustLsp testables<cr>', 'Testables')
    map('<leader>wC', '<cmd>RustLsp openCargo<cr>', 'Open Cargo.toml')
  end,
})

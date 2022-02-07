local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local vscode_lldb_path = '/Users/sbz/.vscode/extensions/vadimcn.vscode-lldb-1.6.10/' -- TODO put this into a variable somewhere... or even better find a way to include it as a dependency.
local codelldb_path = vscode_lldb_path .. 'adapter/codelldb'
local liblldb_path = vscode_lldb_path .. 'lldb/lib/liblldb.dylib' -- MacOS
-- local liblldb_path = vscode_lldb_path .. 'lldb/lib/liblldb.so' -- Linux

local opts = {
    -- rust-tools options
    tools = {inlay_hints = {show_parameter_hints = false, parameter_hints_prefix = "", other_hints_prefix = ""}},
    server = {
        capabilities = capabilities,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
        }
    },
    dap = {adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)}
}

local dap = require('dap')

local getExecutable = function()
    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
end

dap.configurations.rust = {
    {type = "rt_lldb", request = "launch", name = "Rust tools launch", program = getExecutable, cwd = '${workspaceFolder}', stopOnEntry = true},
    {type = "rt_lldb", request = "attach", name = "Rust tools attach", program = getExecutable, cwd = '${workspaceFolder}'}
}

-- EXAMPLE DEBUG CONFIG IN "local.vim"
-- local dap = require('dap')
-- dap.configurations.rust = {
--     {
--         type = "rt_lldb",
--         request = "attach",
--         name = "Rust tools attach",
--         program = "/Users/sbz/Developer/Concordium/concordium-node/concordium-node/target/debug/concordium-node"
--     }
-- }

require('rust-tools').setup(opts)

-- vim.cmd [[
-- augroup RustAutoFormat
-- autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync()
-- augroup END
-- ]]

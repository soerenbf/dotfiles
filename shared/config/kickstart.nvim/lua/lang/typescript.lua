-- You can use 'stop_after_first' to run the first available formatter from the list
local prettier = { 'prettierd' }

return {
  {
    'nvim-treesitter/nvim-treesitter',
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= 'all' then
        opts.ensure_installed = vim.tbl_extend('keep', opts.ensure_installed, { 'javascript', 'typescript', 'tsx', 'jsdoc' })
      end
    end,
  },
  {
    'neovim/nvim-lspconfig',
    optional = true,
    opts = function(_, opts)
      opts._servers = vim.tbl_extend('keep', opts._servers, {
        ts_ls = {},
        eslint = {
          settings = {
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            workingDirectories = { mode = 'auto' },
          },
        },
      })
    end,
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    optional = true,
    opts = {
      ensure_installed = { 'js' },
    },
  },
  {
    'mfussenegger/nvim-dap',
    optional = true,
    config = function()
      local dap = require 'dap'
      local mason_registry = require 'mason-registry'
      local install_location = require 'mason-core.installer.InstallLocation'

      local js_debug_path = install_location.global():package(mason_registry.get_package('js-debug-adapter').name)
      local js_debug_server = js_debug_path .. '/js-debug/src/dapDebugServer.js'

      for _, adapter in ipairs { 'pwa-node', 'pwa-chrome' } do
        dap.adapters[adapter] = {
          type = 'server',
          host = 'localhost',
          port = '${port}',
          executable = {
            command = 'node',
            args = { js_debug_server, '${port}' },
          },
        }
      end

      local js_configs = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file (JS)',
          program = '${file}',
          cwd = '${workspaceFolder}',
          sourceMaps = true,
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file (TS with tsx)',
          runtimeExecutable = 'npx',
          runtimeArgs = { 'tsx' },
          program = '${file}',
          cwd = '${workspaceFolder}',
          sourceMaps = true,
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file (TS with ts-node)',
          runtimeExecutable = 'npx',
          runtimeArgs = { 'ts-node' },
          program = '${file}',
          cwd = '${workspaceFolder}',
          sourceMaps = true,
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach to process',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
          sourceMaps = true,
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Debug Jest tests',
          runtimeExecutable = 'npx',
          runtimeArgs = { 'jest', '--runInBand', '--no-cache' },
          cwd = '${workspaceFolder}',
          console = 'integratedTerminal',
          sourceMaps = true,
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Debug Vitest tests',
          runtimeExecutable = 'npx',
          runtimeArgs = { 'vitest', 'run' },
          cwd = '${workspaceFolder}',
          console = 'integratedTerminal',
          sourceMaps = true,
        },
      }

      for _, ft in ipairs { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' } do
        dap.configurations[ft] = js_configs
      end
    end,
  },
  {
    'vuki656/package-info.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {},
    event = 'BufRead package.json',
  },
  {
    'stevearc/conform.nvim',
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend('keep', opts.formatters_by_ft, {
        javascript = prettier,
        typescript = prettier,
        javascriptreact = prettier,
        typescriptreact = prettier,
        json = prettier,
      })
    end,
  },
}

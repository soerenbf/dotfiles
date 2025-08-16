return {
  -- Python support
  {
    'neovim/nvim-lspconfig',
    opts = {
      _servers = {
        -- Python LSP (pyright for type checking)
        pyright = {
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
        },
        -- Ruff LSP (linting and code style)
        ruff = {
          init_options = {
            settings = {
              -- Configure ruff settings here
              lint = {
                run = 'onSave',
              },
            },
          },
          on_attach = function (client, _)
            client.server_capabilities.hoverProvider = false
          end
        },
      },
    },
  },
  
  -- Formatter configuration
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        python = { 'ruff_format', 'isort' },
      },
    },
  },
  
  -- Linter configuration
  {
    'mfussenegger/nvim-lint',
    opts = {
      _ft_linters = {
        python = { 'ruff' }, -- Ruff for linting
      },
    },
  },
  
  -- Ensure the required tools are installed
  -- Most are installed automatically.
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'isort',             -- Import sorting
      },
    },
  },
}

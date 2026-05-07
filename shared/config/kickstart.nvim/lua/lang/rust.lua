return {
  {
    'nvim-treesitter/nvim-treesitter',
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= 'all' then
        opts.ensure_installed = vim.tbl_extend('keep', opts.ensure_installed, { 'rust', 'toml' })
      end
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    ft = 'rust',
    init = function()
      vim.g.rustaceanvim = {
        server = {
          cmd = { vim.fn.expand '~/.local/share/nvim/mason/bin/rust-analyzer' },
          default_settings = {
            ['rust-analyzer'] = {
              cargo = {
                allFeatures = true,
              },
              check = {
                command = 'clippy',
                extraArgs = { '--no-deps' },
              },
              checkOnSave = true,
              files = {
                watcher = 'server',
              },
              procMacro = {
                enable = true,
              },
            },
          },
        },
      }
    end,
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-rust-lsp-attach', { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if not client or (client.name ~= 'rust-analyzer' and client.name ~= 'rust_analyzer') then
            return
          end

          local map = function(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, { buffer = event.buf, desc = desc })
          end

          map('<leader>ce', '<cmd>RustLsp expandMacro<cr>', '[C]ursor [E]xpand macro')
          map('<leader>cR', '<cmd>RustLsp run<cr>', '[C]ursor [R]un target')
          map('<leader>cD', '<cmd>RustLsp debug<cr>', '[C]ursor [D]ebug target')
          map('<leader>wR', '<cmd>RustLsp runnables<cr>', '[W]orkspace [R]unnables')
          map('<leader>wD', '<cmd>RustLsp debuggables<cr>', '[W]orkspace [D]ebuggables')
          map('<leader>wT', '<cmd>RustLsp testables<cr>', '[W]orkspace [T]estables')
          map('<leader>wC', '<cmd>RustLsp openCargo<cr>', '[W]orkspace [C]argo.toml')
        end,
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      opts._servers = vim.tbl_extend('keep', opts._servers, {
        rust_analyzer = { _skip_setup = true },
        taplo = {},
      })
    end,
  },
}

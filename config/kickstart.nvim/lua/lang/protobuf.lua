return {
  {
    'neovim/nvim-lspconfig',
    optional = true,
    opts = function(_, opts)
      local configs = require 'lspconfig.configs'
      local util = require 'lspconfig.util'

      -- first we configure the custom server
      configs.protobuf_language_server = {
        default_config = {
          cmd = { 'protobuf-language-server' }, -- We assume this is available in PATH
          filetypes = { 'proto', 'cpp' },
          root_dir = util.root_pattern '.git',
          single_file_support = true,
          settings = {
            ['additional-proto-dirs'] = {
              -- path to additional protobuf directories
              -- "vendor",
              -- "third_party",
            },
          },
        },
      }

      -- then we add the server to the list of local servers
      opts._local_servers = vim.tbl_extend('keep', opts._local_servers, {
        protobuf_language_server = {},
      })
    end,
  },
}

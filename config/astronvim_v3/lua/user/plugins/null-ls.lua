local utils = require "astronvim.utils"

return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, config)
      -- config variable is the default configuration table for the setup function call

      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        -- null_ls.builtins.formatting.stylua,
      }
      return config -- return final config table
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts) opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "prettierd" }) end,
  },
  {
    "MunifTanjim/prettier.nvim",
    dependencies = { "jay-babu/mason-null-ls.nvim" },
    opts = function(_, opts) opts.bin = "prettierd" end,
  },
}

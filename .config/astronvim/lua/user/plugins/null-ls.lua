local utils = require "astronvim.utils"
local check_json_key_exists = require "user.util"

local has_prettier = function(util)
  return check_json_key_exists(vim.fn.getcwd() .. "/package.json", "prettier")
    or util.root_has_file ".prettierrc"
    or util.root_has_file ".prettierrc.json"
    or util.root_has_file ".prettierrc.yml"
    or util.root_has_file ".prettierrc.yaml"
    or util.root_has_file ".prettierrc.json5"
    or util.root_has_file ".prettierrc.js"
    or util.root_has_file ".prettierrc.cjs"
    or util.root_has_file "prettier.config.js"
    or util.root_has_file "prettier.config.cjs"
    or util.root_has_file ".prettierrc.toml"
end

return {
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "prettierd" })
      if not opts.handlers then opts.handlers = {} end

      opts.handlers.prettierd = function()
        local null_ls = require "null-ls"
        null_ls.register(null_ls.builtins.formatting.prettierd.with {
          condition = has_prettier,
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "css",
            "scss",
            "less",
            "html",
            "json",
            "jsonc",
            "graphql",
            "handlebars",
          },
        })
      end
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, config)
      config.ensure_installed = { "prettierd" }
      -- config variable is the default configuration table for the setup function call
      -- local null_ls = require "null-ls"

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
}

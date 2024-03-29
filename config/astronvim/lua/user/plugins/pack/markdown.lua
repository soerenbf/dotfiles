-- Community pack but without prettier, and with markdownlint
local utils = require "astronvim.utils"
return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = "MarkdownPreview",
    build = ":call mkdp#util#install()",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "markdown", "markdown_inline" })
      end
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",

    opts = function(_, opts)
      opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "markdownlint" })
      if not opts.handlers then opts.handlers = {} end

      local has_mdlint = function(util) return util.root_has_file ".markdownlint.yaml" end

      opts.handlers.markdownlint = function()
        local null_ls = require "null-ls"
        null_ls.register(null_ls.builtins.diagnostics.markdownlint.with { condition = has_mdlint })
        null_ls.register(null_ls.builtins.formatting.markdownlint.with { condition = has_mdlint })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts) opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "marksman") end,
  },
}

return {
  {
    "MunifTanjim/prettier.nvim",
    -- opts = function(_, opts)
    --   opts.bin = "prettierd"
    --   opts.filetypes = {
    --     "json"
    --   }
    --   opts["null-ls"] = {
    --     condition = function ()
    --       return false
    --     end
    --   }
    -- end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "prettierd",
      })
    end,
  },
}

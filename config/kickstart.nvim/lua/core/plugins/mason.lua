return {
  {
    'williamboman/mason.nvim',
    config = function(_, _)
      require 'mason-tool-installer'
    end,
    lazy = true,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    lazy = true,
  },
}

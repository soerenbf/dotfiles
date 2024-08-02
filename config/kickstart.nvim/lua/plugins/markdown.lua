return {
  {
    'MeanderingProgrammer/markdown.nvim',
    ft = 'markdown',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  },
  {
    'mfussenegger/nvim-lint',
    opts = function(_, opts)
      opts._ft_linters = vim.tbl_extend('keep', opts._ft_linters, { markdown = { 'markdownlint' } })
    end,
  },
}

return {
  "danymat/neogen",
  keys = {
    { 'gcd', ":lua require('neogen').generate()<CR>", noremap = true, silent = true, mode = 'n', desc = 'Add docstring for symbol under cursor' },
  },
  config = function()
    local neogen = require('neogen')
    neogen.setup({})

    -- FIXME: for some reason this makes esc not work in insert mode
    -- local opts = { noremap = true, silent = true }
    -- vim.keymap.set("i", "<C-[>", neogen.jump_prev, opts)
    -- vim.keymap.set("i", "<C-]>", neogen.jump_next, opts)
  end,
  -- Uncomment next line if you want to follow only stable versions
  -- version = "*"
}

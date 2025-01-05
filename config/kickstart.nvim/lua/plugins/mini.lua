return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      require('mini.sessions').setup()
      require('mini.starter').setup()

      require('mini.files').setup({
        windows = {
          preview = true,
          width_preview = 100,
        }
      })

      vim.keymap.set('n', '<leader>e', [[<Cmd>lua MiniFiles.open()<CR>]], { desc = 'Open [E]xplorer' })
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          vim.keymap.set("n", "<left>", require('mini.files').go_out, { buffer = buf_id })
          vim.keymap.set("n", "<right>", require('mini.files').go_in, { buffer = buf_id })
        end,
      })

      local move = require('mini.move')
      move.setup()

      -- replicate mini.move for arrow keys
      vim.keymap.set('x', '<M-left>', [[<Cmd>lua MiniMove.move_selection('left')<CR>]], { desc = 'Move left' })
      vim.keymap.set('x', '<M-right>', [[<Cmd>lua MiniMove.move_selection('right')<CR>]], { desc = 'Move right' })
      vim.keymap.set('x', '<M-down>', [[<Cmd>lua MiniMove.move_selection('down')<CR>]], { desc = 'Move down' })
      vim.keymap.set('x', '<M-up>', [[<Cmd>lua MiniMove.move_selection('up')<CR>]], { desc = 'Move up' })

      vim.keymap.set('n', '<M-left>', [[<Cmd>lua MiniMove.move_line('left')<CR>]], { desc = 'Move line left' })
      vim.keymap.set('n', '<M-right>', [[<Cmd>lua MiniMove.move_line('right')<CR>]], { desc = 'Move line right' })
      vim.keymap.set('n', '<M-down>', [[<Cmd>lua MiniMove.move_line('down')<CR>]], { desc = 'Move line down' })
      vim.keymap.set('n', '<M-up>', [[<Cmd>lua MiniMove.move_line('up')<CR>]], { desc = 'Move line up' })

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et

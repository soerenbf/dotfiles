require('neogit').setup {}
vim.keymap.set('n', '<leader>g', function()
  local git_dir = vim.fs.find('.git', { path = vim.fn.expand '%:p:h', upward = true })[1]
  require('neogit').open { cwd = git_dir and vim.fs.dirname(git_dir) or nil }
end, { desc = 'Neogit' })

vim.api.nvim_create_user_command('CodeDiff', function(event)
  vim.api.nvim_del_user_command 'CodeDiff'
  require('codediff').setup {}
  vim.cmd { cmd = 'CodeDiff', args = vim.split(event.args, '%s+', { trimempty = true }) }
end, { nargs = '*' })

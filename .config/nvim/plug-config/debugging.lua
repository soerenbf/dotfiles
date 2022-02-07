require("nvim-dap-virtual-text").setup()
require("dapui").setup()

vim.api.nvim_set_keymap('n', '<leader>dd', [[<cmd>lua require'dap'.continue() require'dapui'.open()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>dt', [[<cmd>lua require'dap'.toggle_breakpoint()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>dq', [[<cmd>lua require'dap'.close() require'dapui'.close()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-k>', [[<cmd>lua require'dap'.step_out()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-l>', [[<cmd>lua require'dap'.step_over()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-j>', [[<cmd>lua require'dap'.step_into()<CR>]], {noremap = true, silent = true})


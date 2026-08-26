require('snacks').setup {
  indent = { enabled = true },
  picker = {
    enabled = true,
    layout = 'ivy',
    ui_select = true,
    win = { input = { keys = { ['<Esc>'] = { 'close', mode = { 'n', 'i' } } } } },
  },
}

local picker = Snacks.picker
local maps = {
  { '<leader><leader>', function() picker.smart { layout = 'sidebar' } end, 'Smart find files' },
  { '<leader>,', function() picker.buffers { layout = 'sidebar' } end, 'Buffers' },
  { '<leader>.', picker.resume, 'Search resume' },
  { '<leader>:', picker.command_history, 'Command history' },
  { '<leader>/', function() picker.lines { layout = 'ivy_split' } end, 'Search buffer' },
  { '<leader>sn', picker.notifications, 'Notification history' },
  { '<leader>sk', picker.keymaps, 'Search keymaps' },
  { '<leader>sh', function() picker.help { layout = 'ivy_split' } end, 'Search help' },
  { '<leader>s/', function() picker.grep { layout = 'ivy_split' } end, 'Grep files' },
  { '<leader>sw', picker.grep_word, 'Grep word' },
  { '<leader>sg', function() picker.git_files { layout = 'sidebar' } end, 'Git files' },
  { 'gd', picker.lsp_definitions, 'Goto definition' },
  { 'go', picker.lsp_definitions, 'Goto definition' },
  { 'gD', picker.lsp_declarations, 'Goto declaration' },
  { 'gr', picker.lsp_references, 'Goto references' },
  { 'gI', picker.lsp_implementations, 'Goto implementation' },
  { 'gy', picker.lsp_type_definitions, 'Goto type definition' },
  { '<leader>ds', function() picker.lsp_symbols { layout = 'sidebar' } end, 'Document symbols' },
  { '<leader>ws', picker.lsp_workspace_symbols, 'Workspace symbols' },
  { '<leader>dd', function() picker.diagnostics_buffer { layout = 'ivy_split' } end, 'Document diagnostics' },
  { '<leader>wd', picker.diagnostics, 'Workspace diagnostics' },
}
for _, map in ipairs(maps) do
  vim.keymap.set('n', map[1], map[2], { desc = map[3] })
end

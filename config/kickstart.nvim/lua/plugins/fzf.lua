local map = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = 'Fzf: ' .. desc })
end

return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "echasnovski/mini.icons" },
  config = function(_, opts)
    local fzf = require 'fzf-lua'
    fzf.setup(opts)

    map('<leader>fh', fzf.helptags, '[F]ind [H]elp')
    map('<leader>fk', fzf.keymaps, '[F]ind [K]eymaps')
    map('<leader>ff', fzf.files, '[F]ind [F]iles')
    map('<leader>f?', fzf.builtin, '[F]ind Fzf command ("?" for help)')
    map('<leader>fw', fzf.grep_cword, '[F]ind current [W]ord')
    map('<leader>fg', fzf.live_grep_glob, '[F]ind by [G]rep')
    map('<leader>f.', fzf.resume, '[F]ind Resume ("." for repeat)')
    map('<leader>fr', fzf.oldfiles, '[F]ind [R]ecent Files')
    map('<leader><leader>', fzf.buffers, '[ ] Find existing buffers')
    map('<leader>/', fzf.blines, '[/] Search in current buffer')
  end
}

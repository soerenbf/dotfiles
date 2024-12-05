local map = function(keys, func, desc, opts)
  vim.keymap.set('n', keys, function() func(opts) end, { desc = 'Fzf: ' .. desc })
end

return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "echasnovski/mini.icons" },
  config = function(_, opts)
    local fzf = require 'fzf-lua'
    fzf.setup(opts)

    map('<leader>fh', fzf.helptags, '[F]ind [H]elp', { winopts = { fullscreen = true } })
    map('<leader>fk', fzf.keymaps, '[F]ind [K]eymaps')
    map('<leader>ff', fzf.files, '[F]ind [F]iles', { winopts = { fullscreen = true } })
    map('<leader>f?', fzf.builtin, '[F]ind Fzf command ("?" for help)')
    map('<leader>fw', fzf.grep_cword, '[F]ind current [W]ord')
    map('<leader>fg', fzf.live_grep_glob, '[F]ind by [G]rep', { winopts = { fullscreen = true } })
    map('<leader>f.', fzf.resume, '[F]ind Resume ("." for repeat)', { winopts = { fullscreen = true } })
    map('<leader>fr', fzf.oldfiles, '[F]ind [R]ecent Files', { winopts = { fullscreen = true } })
    map('<leader><leader>', fzf.buffers, '[ ] Find existing buffers', { winopts = { fullscreen = true } })
    map('<leader>/', fzf.blines, '[/] Search in current buffer',
      { winopts = { preview = { hidden = 'hidden' }, width = 120, height = 30 } })
  end
}

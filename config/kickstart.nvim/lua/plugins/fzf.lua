local map = function(keys, func, desc, opts)
  vim.keymap.set('n', keys, function() func(opts) end, { desc = 'Fzf: ' .. desc })
end

return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function(_, opts)
    local fzf = require 'fzf-lua'
    fzf.setup(opts)

    map('<leader>sh', fzf.helptags, '[S]earch [H]elp', { winopts = { fullscreen = true } })
    map('<leader>sk', fzf.keymaps, '[S]earch [K]eymaps')
    map('<leader>ss', fzf.files, '[S]earch files', { winopts = { fullscreen = true } })
    map('<leader>s?', fzf.builtin, '[S]earch Fzf command ("?" for help)')
    map('<leader>sw', fzf.grep_cword, '[S]earch current [W]ord')
    map('<leader>sg', fzf.live_grep_glob, '[S]earch by [G]rep', { winopts = { fullscreen = true } })
    map('<leader>s.', fzf.resume, '[S]earch Resume ("." for repeat)', { winopts = { fullscreen = true } })
    map('<leader>sr', fzf.oldfiles, '[S]earch [R]ecent Files', { winopts = { fullscreen = true } })
    -- map('<leader><leader>', fzf.buffers, '[ ] Search existing buffers', { winopts = { fullscreen = true } })
    map('<leader>/', fzf.blines, '[/] Search in current buffer',
      { winopts = { preview = { hidden = 'hidden' }, width = 120, height = 30 } })
  end
}

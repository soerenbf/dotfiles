-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.rust" },
  -- { import = "astrocommunity.pack.markdown" }, -- INFO: check `./plugins/pack/markdown.lua`
  -- { import = "astrocommunity.pack.html-css" }, -- INFO: check `./plugins/pack/html-css.lua`
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.json" },
  -- { import = "astrocommunity.pack.typescript" }, -- INFO: check `./plugins/pack/typescript`
  -- { import = "astrocommunity.pack.yaml" }, -- INFO: check `./plugins/pack/yaml.lua`
  -- { import = "astrocommunity.pack.swift" }, -- INFO: check `./plugins/pack/swift.lua`
  { import = "astrocommunity.pack.zig" },

  { import = "astrocommunity.colorscheme.nightfox-nvim" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.motion.mini-move" },
  { import = "astrocommunity.markdown-and-latex.peek-nvim" },
  { import = "astrocommunity.project.nvim-spectre" },
  { import = "astrocommunity.git.neogit" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },

  { import = "astrocommunity.recipes.telescope-lsp-mappings" },
  -- import/override with your plugins folder
}

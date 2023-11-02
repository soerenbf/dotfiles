return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.lua" },
  -- { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.docker" },
  -- { import = "astrocommunity.pack.typescript" },
  -- { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.zig" },

  { import = "astrocommunity.colorscheme.nightfox-nvim" },
  { import = "astrocommunity.motion.mini-move" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.project.nvim-spectre" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
}

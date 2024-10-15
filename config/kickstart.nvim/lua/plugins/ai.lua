local set_hl = vim.api.nvim_set_hl

---@function Function to convert RGB to hexadecimal
---@param rgb table The RGB color
---@return string hex The hexadecimal color
local function rgb_to_hex(rgb)
  return string.format("#%02x%02x%02x", rgb[1], rgb[2], rgb[3])
end

---@function Function to get the background color of a highlight group
---@param hlgroup string The name of the highlight group
---@return string|nil hex The background color of the highlight group
local function get_bg_color(hlgroup)
  local hl = vim.api.nvim_get_hl(0, { name = hlgroup, link = false })
  local bg = hl.bg
  if bg then
    return rgb_to_hex({
      bit.rshift(bit.band(bg, 0xFF0000), 16),
      bit.rshift(bit.band(bg, 0x00FF00), 8),
      bit.band(bg, 0x0000FF),
    })
  end
  return nil
end

local function setup_avante_highlights()
  -- Apply highlights for title
  set_hl(0, "AvanteTitle", { link = "Normal" })
  set_hl(0, "AvanteReversedTitle", {
    bg = get_bg_color("Normal"),
    fg = get_bg_color("Normal"),
  })
  -- Apply highlights for subtitle
  set_hl(0, "AvanteSubtitle", { link = "Normal" })
  set_hl(0, "AvanteReversedSubtitle", {
    bg = get_bg_color("Normal"),
    fg = get_bg_color("Normal"),
  })
  -- Apply highlights for prompt
  set_hl(0, "AvanteThirdTitle", { link = "Normal" })
  set_hl(0, "AvanteReversedThirdTitle", {
    bg = get_bg_color("Normal"),
    fg = get_bg_color("Normal"),
  })
  -- Apply highlights for hints
  set_hl(0, "AvanteInlineHint", { link = "LspDiagnosticsVirtualTextHint" })
  set_hl(0, "AvantePopupHint", { link = "DiagnosticVirtualTextHint" })
end

return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  opts = {
    -- add any opts here
    provider = "copilot",
    windows = {
      width = 40
    },
  },
  init = function()
    -- setup_avante_highlights()
  end,
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.icons",                    -- or echasnovski/mini.icons
    { "zbirenbaum/copilot.lua", config = true }, -- for provider='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}

-- SynVim TokyoNight Theme
-- A clean, dark Neovim theme with transparent background

return {
  "folke/tokyonight.nvim",
  lazy = true,

  opts = {
    style = "night",  -- night, storm, moon, or day
    transparent = true,
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      sidebars = "transparent",
      floats = "transparent",
    },
    sidebars = { "qf", "help", "NvimTree", "terminal" },
    hide_inactive_statusline = false,
    dim_inactive = true,
    lualine_bold = true,
  },

  config = function(_, opts)
    require("tokyonight").setup(opts)
  end,
}

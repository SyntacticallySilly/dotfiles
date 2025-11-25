-- SynVim Catppuccin Mocha Colorscheme Plugin
-- Soothing pastel theme with transparent background

return {
  "catppuccin/nvim",
  lazy = true,
  name = "catppuccin",

  opts = {
    flavour = "auto",
    transparent_background = true,

    integrations = {
      treesitter = true,
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      telescope = true,
      notify = true,
      which_key = true,
      indent_blankline = { enabled = true },
    },
  },

  config = function(_, opts)
    require("catppuccin").setup(opts)
  end,
}

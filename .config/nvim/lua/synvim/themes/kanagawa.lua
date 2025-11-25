-- SynVim Kanagawa Theme
return {
  "rebelot/kanagawa.nvim",
  lazy = true,
  
  opts = {
    transparent = true,
    theme = "wave",  -- wave, dragon, or lotus
    background = {
      dark = "wave",
      light = "lotus",
    },
  },
  
  config = function(_, opts)
    require("kanagawa").setup(opts)
  end,
}

-- SynVim Rose Pine Theme
return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
  
  opts = {
    variant = "auto",
    dark_variant = "main",
    styles = {
      transparency = true,
    },
  },
  
  config = function(_, opts)
    require("rose-pine").setup(opts)
  end,
}

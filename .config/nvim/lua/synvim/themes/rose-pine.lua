-- SynVim Rose Pine Theme
return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = true,
  
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

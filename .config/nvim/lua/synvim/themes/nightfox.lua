-- SynVim Nightfox Theme Family
return {
  "EdenEast/nightfox.nvim",
  lazy = true,
  
  opts = {
    options = {
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = "italic",
        keywords = "bold",
        types = "italic,bold",
      },
    },
  },
  
  config = function(_, opts)
    require("nightfox").setup(opts)
  end,
}

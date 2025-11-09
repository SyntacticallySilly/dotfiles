-- SynVim Nightfox Theme Family
return {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000,
  
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

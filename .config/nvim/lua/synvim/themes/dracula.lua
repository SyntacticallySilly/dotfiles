-- SynVim Dracula Theme
return {
  "Mofiqul/dracula.nvim",
  lazy = true,
  
  opts = {
    transparent_bg = true,
    show_end_of_buffer = true,
    italic_comment = true,
  },
  
  config = function(_, opts)
    require("dracula").setup(opts)
  end,
}

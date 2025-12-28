-- SynVim Monokai Pro Theme
return {
  "loctvl842/monokai-pro.nvim",
  lazy = true,
  
  opts = {
    transparent_background = true,
    terminal_colors = true,
    devicons = true,
    filter = "pro",  -- pro, octagon, ristretto, spectrum, classic, machine
    inc_search = "background",
    background_clear = {},
    plugins = {
      bufferline = { underline_selected = false },
      indent_blankline = { context_highlight = "default" },
    },
  },
  
  config = function(_, opts)
    require("monokai-pro").setup(opts)
  end,
}

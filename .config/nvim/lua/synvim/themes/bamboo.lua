-- SynVim Bamboo Theme
return {
  "ribru17/bamboo.nvim",
  lazy = true,
  
  opts = {
    transparent = true,
    style = "vulgaris",  -- vulgaris, multiplex, or light
    toggle_style_key = nil,
    toggle_style_list = { "vulgaris", "multiplex", "light" },
    code_style = {
      comments = { italic = true },
      keywords = {},
      functions = {},
      strings = {},
      variables = {},
    },
  },
  
  config = function(_, opts)
    require("bamboo").setup(opts)
  end,
}

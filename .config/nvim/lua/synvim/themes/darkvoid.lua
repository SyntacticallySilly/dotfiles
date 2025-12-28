-- SynVim Darkvoid Theme
-- Monochromatic dark theme with optional glow effect

return {
  "aliqyan-21/darkvoid.nvim",
  lazy = true,
  
  opts = {
    transparent = true,
    glow = false,  -- Set to true if you want the glow effect
    
    colors = {
      -- You can override colors here if needed
      bg = "#000000",
      fg = "#c0c0c0",
    },
    
    plugins = {
      -- Plugin integrations
      nvim_tree = true,
      telescope = true,
      which_key = true,
      nvim_cmp = true,
      gitsigns = true,
      lualine = true,
    },
  },
  
  config = function(_, opts)
    require("darkvoid").setup(opts)
  end,
}

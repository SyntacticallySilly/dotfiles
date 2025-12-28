-- SynVim Everforest Theme
return {
  "neanias/everforest-nvim",
  lazy = true,
  config = function()
    vim.g.everforest_background = "hard"  -- hard, medium, soft
    vim.g.everforest_transparent_background = 2  -- 0=no, 1=partial, 2=full
    vim.g.everforest_better_performance = 1
    
    require("everforest").setup({
      transparent_background_level = 2,
    })
  end,
}

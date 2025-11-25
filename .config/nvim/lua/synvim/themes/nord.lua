-- SynVim Nord Theme
-- Arctic, north-bluish color palette with transparent background

return {
  "shaunsingh/nord.nvim",
  lazy = true,
  config = function()
    vim.g.nord_contrast = true
    vim.g.nord_borders = false
    vim.g.nord_disable_background = true  -- Transparent background
    vim.g.nord_italic = false
    vim.g.nord_uniform_diff_background = true
    vim.g.nord_bold = false
    
    require("nord").set()
  end,
}

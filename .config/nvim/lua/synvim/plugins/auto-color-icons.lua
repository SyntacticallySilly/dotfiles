-- SynVim Tiny Devicons Auto Colors Plugin
-- Automatically colors devicons for better contrast

return {
  "rachartier/tiny-devicons-auto-colors.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  
  config = function()
    local devicons_colors = require("tiny-devicons-auto-colors")
    
    -- More aggressive contrast settings
    devicons_colors.setup({
      colors = nil,
      factors = {
        lightness = 2.2,  -- Increased from 1.75 for better visibility
        chroma = 1.5,     -- Increased for more vivid colors
        hue = 1.25,
      },
      cache = {
        enabled = true,
        path = vim.fn.stdpath("cache") .. "/tiny-devicons-auto-colors-cache.json",
      },
      autoreload = true,
    })

    -- Force update colors on theme change
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.fn.delete(vim.fn.stdpath("cache") .. "/tiny-devicons-auto-colors-cache.json")
        devicons_colors.setup()
      end,
    })
  end,
}

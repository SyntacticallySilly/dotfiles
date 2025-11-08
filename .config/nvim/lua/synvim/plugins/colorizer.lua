-- SynVim Colorizer Plugin
-- Highlight color codes (hex, rgb, hsl)

return {
  "norcalli/nvim-colorizer.lua",
  event = { "BufReadPre", "BufNewFile" },
  
  config = function()
    require("colorizer").setup({
      "*",  -- Apply to all filetypes
      css = { css = true },  -- Enable all CSS features for CSS files
    }, {
      RGB = true,       -- #RGB hex codes
      RRGGBB = true,    -- #RRGGBB hex codes
      RRGGBBAA = true,  -- #RRGGBBAA hex codes (with alpha)
      rgb_fn = true,    -- CSS rgb() and rgba() functions
      hsl_fn = true,    -- CSS hsl() and hsla() functions
      css = true,       -- Enable all CSS features
      css_fn = true,    -- Enable all CSS functions
      mode = "background",  -- Display mode (highlights background)
    })
  end,
}

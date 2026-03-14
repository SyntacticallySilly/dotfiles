return {
  "nvim-mini/mini.icons",
  lazy = false,
  config = function()
    -- Mini.icons - Replaces nvim-web-devicons
    require("mini.icons").setup({
      style = "glyph", -- 'glyph' or 'ascii'
      default = {},
      directory = {},
      extension = {},
      file = {},
      filetype = {},
      lsp = {},
      os = {},
    })
    -- Mock nvim-web-devicons for compatibility with other plugins
    require("mini.icons").mock_nvim_web_devicons()
  end
}

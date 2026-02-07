return {
  "levouh/tint.nvim",
  enabled = false,
  config = function()
    require("tint").setup({
      tint_bg_color = true,  -- Dim backgrounds
      tint = -60,
      transforms = {
        require("tint.transforms").tint_with_threshold(-120, "#1a1a1a", 120),  -- Stronger tint (-120), threshold from your bg color
        require("tint.transforms").saturate(0.3),
      },
      -- highlight_ignore_patterns = { "WinSeparator", "Status.*" },  -- Skip these
      window_ignore_function = function(winid)
        local bufid = vim.api.nvim_win_get_buf(winid)
        local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
        return buftype ~= ""  -- Ignore special buffers like NvimTree
      end,
    })
  end,
}

-- SynVim Bufferline Plugin
-- Minimal buffer tabs at bottom, above lualine

return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  version = "*",
  
  opts = {
    options = {
      mode = "buffers",  -- Show buffers, not tabs
      themable = true,
      
      -- Appearance
      indicator = {
        style = "none",  -- No indicator for minimal look
      },
      buffer_close_icon = "",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      
      -- Behavior
      always_show_bufferline = true,
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "center",
          separator = true,
        },
      },
      
      -- Separator (minimal thin lines)
      separator_style = "thin",
      
      -- Diagnostics
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
    },
  },
}

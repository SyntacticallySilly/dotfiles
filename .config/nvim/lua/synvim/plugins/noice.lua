-- SynVim Noice Plugin
-- Floating command bar and message UI

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  
  opts = {
    -- Floating cmdline UI (like LazyVim)
    cmdline = {
      enabled = true,
      view = "cmdline_popup",  -- Floating popup instead of bottom
      opts = {
        border = "rounded",
        size = {
          width = 60,
          height = "auto",
        },
      },
    },
    
    -- Messages UI
    messages = {
      enabled = true,
      view = "notify",
      view_error = "notify",
      view_warn = "notify",
    },
    
    -- Popup menu for completions
    popupmenu = {
      enabled = true,
      backend = "nui",
    },
    
    -- LSP progress indicator
    lsp = {
      progress = {
        enabled = true,
        view = "mini",
      },
      hover = {
        enabled = true,
      },
      signature = {
        enabled = true,
      },
    },
  },
}

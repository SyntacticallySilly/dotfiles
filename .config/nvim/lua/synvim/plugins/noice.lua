-- SynVim Noice Plugin
-- Floating command bar and search with wilder.nvim

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },

  opts = {
    -- Floating cmdline for commands
    cmdline = {
      enabled = true,
      view = "cmdline_popup",
      opts = {
        border = "rounded",
        size = {
          width = 60,
          height = "auto",
        },
        position = {
          row = "50%",  -- Center vertically
          col = "50%",  -- Center horizontally
        },
      },
      -- format = {
      --   --   cmdline = {
      --   --     kind = "command",
      --   --     pattern = "^:",
      --   --     icon = "  ",
      --   --     lang = "regex",
      --   --     view = "cmdline_popup"
      --   --   },
      --   -- Keep search floating too (not at bottom)
      --   search_down = {
      --     kind = "search",
      --     pattern = "^/",
      --     icon = " " ,
      --     lang = "regex",
      --   },
      --   search_up = {
      --     kind = "search",
      --     pattern = "^%?",
      --     icon = "󰈞 ",
      --     lang = "regex",
      --   },
      -- },
    },

    -- Messages UI
    messages = {
      enabled = true,
      view = "notify",
      view_error = "notify",
      view_warn = "notify",
    },

    popupmenu = {
      enabled = true,
      backend = "nui",
      kind_icons = {},
    },

    -- LSP progress
    lsp = {
      progress = {
        enabled = true,
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      view = "mini",
    },
    hover = {
      enabled = true,
    },
    signature = {
      enabled = true,
    },
  },

  presets = {
    bottom_search = true,  -- IMPORTANT: Don't use bottom search
    command_palette = true,  -- Don't combine cmdline and popupmenu
    long_message_to_split = true,
  },
},
}

-- ~/.config/nvim/lua/plugins/lualine.lua
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")

    lualine.setup({
      options = {
        theme = "catppuccin",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },  -- Rounded separators
        globalstatus = true,
        disabled_filetypes = { statusline = { "alpha" } },
      },
      sections = {
        lualine_a = { 
          { 
            "mode",
            separator = { left = "" },
            right_padding = 2,
          } 
        },
        lualine_b = { 
          "branch",
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
          },
        },
        lualine_c = { 
          {
            "filename",
            path = 1,
            symbols = {
              modified = "  ",
              readonly = " ",
              unnamed = "[No Name]",
            },
          },
          {
            "diagnostics",
            sources = { "nvim_lsp" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
          },
        },
        lualine_x = {
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = "#ff9e64" },
          },
          "encoding",
          "fileformat",
        },
        lualine_y = {
          {
            "filetype",
            colored = true,
            icon_only = false,
            icon = { align = "left" },
          },
          "progress",
        },
        lualine_z = { 
          { 
            "location",
            separator = { right = "" },
            left_padding = 2,
          } 
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "nvim-tree", "lazy", "mason" },
    })
  end,
}


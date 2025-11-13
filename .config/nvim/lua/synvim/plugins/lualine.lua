-- SynVim Lualine Plugin
-- Minimal statusline with time and battery

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "lewis6991/gitsigns.nvim",
    "massix/termux.nvim",
  },
  event = "VeryLazy",

  config = function()
    local lualine = require("lualine")

    -- Custom function to get truncated file path (3 levels)
    local function truncated_path()
      local path = vim.fn.expand("%:p")
      local home = vim.fn.expand("~")

      if path:find(home) then
        path = path:gsub(vim.pesc(home), "~")
      end

      local parts = {}
      for part in path:gmatch("[^/]+") do
        table.insert(parts, part)
      end

      local depth = math.min(3, #parts)
      local truncated = table.concat(parts, "/", #parts - depth + 1)

      if path:sub(1, 1) == "/" and truncated:sub(1, 1) ~= "/" then
        truncated = "/" .. truncated
      end

      return truncated
    end

    -- Mode icon map
    local mode_icons = {
      n = "󰆾",
      i = "",
      v = "󰩭",
      [""] = "󱊅",
      c = "󰘳",
      t = "",
    }

    -- Function to get theme name dynamically
    local function get_theme()
      local colorscheme = vim.g.colors_name

      local theme_map = {
        ["catppuccin-mocha"] = "catppuccin",
        ["tokyonight-night"] = "tokyonight",
        ["tokyonight-storm"] = "tokyonight",
        ["tokyonight-moon"] = "tokyonight",
        ["gruvbox"] = "gruvbox",
        ["nord"] = "nord",
        ["rose-pine"] = "rose-pine",
        ["rose-pine-main"] = "rose-pine",
        ["rose-pine-moon"] = "rose-pine",
        ["rose-pine-dawn"] = "rose-pine",
        ["kanagawa"] = "auto",
        ["kanagawa-wave"] = "auto",
        ["kanagawa-dragon"] = "auto",
        ["dracula"] = "dracula",
        ["everforest"] = "everforest",
        ["bamboo"] = "auto",
        ["nightfox"] = "nightfox",
        ["nordfox"] = "nightfox",
        ["duskfox"] = "nightfox",
        ["carbonfox"] = "nightfox",
        ["monokai-pro"] = "auto",
      }

      return theme_map[colorscheme] or "auto"
    end

    -- Battery component using termux.nvim
    local function battery_status()
      local ok, termux = pcall(require, "termux")
      if not ok then
        return ""
      end

      local battery = termux.battery.get_status()
      if not battery then
        return ""
      end

      local percent = battery.percentage or 0
      local status = battery.status or "Unknown"

      -- Battery icon based on percentage
      local icon
      if status == "CHARGING" then
        icon = "󱎗"
      elseif percent >= 90 then
        icon = "90"
      elseif percent >= 70 then
        icon = "70"
      elseif percent >= 50 then
        icon = "50"
      elseif percent >= 30 then
        icon = "30"
      elseif percent >= 10 then
        icon = "Low"
      else
        icon = ""
      end

      return string.format("%s %d%%", icon, percent)
    end

    -- Time component (12-hour format)
    local function current_time()
      return os.date("%I:%M %p")  -- 12-hour format with AM/PM
    end

    lualine.setup({
      options = {
        theme = get_theme(),
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = { "alpha", "dashboard", "startify" },
          tabline = {},
        },
      },

      sections = {
        -- Left: mode icon
        lualine_a = {
          {
            function()
              local mode = vim.fn.mode()
              return mode_icons[mode] or mode
            end,
            padding = { left = 1, right = 2 },
            color = "lualine_a_normal",
          },
        },

        -- Middle-left: git branch and diff
        lualine_b = {
          {
            "branch",
            icon = "󰘬",
            color = "lualine_b_normal",
          },
          {
            "diff",
            colored = true,
            symbols = { added = " ", modified = " ", removed = " " },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },

        -- Middle: truncated file path
        lualine_c = {
          {
            truncated_path,
            color = "lualine_c_normal",
            padding = { left = 1, right = 1 },
          },
        },

        -- Right side: buffer count, battery, time, filetype
        lualine_x = {
          {
            function()
              local total = #vim.fn.getbufinfo({buflisted = 1})
              return "󰓩 " .. total
            end,
            color = "lualine_x_normal",
          },
        },

        lualine_y = {
          {
            battery_status,
            color = "lualine_y_normal",
          },
          {
            current_time,
            color = "lualine_y_normal",
          },
        },

        lualine_z = {
          {
            "filetype",
            colored = true,
            icon_only = false,
            icon = { align = "left" },
            padding = { left = 1, right = 1 },
          },
        },
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            truncated_path,
            color = "lualine_c_inactive",
          },
        },
        lualine_x = {
          {
            "filetype",
            colored = true,
            icon_only = true,
          },
        },
        lualine_y = {},
        lualine_z = {},
      },
    })

    -- Auto-reload lualine when colorscheme changes
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        require("lualine").setup({
          options = {
            theme = get_theme(),
          },
        })
      end,
    })
  end,
}

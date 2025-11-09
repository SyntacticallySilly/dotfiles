-- SynVim Lualine Plugin
-- Minimal statusline with mode icon, git branch, truncated path, and filetype

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { 
    "nvim-tree/nvim-web-devicons",
    "lewis6991/gitsigns.nvim",
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
      n = "󰆾 ",
      i = " ",
      v = "󰩬 ",
      [""] = "󰫙 ",
      c = "󰘳 ",
      t = " ",
    }
    
    -- Function to get theme name dynamically
    local function get_theme()
      local colorscheme = vim.g.colors_name
      
      -- Map colorscheme names to lualine themes
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
    
    lualine.setup({
      options = {
        theme = get_theme(),  -- Dynamic theme
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
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
            padding = { left = 1, right = 1 },
            color = "lualine_a_normal",
          },
        },
        
        -- Middle-left: git branch and diff
        lualine_b = {
          {
            "branch",
            icon = "",
            color = "lualine_b_normal",
          },
          {
            "diff",
            colored = true,
            symbols = { added = " ", modified = " ", removed = " " },
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
        
        -- Right: buffer count
        lualine_x = {
          {
            function()
              local total = #vim.fn.getbufinfo({buflisted = 1})
              return "󰓩 " .. total
            end,
            color = "lualine_x_normal",
          },
        },
        
        -- Far right: filetype
        lualine_y = {
          {
            "filetype",
            colored = true,
            icon_only = false,
            icon = { align = "left" },
            padding = { left = 1, right = 1 },
          },
        },
        
        lualine_z = {},
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
            colored = false,
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
        -- Reload lualine with new theme
        require("lualine").setup({
          options = {
            theme = get_theme(),
          },
        })
      end,
    })
  end,
}
